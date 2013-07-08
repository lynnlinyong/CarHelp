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
    SYSTEM_STATUS_NORMAL = 0,      //救助者状态
    SYSTEM_STATUS_WAIT_HELP        //求助者,一键求助
}SYSTEM_STATUS;

@interface MainViewController : UIViewController<
                                                BMKSearchDelegate,
                                                BMKMapViewDelegate,
                                                DstPointCellDelegate,
                                                HelpCellDelegate,
                                                DstNoticeDelegate,
                                                UITableViewDelegate,
                                                UITableViewDataSource,
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
    BMKPointAnnotation    *meAnn;
    HelpCalloutAnnotation *meCalloutAnn;
    
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
