//
//  RssParser.m
//
//  Created by Neeku Shamekhi on 1/4/12.
//  Copyright 2012 __TGBS__. All rights reserved.
//

#import "RssParser.h"
#import "RssData.h"
#import "FarsiNumerals.h"
#import "NSString_StripHTML.h"
#import "TitleViewController.h"
//#import "CategoryData.h"


@implementation RssParser

@synthesize currentItem = _currentItem;
@synthesize currentItemValue = _currentItemValue;
@synthesize rssItems = _rssItems;
@synthesize delegate = _delegate;
@synthesize retrieverQueue = _retrieverQueue;
@synthesize selectedCategory;
@synthesize queue;
@synthesize imageURL;
@synthesize parseFinished;

- (id) init
{
    if (![super init])
    {
        return nil;
    }
    _rssItems = [[NSMutableArray alloc]init];
    
    queue = [NSOperationQueue new];
    return self;
    
}

- (NSOperationQueue *)retrieverQueue
{
    if (nil == _retrieverQueue)
    {
        _retrieverQueue = [[NSOperationQueue alloc] init];
        _retrieverQueue.maxConcurrentOperationCount = 1;
    }
    
    return _retrieverQueue;
}


- (void) startProcess
{
    SEL method = @selector (fetchAndParseRss);
    [[self rssItems] removeAllObjects];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:method object:nil];
    
    [self.retrieverQueue addOperation:op];

}

- (BOOL)fetchAndParseRss
{
    parsingNewsWithNumber = 0;
    @autoreleasepool {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //To suppress the leak in NSXMLParser.
    
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    NSString *file = [[NSBundle  mainBundle] pathForResource:@"CategoryPlist"
                                                      ofType:@"plist"];
    NSDictionary *item = [[NSDictionary alloc]initWithContentsOfFile:file];
    NSArray *array = [item objectForKey:@"Root"];
    NSURL *url = [NSURL URLWithString:
                  [[array objectAtIndex:[selectedCategory intValue]]objectForKey:@"URL"]];
    BOOL success = NO;
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:YES];
    [parser setShouldReportNamespacePrefixes:YES];
    [parser setShouldResolveExternalEntities:NO];
    success = [parser parse];
    
    return success;
    }

}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	if(nil != qualifiedName)
    {
		elementName = qualifiedName;
	}
    
    
	if ([elementName isEqualToString:@"item"]) 
    {
		self.currentItem = [[RssData alloc]init];
        parsingNewsWithNumber ++;
	}
    
    else if([elementName isEqualToString:@"title"] || 
          [elementName isEqualToString:@"description"] ||
          [elementName isEqualToString:@"link"] ||
          [elementName isEqualToString:@"guid"] ||
          [elementName isEqualToString:@"author"]||
          [elementName isEqualToString:@"pubDate"]) 
    {
        self.currentItemValue = [NSMutableString string];
    }
        
    else 
    {
        self.currentItemValue = nil;
    }
        
}
    


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
	if(nil != qName)
    {
		elementName = qName;
	}
	if([elementName isEqualToString:@"title"])
    {
    
        self.currentItem.title = [FarsiNumerals convertNumeralsToFarsi:self.currentItemValue];
        int titleLength = [self.currentItem.title length];
        int len = (titleLength > 70) ? 70: titleLength;
        self.currentItem.shortTitle = [self.currentItem.title substringWithRange:NSMakeRange(0, len)];
        

	}

    else if([elementName isEqualToString:@"link"])
    {
		self.currentItem.linkUrl = self.currentItemValue;
	}
    else if([elementName isEqualToString:@"guid"])
    {
		self.currentItem.guidUrl = self.currentItemValue;
	}
    else if ([elementName isEqualToString:@"author"])
    {
        self.currentItem.author = self.currentItemValue;
    }
    else if([elementName isEqualToString:@"pubDate"])
    {
		self.currentItem.pubDate = self.currentItemValue;
        self.currentItem.pubDate = [FarsiNumerals convertNumeralsToFarsi:self.currentItemValue];
	}
    else if([elementName isEqualToString:@"item"])
    {
		[[self rssItems] addObject:self.currentItem];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if(nil != self.currentItemValue){
		[self.currentItemValue appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    
    //_nshamekhi_ Grabs the whole content in CDATABlock. 
    NSMutableString *descriptionTagContent = [[NSMutableString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    
    //_nshamekhi_ Checks the tags to see if there are any images for the article, if so, sets a range with start and end index and grabs the string in between which is the image URL for the corresponding news item.

    if ([descriptionTagContent rangeOfString:@"img class=\"caption\" src="].location == NSNotFound) 
    {
        
        NSLog(@"no images");   
    }
    else
    {
        NSRange    startIndex = [descriptionTagContent rangeOfString: @"http://"];
        imageURL = [descriptionTagContent substringFromIndex:startIndex.location];
    
        NSRange    endIndex   = [imageURL rangeOfString: @"\""];
        imageURL = [imageURL substringToIndex:endIndex.location];
    
    
        //strat downloading image
        self.currentItem.mediaUrl = [NSString stringWithString:imageURL];
        NSArray *argArray = [NSArray arrayWithObjects:self.currentItem,
                         nil]; 
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
                                        initWithTarget:self
                                        selector:@selector(downloadingImage:)
                                        object:(id)argArray];
        [queue addOperation:operation]; 
    }
    
    //_nshamekhi_ Strips all HTML tags in the CDATABlock, and substrings 300 characters from the beginning to display as the intro text, or summary of the news in tableview cells in TitleViewController class.
    NSString *description = [descriptionTagContent stripHtml];

    if (description.length >= 300)
    {
        self.currentItem.shortDescription = [FarsiNumerals convertNumeralsToFarsi:[description substringToIndex:300]];
    }
    else 
    {
        self.currentItem.shortDescription = [FarsiNumerals convertNumeralsToFarsi:description];    
    }
    self.currentItem.fullDescription = [FarsiNumerals convertNumeralsToFarsi:description]; 
    
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"parseErrorOccurred");
    
	if(parseError.code != NSXMLParserDelegateAbortedParseError) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		[(id)[self delegate] performSelectorOnMainThread:@selector(processHasErrors)
                                              withObject:nil
                                           waitUntilDone:NO];
	}
}



- (void)parserDidEndDocument:(NSXMLParser *)parser {    
    NSLog(@"parserDidEndDocument");
    parseFinished = [[NSString  alloc] initWithFormat:@"%d", 1];
    
    parsingNewsWithNumber = 0;
    [(id)[self delegate] performSelectorOnMainThread:@selector(processCompleted)
                                          withObject:nil
                                       waitUntilDone:NO];

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)downloadingImage:(NSArray *)argumantArray {
    
    RssData* data;
    data=(RssData *)[argumantArray objectAtIndex:0];

    NSLog(@"beforeloadimage");
    
    NSData* imageData;
    
    if(data.image == nil)
    {
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[data mediaUrl]]];
        data.image = [UIImage  imageWithData:imageData];
        [(id)[self delegate] performSelectorOnMainThread:@selector(imageProcessCompleted)
                                              withObject:nil
                                           waitUntilDone:NO];
    }
    
    
}



@end
