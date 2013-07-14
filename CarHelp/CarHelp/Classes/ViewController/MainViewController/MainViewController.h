//
//  MainViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareData.h"

/**
 * 系统状态
 **/
typedef enum _TAG_SYSTEM_STATUS{
    SYSTEM_STATUS_NORMAL = 0,        //救助者状态
    SYSTEM_STATUS_WAIT_HELP,         //求助者,一键求助
    SYSTEM_STATUS_SEARCH_HELP,       //附近求助
    SYSTEM_STATUS_WAIT_SEARCH_HELP   //附近求助等待
}SYSTEM_STATUS;

/**
 * 地图Annotation类型
 **/
#define MAP_TYPE        @"MAP_TYPE"
typedef enum _TAG_MAP_TYPE{
    /**
     * 一键求助
     **/
    HELP_MAP_TYPE = 0,                  //一键求助
    HELP_CALL_OUT_MAP_TYPE,             //一键求助CallOut类型
    
    /**
     * 附近求助
     **/
    HELP_SEARCH_MAP_TYPE,               //附近求助
    HELP_SEAECH_CALL_OUT_MAP_TYPE,      //附近求助CallOut类型
    
    /**
     * 类型求助
     **/
    HELP_TYPE_MAP_TYPE,                 //类型求助
    HELP_TYPE_CALL_OUT_MAP_TYPE,        //类型求助Callout类型
}MAP_ANNOTATION_TYPE;

@interface MainViewController : UIViewController<
                                                BMKSearchDelegate,
                                                BMKMapViewDelegate,
                                                DstPointCellDelegate,
                                                HelpCalloutCellDelegate,
                                                HelpFriendCellDelegate,
                                                DstNoticeDelegate,
                                                UITableViewDelegate,
                                                UITableViewDataSource,
                                                UIActionSheetDelegate,
                                                NiftySearchViewDelegate,
                                                RMSwipeTableViewCellDelegate>
{
    BMKMapView      *mapView;
    
    /**
     * 查询
     **/
    BOOL            isSearch;
    BMKSearch       *searchPos;
    BMKAddrInfo     *curAddrInfo;
    BMKPlanResult   *planResult;
    NiftySearchView *searchView;
    DstCalloutAnnotation *dstAnn;
    UIViewController *curPopViewCtr;
    
    /**
     * 发起求助
     **/
//    BMKPointAnnotation    *meAnn;
//    CustomPointAnnotation   *meAnn;
//    HelpCalloutAnnotation   *meCalloutAnn;
    
    /**
     * 附近求助
     **/
//    HelpFriendCalloutAnnotation    *frdAnn;
    NSMutableArray      *frdArray;
    
    /**
     * 类型求助
     **/
    NSMutableArray      *helpArray;
    
    /**
     * 系统状态
     **/
    SYSTEM_STATUS   sysStatus;
    
    /**
     * 系统消息列表
     **/
    NSMutableArray   *noticeArray;
    UITableView      *noticeTab;
}

@property (nonatomic, retain) BMKMapView *mapView;
@end
