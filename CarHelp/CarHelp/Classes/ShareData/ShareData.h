//
//  ShareData.h
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#ifndef CarHelp_ShareData_h
#define CarHelp_ShareData_h

/**
 * Tecent Weibo
 **/
#ifndef WiressSDKDemoAppKey
#define WiressSDKDemoAppKey     @"801378247"
#endif

#ifndef WiressSDKDemoAppSecret
#define WiressSDKDemoAppSecret  @"a207035b5d2baa90a8320db0798f4127"
#endif

#ifndef REDIRECTURI
#define REDIRECTURI @"http://www.baidu.com"
#endif

#define TCWBAlertViewLogOutTag          100
#define TCWBAlertViewLogInTag           101


/**
 * Sina Weibo
 **/
#define kAppKey             @"2993155058"
#define kAppSecret          @"2ac13aa9f067aad4137324affc8b93b7"
#define kAppRedirectURI     @"http://www.sina.com"

/**
 * Baidu Map Key
 **/
#define kBaiduMapKey        @"36A24491E65A4AB6998857EF6EC072AD4295E113"

/**
 * Baidu Map Span
 **/
#define SPAN_LAT   0.01
#define SPAN_LONG  0.01

/**
 * Notice Center Name
 **/
#define NOTICE_MSG               @"NOTICE_MSG"
#define NOTICE_TYPE              @"NOTICE_TYPE"

typedef NS_ENUM(NSInteger, TAG_NOTICE_TYPE) {
    NOTICE_HELP = 0,                //一键求助
    NOTICE_CLOSE,                   //关闭
    NOTICE_HOLD_ON,                 //稍等
    NOTICE_SEND_MSG,                //发送求助
    NOTICE_CANCEL_MSG,              //取消帮助
    NOTICE_NEARBY_HELP,             //附近求助
    NOTICE_REQUEST_FRIEND_HELP,     //请求助友帮助
    NOTICE_REQUEST_FRIEND_HELP_END, //请求助友帮助超时
    NOTICE_HELP_TYPE,               //类型求助
    NOTICE_SEARCH_HELP_TYPE,        //扫描求助
    NOTICE_TEAM_JOURNEY,            //组团出游
    NOTICE_POSTATION_SHARE,         //位置分享
    NOTICE_POSTATION_SHAREING,      //马上分享位置
    NOTICE_LEAD,                    //导引
    NOTICE_INVISIBLE,               //隐身
    NOTICE_DISTURB,                 //勿扰模式
    NOTICE_GOTO_CHAT,               //会话
    NOTICE_GOTO_FRIEND_LIST,        //好友列表
};

/**
 * System Message Type
 **/
#define SYSTEM_MESSAGE_TYPE      @"SYSTEM_MESSAGE_TYPE"

typedef NS_ENUM(NSInteger, _TAG_SYSTEM_MESSAGE_TYPE) {
    SYSTEM_MESSAGE_WAIT_HELP = 0,           //等候帮助
    SYSTEM_MESSAGE_SEACHED_HELP,            //附近求助
    SYSTEM_MESSAGE_REQUEST_HELP             //请求助友帮助
};

/**
 * Help Type
 **/
#define HELP_TYPE                @"HELP_TYPE"

typedef enum _TAG_HELP_TYPE {
    HELP_ON_KEY = 0,            //一键求助
    HELP_STOP_CAR,              //泊车
    HELP_WATER,                 //加水
    HELP_TRAUMA_DRESS,          //外伤包扎
    HELP_CASUALTY_SALVATION,    //伤亡救助
    HELP_TYRE,                  //补胎
    HELP_OIL_FEED,              //给油
    HELP_OVER_CURRENT           //过电
}SHARE_HELP_TYPE;

#import "User.h"
#import "Cell.h"
#import "Team.h"
#import "UIGridView.h"
#import "DstPointCell.h"
#import "UserBoardView.h"
#import "SearchHelpCell.h"
#import "NiftySearchView.h"
#import "UIGridViewDelegate.h"
#import "DstCalloutAnnotation.h"
#import "NoticeWaitTableViewCell.h"
#import "DstCalloutAnnotationView.h"
#import "DstNoticeViewController.h"

#import "CustomPointAnnotation.h"

#import "HelpTypeCell.h"
#import "RequestHelpCell.h"
#import "HelpFriendCell.h"
#import "HelpCalloutCell.h"
#import "CalloutAnnotation.h"
#import "CalloutAnnotationView.h"

#import "AppDelegate.h"
#import "SplashLastView.h"
#import "DDMenuController.h"
#import "QRViewController.h"
#import "TeamTableViewCell.h"
#import "TeamViewController.h"
#import "LoginViewController.h"
#import "RegistViewController.h"
#import "SecureViewController.h"
#import "FriendsViewController.h"
#import "SettingViewController.h"
#import "ChatListViewController.h"
#import "ChatListViewController.h"
#import "HelpTypeViewController.h"
#import "ForgetPwdViewController.h"
#import "RegistSexViewController.h"
#import "RegistCarViewController.h"
#import "UpdatePwdViewController.h"
#import "HelpShareViewController.h"
#import "HelpSearchViewController.h"
#import "UserDetailViewController.h"
#import "RegistHeadViewController.h"
#import "MainSplashViewController.h"
#import "RegistUserViewController.h"
#import "HelpDetailViewController.h"
#import "TeamDetailViewController.h"
#import "HelpHistoryViewController.h"
#import "SettingHelpViewController.h"
#import "PackageMineViewController.h"
#import "PackageScanViewController.h"
#import "HelpContentViewController.h"
#import "PackageDetalViewController.h"
#import "FriendDetailViewController.h"
#import "HelpFriendListViewController.h"
#import "SharePostationViewController.h"
#import "SearchHelpMessageViewController.h"
#import "SettingSecureBoardViewController.h"
#import "SettingSecureDetailViewController.h"
#import "RegistDriverLicenseViewController.h"

#import "MenuViewController.h"
#import "MainViewController.h"
#endif
