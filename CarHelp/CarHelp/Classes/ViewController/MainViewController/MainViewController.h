//
//  MainViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<
                                                BMKSearchDelegate,
                                                BMKMapViewDelegate,
                                                NiftySearchViewDelegate>
{
    BMKMapView      *mapView;
    CLLocationCoordinate2D pastLoc;
    
    /**
     * 查询
     **/
    BMKSearch       *searchPos;
    BMKAddrInfo     *curAddrInfo;
    NiftySearchView *searchView;
    DstCalloutAnnotation *dstAnn;
}

@property (nonatomic, retain) BMKMapView *mapView;
@end
