//
//  Constant.h
//
//  Created by neeku shamekhi on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef Hamshahri_Tandorosti_Constant_h
#define Hamshahri_Tandorosti_Constant_h

// This URL is used in the App Delegate to get statistics of the application usage.
#define STATISTICS_URL @"http://statistics.tgbs.ir/ct/index.php?id=17"


#define NO_CONNECTION_ALERT_TITLE @"TractorFC"
#define NO_CONNECTION_ALERT_MESSAGE @"دسترسی به مطالب سایت مقدور نشد. لطفاً ارتباط اینترنت خود را بررسی نمایید."
#define NO_CONNECTION_ALERT_VIEW_DISMISS_BUTTON @"تایید"
#define NO_CONNECTION_ALERT_VIEW_COLOR colorWithRed:0.129 green:0.129 blue:0.129 alpha:0.8
#define NO_CONNECTION_ALERT_VIEW_STROKE_COLOR colorWithRed:0.9 green:0.001 blue:0.001 alpha:0.5

#define ABOUT_APP_TEXT @"برنامه کاربردی همشهری تندرستی توسط شرکت تدبیرگستران بهینه ساز و به سفارش موسسه همشهری طراحی و پیاده سازی شده است. طراحی و تولید این برنامه به منظور نمایش نسخه اینترنتی سایت این مجله در آیفون و آیپاد تاچ صورت گرفته و استفاده از آن منوط به وجود شبکه اینترنتی است. کلیه حقوق محتوای این برنامه متعلق به موسسه همشهری است. هرگونه استفاده از لوگو، طرح و کدهای این برنامه پیگرد قانونی دارد."



#define COLUMN_COUNT_P 2
#define COLUMN_COUNT_L 2
#define ITEM_SIZE      CGSizeMake(160,78);

#define PortraitRect CGRectMake(0, 0, 320, 460)
#define LandscapeRect CGRectMake(0, 0, 480, 300)

// The frame  of header view equal nib file
#define HEADER_FRAME  CGRectMake(0, 0, 320, 79)

// The frame of title view
#define TITLE_Frame  CGRectMake(10, 80, 300, 25)

// The frame of footer view
#define FOOTER_Frame  CGRectMake(0, 463, 320, 20)


// if the height of footer (FOOTER_Frame)changed, this value will change.
#define Y_ORIGIN_FOOTER  20

// if the height of header (HEADER_FRAME)changed, this value will change.
#define Y_ORIGIN_MAIN  79

//Portrait Width
#define P_WIDTH   320 

//Portrait Height
#define P_HEIGHT  480 

//Landscape Width
#define L_WIDTH  480

//Landscape Height
#define L_HEIGHT 320  

// Title label frame in tableview cell
#define TITLE_LABEL_FRAME  CGRectMake(10.0, 5.0, 215.0, 20.0)

// Date label frame in tableview cell
//#define DATE_LABEL_FRAME  CGRectMake(10.0, 2.0, 95.0, 20.0)

// Summary label frame in tableview cell
#define SUMMARY_LABEL_FRAME  CGRectMake(10.0, 25.0, 200.0, 70.0)

// Photo frame in tableview cell
#define PHOTO_FRAME  CGRectMake(218.0, 15.0, 90, 70)

// Info button position
#define INFO_BUTTON_POSITION CGRectMake(-20, 32, 68, 68)

//webview frame size
#define WEBVIEW_FRAME CGRectMake(0, 90, 320, 380)

//Table View Properties
#define TITLE_LABEL_FONT boldSystemFontOfSize:13.0
#define TITLE_LABEL_TEXT_COLOR colorWithRed:0.262 green:0.486 blue:0.286 alpha:1
#define TITLE_LABEL_BG_COLOR clearColor

#define SUMMARY_LABEL_FONT systemFontOfSize:13.0
#define SUMMARY_LABEL_TEXT_COLOR darkGrayColor
#define SUMMARY_LABEL_BG_COLOR clearColor

#define PHOTO_BG_COLOR whiteColor

#define SEPARATOR_FRAME     CGRectMake(0, 99, 320, 1)

#define TABLEVIEW_CONTENT_SIZE CGSizeMake(320, 127 * rowCount)

#define NO_CONTENT_WARNING_FRAME CGRectMake(0, 0, 480, 480)
#define NO_CONTENT_WARNING_FONT  italicSystemFontOfSize:17
#define NO_CONTENT_WARNING_BG_COLOR clearColor
#define NO_CONTENT_WARNING_MESSAGE @"در حال حاضر مطلبی برای نمایش وجود ندارد."




#endif
