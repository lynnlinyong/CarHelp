//
//  MainViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "MainViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController
@synthesize mapView = _mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void) viewDidUnload
{
    noticeTab.delegate   = nil;
    noticeTab.dataSource = nil;
    
    searchPos.delegate = nil;
    searchView.delegate = nil;
    _mapView.delegate = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [noticeArray removeAllObjects];
    [noticeArray release];
    
    [_mapView    release];
    [searchPos   release];
    [noticeTab   release];
    [curAddrInfo release];
    [searchView  release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Custom Action
- (void) initUI
{
    self.title = @"首页";

    //系统处于自然状态,用户为救助者身份
    sysStatus = SYSTEM_STATUS_NORMAL;

    curAddrInfo = nil;
    searchPos   = [[BMKSearch alloc]init];
    searchPos.delegate = self;
    
    _mapView = [[BMKMapView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(0, 0, 320, 420)]];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
    searchView = [[NiftySearchView alloc] initWithFrame:CGRectMake(0, -76, 320, 76/2)
                                              andIsOnly:YES];
    searchView.delegate = (id)self;
    [self.view addSubview:searchView];
    
    /**
     * 初始化消息列表
     **/
    noticeArray = [[NSMutableArray alloc]init];
    
    noticeTab = [[UITableView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(0, 0, 320, 0)]];
    noticeTab.delegate   = self;
    noticeTab.dataSource = self;
    noticeTab.backgroundColor = [UIColor clearColor];
    noticeTab.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:noticeTab];
    
    UIButton *locateMeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    locateMeBtn.tag = 0;
    [locateMeBtn setFrame:[UIView fitCGRect:CGRectMake(320-50, 250, 50, 30)]];
    [locateMeBtn setTitle:@"MyLoc"
                 forState:UIControlStateNormal];
    [locateMeBtn addTarget:self
                    action:@selector(doButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locateMeBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchBtn.tag = 1;
    [searchBtn setFrame:[UIView fitCGRect:CGRectMake(320-50, 290, 50, 30)]];
    [searchBtn setTitle:@"Search"
               forState:UIControlStateNormal];
    [searchBtn addTarget:self
                  action:@selector(doButtonClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    UIButton *keyHelp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    keyHelp.tag = 2;
    [keyHelp setFrame:[UIView fitCGRect:CGRectMake(10, 360, 50, 30)]];
    [keyHelp setTitle:@"help"
             forState:UIControlStateNormal];
    [keyHelp addTarget:self
                action:@selector(doButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keyHelp];
    
    UIButton *searchHelp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchHelp.tag = 3;
    [searchHelp setFrame:[UIView fitCGRect:CGRectMake(160-25, 360, 50, 30)]];
    [searchHelp setTitle:@"sp"
                forState:UIControlStateNormal];
    [searchHelp addTarget:self
                   action:@selector(doButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchHelp];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    shareBtn.tag = 4;
    [shareBtn setFrame:[UIView fitCGRect:CGRectMake(310-50, 360, 50, 30)]];
    [shareBtn addTarget:self
                 action:@selector(doButtonClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setTitle:@"share"
              forState:UIControlStateNormal];
    [self.view addSubview:shareBtn];
    
    /**
     * 注册消息通知
     **/
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(getNotice:)
                                                name:NOTICE_MSG
                                              object:nil];
}

- (void) showPost:(CLLocationCoordinate2D) dstLoc
{
    BMKCoordinateRegion region;
    region.center.latitude     = dstLoc.latitude;
    region.center.longitude    = dstLoc.longitude;
    region.span.latitudeDelta  = SPAN_LAT;
    region.span.longitudeDelta = SPAN_LONG;
    [_mapView setRegion:region];
}

- (void) showCallout:(BMKPointAnnotation *)ann
{
    [_mapView selectAnnotation:ann animated:YES];
}

- (void) cleanNearbyHelpFrdAnnotation
{
    NSMutableDictionary *helpDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:HELP_SEARCH_MAP_TYPE],MAP_TYPE, nil];
    NSMutableDictionary *helpCalloutDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:HELP_SEAECH_CALL_OUT_MAP_TYPE],MAP_TYPE, nil];
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    for (id<BMKAnnotation> tmp in array)
    {
        id frdAnn = [self searchAnnotation:helpDic];
        if (frdAnn)
        {
            [_mapView removeAnnotation:frdAnn];
            frdAnn = nil;
        }
        
        id frdCalloutAnn = [self searchAnnotation:helpCalloutDic];
        if (frdCalloutAnn)
        {
            [_mapView removeAnnotation:frdCalloutAnn];
            frdCalloutAnn = nil;
        }
    }
}

- (void) cleanAllAnnotation
{
    dstAnn = nil;
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
    
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
}

- (int) searchCell:(NSString *) timeId
{
    for (int i=0; i<noticeArray.count; i++)
    {
        NSDictionary *dic  = [noticeArray objectAtIndex:i];
        NSString *idString = [dic objectForKey:@"CURENT_TIME"];
        if ([idString isEqualToString:timeId])
        {
            return i;
        }
    }
    
    return -1;
}

- (id) searchAnnotation:(NSMutableDictionary *) idDic
{
    NSArray *anns = [_mapView annotations];
    for (id<BMKAnnotation> tmp in anns)
    {
        if ([tmp isKindOfClass:[CustomPointAnnotation class]])
        {
            NSNumber *dstType = [((CustomPointAnnotation *)tmp).idDic objectForKey:MAP_TYPE];
            NSNumber *srcType = [idDic objectForKey:MAP_TYPE];
            if ([srcType isEqualToNumber:dstType])
            {
                switch (srcType.intValue)
                {
                    case HELP_MAP_TYPE:                 //一键求助地图标注
                    {
                    }
                    case HELP_CALL_OUT_MAP_TYPE:        //一键求助CallOut标注
                    {
                        return tmp;
                    }
                    case HELP_SEARCH_MAP_TYPE:          //附近求助地图标注
                    {
//                        break;
                    }
                    case HELP_SEAECH_CALL_OUT_MAP_TYPE: //附近求助CallOut标注
                    {
                        return tmp;
                        break;
                    }
                    default:
                        break;
                }
            }
        }
    }
    
    return nil;
}

- (void) cleanHelpAnnotation
{
    NSMutableDictionary *helpDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:HELP_MAP_TYPE],MAP_TYPE, nil];
    NSMutableDictionary *helpCalloutDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:HELP_CALL_OUT_MAP_TYPE],MAP_TYPE, nil];
    
    id helpAnn = [self searchAnnotation:helpDic];
    if (helpAnn)
    {
        [_mapView removeAnnotation:helpAnn];
        helpAnn = nil;
    }
    
    id helpCalloutAnn = [self searchAnnotation:helpCalloutDic];
    if (helpCalloutAnn)
    {
        [_mapView removeAnnotation:helpCalloutAnn];
        helpCalloutAnn = nil;
    }
    
    _mapView.showsUserLocation = YES;
}

- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        //		NSLog ( @"%@" ,s);
		return s;
	}
	return nil ;
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"] autorelease];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
			
		}
			break;
		default:
			break;
	}
	
	return view;
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    UIButton *actBtn = (UIButton *)sender;
    switch (actBtn.tag)
    {
        case 0:         //自己位置
        {
            [self showPost:_mapView.userLocation.location.coordinate];
            break;
        }
        case 1:         //查询地点
        {
            if ([searchView.startTextField.text isEqualToString:NSLocalizedString(@"Current Location", nil)]) {
                searchView.startTextField.textColor = [UIColor blueColor];
            } else {
                searchView.startTextField.textColor = [UIColor blackColor];
            }
            if ([searchView.finishTextField.text isEqualToString:NSLocalizedString(@"Current Location", nil)]) {
                searchView.finishTextField.textColor = [UIColor blueColor];
            } else {
                searchView.finishTextField.textColor = [UIColor blackColor];
            }
            
            CGRect searchBarFrame = searchView.frame;
            searchBarFrame.origin.y = 0;
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 searchView.frame = searchBarFrame;
                             }
                             completion:^(BOOL completion) {
                                 [searchView.startTextField becomeFirstResponder];
                             }];
            break;
        }
        case 2:         //类型求助
        {
            HelpTypeViewController *hVc = [[HelpTypeViewController alloc]init];
            [self presentPopupViewController:hVc
                               animationType:MJPopupViewAnimationFade];
            break;
        }
        case 3:         //附近求助
        {
            HelpSearchViewController *hsVc = [[HelpSearchViewController alloc]init];
            [self presentPopupViewController:hsVc
                               animationType:MJPopupViewAnimationFade];
            break;
        }
        case 4:         //分享事件
        {
            HelpShareViewController *hsVc = [[HelpShareViewController alloc]init];
            [self presentPopupViewController:hsVc
                               animationType:MJPopupViewAnimationFade];
            break;
        }
        case 5:         //恢复PopView
        {
            actBtn.hidden = YES;
            [self presentPopupViewController:curPopViewCtr
                               animationType:MJPopupViewAnimationSlideMoveIn];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark - BMKMapViewDelegate
- (void) mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[CustomPointAnnotation class]])
    {
        CustomPointAnnotation *annn = (CustomPointAnnotation *)view.annotation;
        int mapType = ((NSNumber *)[annn.idDic objectForKey:MAP_TYPE]).intValue;
        switch (mapType)
        {
            case HELP_MAP_TYPE:             //一键求助
            {
                NSMutableDictionary *tmpDic = [annn.idDic mutableCopy];
                [tmpDic setObject:[NSNumber numberWithInt:HELP_CALL_OUT_MAP_TYPE]
                           forKey:MAP_TYPE];
                
                //创建搭载自定义calloutview的annotation
                CalloutAnnotation *meCalloutAnn = [[[CalloutAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude
                                                                   andLongitude:view.annotation.coordinate.longitude] autorelease];
                meCalloutAnn.idDic = [tmpDic mutableCopy];
                [_mapView addAnnotation:meCalloutAnn];
                [_mapView setCenterCoordinate:view.annotation.coordinate
                                     animated:YES];
                [tmpDic release];
                return;
                break;
            }
            case HELP_SEARCH_MAP_TYPE:     //附近求助
            {
                NSMutableDictionary *tmpDic = [annn.idDic mutableCopy];
                [tmpDic setObject:[NSNumber numberWithInt:HELP_SEAECH_CALL_OUT_MAP_TYPE]
                           forKey:MAP_TYPE];
                
                //创建搭载自定义calloutview的annotation
                CalloutAnnotation *meCalloutAnn = [[[CalloutAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude
                                                                                  andLongitude:view.annotation.coordinate.longitude] autorelease];
                meCalloutAnn.idDic = [tmpDic mutableCopy];
                [_mapView addAnnotation:meCalloutAnn];
                [_mapView setCenterCoordinate:view.annotation.coordinate
                                     animated:YES];
                [tmpDic release];
                return;
                break;
            }
            default:
                break;
        }
    }
    
    if ([view.annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        //如果点到了这个marker点,什么也不做
        if (dstAnn.coordinate.latitude == view.annotation.coordinate.latitude&& dstAnn.coordinate.longitude == view.annotation.coordinate.longitude)
        {
            return;
        }
        
        //如果当前显示着calloutview，又触发了select方法，删除这个calloutview annotation
        if (dstAnn)
        {
            [_mapView removeAnnotation:dstAnn];
            dstAnn = nil;
        }
        
        //创建搭载自定义calloutview的annotation
        dstAnn = [[[DstCalloutAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude
                                                    andLongitude:view.annotation.coordinate.longitude] autorelease];  //把通过marker(ZNBCPointAnnotation)设置的pointCalloutInfo信息赋值给CalloutMapAnnotation
        dstAnn.locationInfo = [NSDictionary dictionaryWithObject:view.annotation.title
                                                          forKey:@"dstLoc"];
        [_mapView addAnnotation:dstAnn];
        [_mapView setCenterCoordinate:view.annotation.coordinate
                            animated:YES];
    }
}

- (void) mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    if (dstAnn &&![view isKindOfClass:[DstCalloutAnnotation class]])
    {
//        if (dstAnn.coordinate.latitude == view.annotation.coordinate.latitude && dstAnn.coordinate.longitude == view.annotation.coordinate.longitude)
//        {
//            [_mapView removeAnnotation:dstAnn];
//            dstAnn = nil;
//        }
    }
    
    if ([view.annotation isKindOfClass:[CustomPointAnnotation class]])
    {
        CustomPointAnnotation *annn = (CustomPointAnnotation *)view.annotation;
        int mapType = ((NSNumber *)[annn.idDic objectForKey:MAP_TYPE]).intValue;
        switch (mapType)
        {
            case HELP_MAP_TYPE:             //一键求助
            {
                NSMutableDictionary *tmpDic = [annn.idDic mutableCopy];
                [tmpDic setObject:[NSNumber numberWithInt:HELP_CALL_OUT_MAP_TYPE]
                           forKey:MAP_TYPE];
                id mapAnn = [self searchAnnotation:tmpDic];
                if (mapAnn)
                {
                    [_mapView removeAnnotation:mapAnn];
                    mapAnn = nil;
                }
                [tmpDic release];
            }
            case HELP_SEARCH_MAP_TYPE:      //附近求助
            {
                NSMutableDictionary *tmpDic = [annn.idDic mutableCopy];
                [tmpDic setObject:[NSNumber numberWithInt:HELP_SEAECH_CALL_OUT_MAP_TYPE]
                           forKey:MAP_TYPE];
                id mapAnn = [self searchAnnotation:tmpDic];
                if (mapAnn)
                {
                    [_mapView removeAnnotation:mapAnn];
                    mapAnn = nil;
                }
                [tmpDic release];
            }
        }
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]])
    {
		return [self getRouteAnnotationView:_mapView
                          viewForAnnotation:(RouteAnnotation*)annotation];
	}
    else if ([annotation isKindOfClass:[CustomPointAnnotation class]])
    {
        CustomPointAnnotation *ann = (CustomPointAnnotation *)annotation;
        int mapType = ((NSNumber *)[ann.idDic objectForKey:MAP_TYPE]).intValue;
        switch (mapType)
        {
            case HELP_MAP_TYPE:             //一键求助地图标注
            {
                BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                           reuseIdentifier:@"myAnnotation"];
                newAnnotationView.pinColor       = BMKPinAnnotationColorRed;
                newAnnotationView.animatesDrop   = YES; //设置该标注点动画显示
                newAnnotationView.canShowCallout = NO;
                return newAnnotationView;
                break;
            }
            case HELP_CALL_OUT_MAP_TYPE:    //一键求助CallOut标注
            {
                //此时annotation就是我们calloutview的annotation
                CalloutAnnotation *ann = (CalloutAnnotation *)annotation;  //如果可以重用
                CalloutAnnotationView *annView = [[[CalloutAnnotationView alloc] initWithAnnotation:annotation
                                                                                            reuseIdentifier:@"calloutview"] autorelease];
                HelpCalloutCell *cell = [[HelpCalloutCell alloc]initWithFrame:CGRectMake(0, 0, annView.contentView.frame.size.width,
                                                                           annView.contentView.frame.size.height)];
                cell.idDic = ann.idDic;
                cell.delegate = self;
                [annView.contentView addSubview:cell];
                annView.callOutView = cell;
                
                return annView;
                break;
            }
            case HELP_SEARCH_MAP_TYPE:          //附近求助地图标注
            {
                BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                                           reuseIdentifier:@"myAnnotation"];
                newAnnotationView.pinColor       = BMKPinAnnotationColorRed;
                newAnnotationView.animatesDrop   = YES; //设置该标注点动画显示
                newAnnotationView.canShowCallout = NO;
                return newAnnotationView;
                break;
            }
            case HELP_SEAECH_CALL_OUT_MAP_TYPE: //附近求助CallOut标注
            {
                //此时annotation就是我们calloutview的annotation
                CalloutAnnotation *ann = (CalloutAnnotation *)annotation;  //如果可以重用
                CalloutAnnotationView *annView = [[[CalloutAnnotationView alloc] initWithAnnotation:annotation
                                                                                    reuseIdentifier:@"calloutview"] autorelease];
                annView.frame = CGRectMake(0, 0, 240, 200);
                annView.centerOffset = CGPointMake(0, -125);
                annView.contentView.frame = CGRectMake(0, 0, 240, 200);
                HelpFriendCell *cell = [[HelpFriendCell alloc]initWithFrame:CGRectMake(0, 0, annView.contentView.frame.size.width,
                                                                                         annView.contentView.frame.size.height)];
                cell.idDic = ann.idDic;
//                cell.delegate = self;
                [annView.contentView addSubview:cell];
                annView.callOutView = cell;
                
                return annView;
                break;
            }
            default:
                break;
        }
    }
//    else if (meAnn == annotation)
//    {
//        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
//                                                                                   reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor       = BMKPinAnnotationColorRed;
//        newAnnotationView.animatesDrop   = YES; //设置该标注点动画显示
//        newAnnotationView.canShowCallout = NO;
//        return newAnnotationView;
//    }
//    else if ([annotation isKindOfClass:[HelpFriendCalloutAnnotation class]])
//    {
//        //此时annotation就是我们calloutview的annotation
//        HelpFriendCalloutAnnotation *ann = (HelpFriendCalloutAnnotation *)annotation;  //如果可以重用
//        HelpFriendAnnotationView *annView = [[[HelpFriendAnnotationView alloc] initWithAnnotation:annotation
//                                                                                    reuseIdentifier:@"calloutview"] autorelease];
//        HelpFriendCell *cell = [[HelpFriendCell alloc]initWithFrame:CGRectMake(0, 0, annView.contentView.frame.size.width,
//                                                                   annView.contentView.frame.size.height)];
////        cell.locationInfo = [ann.locationInfo copy];
////        cell.delegate = self;
//        [annView.contentView addSubview:cell];
//        annView.helpFrdCell = cell;
//        
//        return annView;
//    }
//    else if ([annotation isKindOfClass:[HelpCalloutAnnotation class]])
//    {
//        //此时annotation就是我们calloutview的annotation
//        HelpCalloutAnnotation *ann = (HelpCalloutAnnotation *)annotation;  //如果可以重用
//        HelpCalloutAnnotationView *annView = [[[HelpCalloutAnnotationView alloc] initWithAnnotation:annotation
//                                                                                    reuseIdentifier:@"calloutview"] autorelease];
//        HelpCell *cell = [[HelpCell alloc]initWithFrame:CGRectMake(0, 0, annView.contentView.frame.size.width,
//                                                                   annView.contentView.frame.size.height)];
//        cell.locationInfo = [ann.locationInfo copy];
//        cell.delegate = self;
//        [annView.contentView addSubview:cell];
//        annView.helpCell = cell;
//        
//        return annView;
//    }
    else if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        CDLog(@"DST:%f,%f", [annotation coordinate].latitude,
                            [annotation coordinate].longitude);
        
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                                   reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor       = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop   = YES; //设置该标注点动画显示
        newAnnotationView.canShowCallout = NO;
        return newAnnotationView;
    }
    else if ([annotation isKindOfClass:[DstCalloutAnnotation class]])
    {
        //此时annotation就是我们calloutview的annotation
        DstCalloutAnnotation *ann = (DstCalloutAnnotation *)annotation;  //如果可以重用
        DstCalloutAnnotationView *annView = (DstCalloutAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"calloutview"];
        //否则创建新的calloutView
        if (!annView)
        {
            annView = [[[DstCalloutAnnotationView alloc] initWithAnnotation:annotation
                                                            reuseIdentifier:@"calloutview"] autorelease];
            DstPointCell *cell = [[DstPointCell alloc]initWithFrame:CGRectMake(0, 0, annView.contentView.frame.size.width, annView.contentView.frame.size.height)];
            cell.delegate = self;
            [annView.contentView addSubview:cell];
            annView.dstPointCell = cell;
        }
        //开始设置添加marker时的赋值
        annView.dstPointCell.dstLab.text = [ann.locationInfo objectForKey:@"dstLoc"];
        return annView;
    }
    
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    NSLog(@"- (void)mapView:viewForOverlay:->param:%@,%@", map, overlay);
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[[BMKPolylineView alloc] initWithOverlay:overlay] autorelease];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
	return nil;
}

#pragma mark -
#pragma mark - BMKUserLocationDelegate
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}

/**
 *用户位置更新后,会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    static BOOL isFirst = YES;
	if (userLocation != nil) {

        if (isFirst)
        {
            NSLog(@"%f %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
            isFirst = NO;
            
            //显示区域
            [self showPost:userLocation.location.coordinate];

            //获得地理编码
            while (![searchPos reverseGeocode:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude)])
            {
                CDLog(@"ERROR:Func:%s, LINE:%d", __func__, __LINE__);
            }
        }
	}
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

#pragma mark -
#pragma mark - NiftySearchView Delegate Methods
- (void)startBookmarkButtonClicked:(UITextField *)textField
{
    CDLog(@"startBookmarkButtonClicked");
}

- (void)finishBookmarkButtonClicked:(UITextField *)textField
{
    CDLog(@"finishBookmarkButtonClicked");
}

- (void)niftySearchViewResigend
{
    CDLog(@"resignSearchView");
    [self hideSearchBar:self];
}

- (void)routeButtonClicked:(UITextField *)startTextField
           finishTextField:(UITextField *)finishTextField
{
    if ([startTextField.text isEqualToString:@""])
    {
        CDLog(@"It's Emputy!");
        return;
    }
    
    NSString *city = @"深圳";
    if (curAddrInfo)
    {
        city = curAddrInfo.addressComponent.city;
        CDLog(@"city:%@", city);
    }
    
    //正在查询地点
    isSearch = YES;
    [searchPos geocode:startTextField.text
              withCity:city];
}

- (IBAction)hideSearchBar:(id)sender
{
    [searchView.startTextField  resignFirstResponder];
    [searchView.finishTextField resignFirstResponder];
    CGRect searchBarFrame   = searchView.frame;
    searchBarFrame.origin.y = -76;
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         searchView.frame = searchBarFrame;
                     }
                     completion:^(BOOL completion){
                         
                     }];
}

#pragma mark -
#pragma mark - BMKSearchDelegate 
- (void) onGetAddrResult:(BMKAddrInfo *)result errorCode:(int)error
{
    CDLog(@"%s", __func__);
    [self cleanAllAnnotation];
	if (error == 0)
    {
        if (!curAddrInfo)
        {
            curAddrInfo = [result retain];
        }
        
        //表示正在查询地点
        if (isSearch)
        {
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = result.geoPt;
            item.title = result.strAddr;
            [_mapView addAnnotation:item];
            [self performSelector:@selector(showCallout:)
                       withObject:item
                       afterDelay:0.1];
            [item release];
            
            CDLog(@"result:%@, %@",result.strAddr, result.addressComponent.city);
            CDLog(@"geoPt:%f, %f", result.geoPt.latitude, result.geoPt.longitude);
            
            //显示当前标注区域
            [self showPost:result.geoPt];
        }
	}
    else
    {
        if (!curAddrInfo)
        {
            //获得地理编码
            [searchPos reverseGeocode:_mapView.userLocation.location.coordinate];
        }
    }
}

- (void) onGetDrivingRouteResult:(BMKPlanResult *)result errorCode:(int)error
{
    CDLog(@"%s", __func__);
    
    if (error == BMKErrorOk)
    {
        planResult = nil;
        planResult = [result retain];
        
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
		int distance = ((BMKRoute *)[plan.routes objectAtIndex:0]).distance;
        
        DstNoticeViewController *dcvc = [[DstNoticeViewController alloc]init];
        dcvc.delegate  = self;
        dcvc.resultDic = [NSDictionary dictionaryWithObjectsAndKeys:dstAnn.locationInfo,@"Distnation", [NSNumber numberWithInt:distance], @"Distance", nil];
        [self presentPopupViewController:dcvc
                           animationType:MJPopupViewAnimationFade];
        curPopViewCtr = dcvc;
    }
}

#pragma mark - 
#pragma mark - DstNoticeDelegate
- (void) viewController:(DstNoticeViewController *) viewController
                 sender:(id)sender
{
    //NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    //[_mapView removeAnnotations:array];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
	NSArray *array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
 
    BMKRoutePlan* plan = (BMKRoutePlan*)[planResult.plans objectAtIndex:0];
    CDLog(@"distece:%d", ((BMKRoute *)[plan.routes objectAtIndex:0]).distance);
    
    RouteAnnotation* item = [[RouteAnnotation alloc]init];
    item.coordinate = planResult.startNode.pt;
    //		item.title = @"起点";
    item.type = 0;
    [_mapView addAnnotation:item];
    [item release];
    
    int index = 0;
    int size = [plan.routes count];
    for (int i = 0; i < 1; i++) {
        BMKRoute* route = [plan.routes objectAtIndex:i];
        for (int j = 0; j < route.pointsCount; j++) {
            int len = [route getPointsNum:j];
            index += len;
        }
    }
    
    BMKMapPoint* points = new BMKMapPoint[index];
    index = 0;
    
    for (int i = 0; i < 1; i++) {
        BMKRoute* route = [plan.routes objectAtIndex:i];
        for (int j = 0; j < route.pointsCount; j++) {
            int len = [route getPointsNum:j];
            BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
            memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
            index += len;
        }
        size = route.steps.count;
        for (int j = 0; j < size; j++) {
            BMKStep* step = [route.steps objectAtIndex:j];
            item = [[RouteAnnotation alloc]init];
            item.coordinate = step.pt;
            item.title = step.content;
            item.degree = step.degree * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            [item release];
        }
        
    }
    
    item = [[RouteAnnotation alloc]init];
    item.coordinate = planResult.endNode.pt;
    item.type = 1;
    //		item.title = @"终点";
    [_mapView addAnnotation:item];
    [item release];
    BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
    [_mapView addOverlay:polyLine];
    delete []points;
}

#pragma mark -
#pragma mark - HelpFriendCellDelegate
- (void) helpFriendCell:(HelpFriendCell *)cell index:(int)index
{
    switch (index)
    {
        case 0:         //关闭
        {
            break;
        }
        case 1:         //查看助友详细资料
        {
            break;
        }
        case 2:         //请求助友帮助
        {
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark - HelpCellDelegate
- (void) helpCallOutCell:(HelpCalloutCell *)cell ClickedIndex:(int)index
{
    switch (index)
    {
        case 0:         //重新请求求助
        {
            //先取消当前请求
            [self helpCallOutCell:cell ClickedIndex:2];
            
            //重新发送求助
            NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:NOTICE_SEND_MSG],
                                     NOTICE_TYPE, nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                object:nil
                                                              userInfo:infoDic];
            break;
        }
        case 1:         //求助详情
        {
            HelpContentViewController *hVc = [[HelpContentViewController alloc]init];
            [self presentPopupViewController:hVc
                               animationType:MJPopupViewAnimationFade];
            break;
        }
        case 2:         //取消求助
        {
            NSDictionary *infoDic = cell.idDic;
            if (infoDic)
            {
                int res = [self searchCell:[infoDic objectForKey:@"CURENT_TIME"]];
                if (res >= 0)
                {
                    NoticeWaitTableViewCell *cell = (NoticeWaitTableViewCell *)[noticeTab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:res inSection:0]];
                    
                    //取消帮助
                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:NOTICE_CANCEL_MSG],
                                             NOTICE_TYPE,cell.idDic,@"ID_DIC", nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                        object:nil
                                                                      userInfo:infoDic];
                }
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark - DstPointCellDelegate
- (void) CellView:(DstPointCell *)cell ClickedIndex:(int) index
{
    switch (index)
    {
        case 0:     //取消查询
        {
            [self cleanAllAnnotation];
            break;
        }
        case 1:     //到这里去
        {
            BMKPlanNode* start = [[BMKPlanNode alloc]init];
            start.pt = _mapView.userLocation.coordinate;
            
            BMKPlanNode* end = [[BMKPlanNode alloc]init];
            end.pt = dstAnn.coordinate;
            
            BOOL flag = [searchPos drivingSearch:nil
                                       startNode:start
                                         endCity:nil
                                         endNode:end];
            if (!flag)
            {
                CDLog(@"ERROR:%s, LINE:%d", __func__, __LINE__);
            }
            [start release];
            [end release];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark - NoticeCenter
- (void) getNotice:(NSNotification *)notification
{
    NSDate *dateNow = [NSDate date];
    NSString *dateString = [NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
    NSDictionary *dic  = [notification userInfo];
    NSNumber *noticeID = [dic objectForKey:NOTICE_TYPE];
    switch (noticeID.intValue)
    {
        case NOTICE_HELP:         //一键求助
        {
            [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
            SearchHelpMessageViewController *sVc = [[SearchHelpMessageViewController alloc]init];
            sVc.titleStr = @"一键求助";
            [self presentPopupViewController:sVc
                               animationType:MJPopupViewAnimationFade];
            curPopViewCtr = sVc;
            break;
        }
        case NOTICE_CLOSE:       //关闭ModelView
        {
            [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
            break;
        }
        case NOTICE_HOLD_ON:     //稍后
        {
            [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideMoveStop];
            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            backBtn.tag   = 5;
            backBtn.frame = [UIView fitCGRect:CGRectMake(0, 414/2-40/2, 40, 40)];
            [backBtn setTitle:@"Msg" forState:UIControlStateNormal];
            [backBtn addTarget:self
                        action:@selector(doButtonClicked:)
              forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:backBtn];
            break;
        }
        case NOTICE_SEND_MSG:     //发送求助
        {
            sysStatus = SYSTEM_STATUS_WAIT_HELP;
            _mapView.showsUserLocation = NO;
            
            CDLog(@"dateString:%@", dateString);
            //封装消息
            NSMutableDictionary *msgDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                        [NSNumber numberWithInt:SYSTEM_MESSAGE_WAIT_HELP],
                                                        SYSTEM_MESSAGE_TYPE,
                                                        [NSNumber numberWithInt:HELP_MAP_TYPE],
                                                        MAP_TYPE,
                                                        dateString,
                                                        @"CURENT_TIME", nil];
            [noticeArray addObject:msgDic];
            [noticeTab reloadData];
            
            CustomPointAnnotation *meAnn = [[CustomPointAnnotation alloc]init];
            meAnn.idDic = msgDic;
            meAnn.title = dateString;
            meAnn.coordinate = _mapView.userLocation.coordinate;
            [_mapView addAnnotation:meAnn];
            
            [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
            break;
        }
        case NOTICE_CANCEL_MSG:   //取消一键求助
        {
            //删除NoticeCell
            NSDictionary *idDic = [dic objectForKey:@"ID_DIC"];
            if (idDic)
            {
                int res = [self searchCell:[idDic objectForKey:@"CURENT_TIME"]];
                if (res >= 0)
                {
                    sysStatus = SYSTEM_STATUS_NORMAL;
                    
                    //删除地图Annotation
                    [self cleanHelpAnnotation];
                    
                    //停止计时
                    NoticeWaitTableViewCell *cell = (NoticeWaitTableViewCell *)[noticeTab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:res inSection:0]];
                    [cell cancelWaitHelp];
                    
                    //删除数据源
                    [noticeArray removeObjectAtIndex:res];  //移除数据源的数据
                    [noticeTab beginUpdates];
                    [noticeTab deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:res inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
                    [noticeTab endUpdates];
                }
            }
            
            break;
        }
        case NOTICE_SEACH_HELP:     //附近求助
        {
            sysStatus = SYSTEM_STATUS_SEARCH_HELP;
            
            //封装消息
            NSMutableDictionary *msgDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [NSNumber numberWithInt:SYSTEM_MESSAGE_SEACHED_HELP],
                                           SYSTEM_MESSAGE_TYPE,
                                           [NSNumber numberWithInt:HELP_SEARCH_MAP_TYPE],
                                           MAP_TYPE,
                                           dateString,
                                           @"CURENT_TIME",nil];
            [noticeArray addObject:msgDic];
            [noticeTab reloadData];
            
            /**
             * 显示助友地图标注
             **/
            double lat = _mapView.userLocation.coordinate.latitude;
            double log = _mapView.userLocation.coordinate.longitude;
            
            Friend *frd   = [[Friend alloc]init];
            frd.userName  = @"张三";
            frd.accountId = @"1234567";
            frd.goodSkills= @"加水";
            frd.helpCount = 1;
            frd.isFastFrd = NO;
            frd.head  = @"boy_1";
            frd.score = 500;
            frd.honre = 10;
            frd.packagePercent = 0.3;
            
            NSMutableDictionary *objDic = [msgDic mutableCopy];
            [objDic setObject:frd forKey:@"USER"];
            CustomPointAnnotation *cAnn =[[CustomPointAnnotation alloc]init];
            cAnn.idDic = objDic;
            cAnn.coordinate = CLLocationCoordinate2DMake(lat-0.003, log-0.002);
            [_mapView addAnnotation:cAnn];
            
            Friend *frd1   = [[Friend alloc]init];
            frd1.userName  = @"李四";
            frd1.accountId = @"1234567";
            frd1.goodSkills= @"加水";
            frd1.helpCount = 1;
            frd1.isFastFrd = NO;
            frd1.head  = @"boy_1";
            frd1.score = 500;
            frd1.honre = 10;
            frd1.packagePercent = 0.3;
            
            NSMutableDictionary *objDic1 = [msgDic mutableCopy];
            [objDic1 setObject:frd1 forKey:@"USER"];
            CustomPointAnnotation *cAnn1 =[[CustomPointAnnotation alloc]init];
            cAnn1.idDic = objDic1;
            cAnn1.coordinate = CLLocationCoordinate2DMake(lat+0.004, log+0.005);
            [_mapView addAnnotation:cAnn1];
            
            Friend *frd2   = [[Friend alloc]init];
            frd2.userName  = @"王五";
            frd2.accountId = @"1234567";
            frd2.goodSkills= @"加水";
            frd2.helpCount = 1;
            frd2.isFastFrd = NO;
            frd2.head  = @"boy_1";
            frd2.score = 500;
            frd2.honre = 10;
            frd2.packagePercent = 0.3;
            
            NSMutableDictionary *objDic2 = [msgDic mutableCopy];
            [objDic2 setObject:frd2 forKey:@"USER"];
            CustomPointAnnotation *cAnn2 =[[CustomPointAnnotation alloc]init];
            cAnn2.idDic = objDic2;
            cAnn2.coordinate = CLLocationCoordinate2DMake(lat+0.0035, log+0.002);
            [_mapView addAnnotation:cAnn2];
            
            [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
            break;
        }
//        case 5:     //泊车
//        {
//            break;
//        }
//        case 6:     //加水
//        {
//            break;
//        }
//        case 7:     //外伤包扎
//        {
//            break;
//        }
//        case 8:     //伤亡求助
//        {
//            break;
//        }
//        case 9:     //补胎
//        {
//            break;
//        }
//        case 10:    //给油
//        {
//            break;
//        }
//        case 11:    //过电
//        {
//            break;
//        }
//        case 12:    //扫描求助
//        {
//            break;
//        }
//        case 13:    //组团出游
//        {
//            break;
//        }
//        case 14:    //位置分享
//        {
//            break;
//        }
//        case 15:    //导引
//        {
//            break;
//        }
//        case 16:    //隐身
//        {
//            break;
//        }
//        case 17:    //勿扰模式
//        {
//            break;
//        }
//        case 18:    //对话
//        {
//            break;
//        }
//        case 19:    //好友列表
//        {
//            break;
//        }
//        case 20:    //堵车
//        {
//            break;
//        }
//        case 21:    //事故
//        {
//            break;
//        }
//        case 22:    //危险
//        {
//            break;
//        }
//        case 23:    //摄像头
//        {
//            break;
//        }
//        case 24:    //地图聊天
//        {
//            break;
//        }
//        case 25:    //修路
//        {
//            break;
//        }
//        case 26:    //此路不通
//        {
//            break;
//        }
//        case 27:    //开启乘车安全
//        {
//            break;
//        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark - UITableViewDelegate and UITableViewDataSource
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (noticeArray.count <= 3)
    {
        CGRect tabRect  = noticeTab.frame;
        tabRect.size.height = noticeArray.count*60;
        [noticeTab setUserInteractionEnabled:YES];
        if (noticeArray.count == 0)
        {
            [noticeTab setUserInteractionEnabled:NO];
            tabRect.size.height = 60;
        }
        noticeTab.frame = tabRect;
    }
    
    return noticeArray.count;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    NSDate *date = [NSDate date];
    NSMutableDictionary *msgDic = [noticeArray objectAtIndex:indexPath.row];
    if (msgDic)
    {
        NSNumber *msgType = [msgDic objectForKey:SYSTEM_MESSAGE_TYPE];
        switch (msgType.intValue)
        {
            case SYSTEM_MESSAGE_WAIT_HELP:      //等候救助
            {
                NSString *idString = [((NSDictionary *)[noticeArray objectAtIndex:indexPath.row]) objectForKey:@"CURENT_TIME"];
                NoticeWaitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
                if (!cell)
                {
                   cell = [[[NoticeWaitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                            
                                                                               reuseIdentifier:idString]autorelease];
                    cell.idDic = [[noticeArray objectAtIndex:indexPath.row] copy];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell setBackGroupColor:[UIColor clearColor]];
                    cell.delegate = self;
                }
        
                return cell;
                break;
            }
            case SYSTEM_MESSAGE_SEACHED_HELP:   //寻求帮助
            {
                NSString *idString = [((NSDictionary *)[noticeArray objectAtIndex:indexPath.row]) objectForKey:@"CURENT_TIME"];
                SearchHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
                if (!cell)
                {
                    cell = [[[SearchHelpCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:idString]autorelease];
                    cell.idDic = [[noticeArray objectAtIndex:indexPath.row] copy];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell setBackGroupColor:[UIColor clearColor]];
                    cell.delegate = self;
                }
                
                return cell;
                break;
            }
            default:
                break;
        }
    }
    
    return nil;
}

#pragma mark -
#pragma mark - SwipeTableViewCell Delegate

-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell *)swipeTableViewCell {
#if LOG_DELEGATE_METHODS
    NSLog(@"swipeTableViewCellDidStartSwiping: %@", swipeTableViewCell);
#endif
}

-(void)swipeTableViewCell:(RMSwipeTableViewCell *)swipeTableViewCell didSwipeToPoint:(CGPoint)point velocity:(CGPoint)velocity {
#if LOG_DELEGATE_METHODS
    NSLog(@"swipeTableViewCell: %@ didSwipeToPoint: %@ velocity: %@", swipeTableViewCell, NSStringFromCGPoint(point), NSStringFromCGPoint(velocity));
#endif
}

-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity {
#if LOG_DELEGATE_METHODS
    NSLog(@"swipeTableViewCellWillResetState: %@ fromPoint: %@ animation: %d, velocity: %@", swipeTableViewCell, NSStringFromCGPoint(point), animation, NSStringFromCGPoint(velocity));
#endif
    if (point.x >= CGRectGetHeight(swipeTableViewCell.frame)) {
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeTableViewCell];
//        if ([[[noticeArray objectAtIndex:indexPath.row] objectForKey:@"isFavourite"] boolValue]) {
//            [[self.array objectAtIndex:indexPath.row] setObject:@NO forKey:@"isFavourite"];
//        } else {
//            [[self.array objectAtIndex:indexPath.row] setObject:@YES forKey:@"isFavourite"];
//        }
//        [(RMPersonTableViewCell*)swipeTableViewCell setFavourite:[[[self.array objectAtIndex:indexPath.row] objectForKey:@"isFavourite"] boolValue] animated:YES];
    } else if (point.x < 0 && -point.x >= CGRectGetHeight(swipeTableViewCell.frame)) {
        swipeTableViewCell.shouldAnimateCellReset = NO;
//        [[(RMPersonTableViewCell*)swipeTableViewCell checkmarkGreyImageView] removeFromSuperview];
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationCurveLinear
                         animations:^{
                             swipeTableViewCell.contentView.frame = CGRectOffset(swipeTableViewCell.contentView.bounds, swipeTableViewCell.contentView.frame.size.width, 0);
                         }
                         completion:^(BOOL finished) {
                            
                             sysStatus = SYSTEM_STATUS_NORMAL;
                             
                             //主动取消求助
                             if ([swipeTableViewCell isKindOfClass:[NoticeWaitTableViewCell class]])
                             {
                                 [((NoticeWaitTableViewCell *)swipeTableViewCell) cancelWaitHelp];
                                 
                                 //删除地图Annotation
                                 [self cleanHelpAnnotation];
                             }
                             else if ([swipeTableViewCell isKindOfClass:[SearchHelpCell class]])
                             {
                                 //删除所有附件查找的助友Annotation
                                 [self cleanNearbyHelpFrdAnnotation];
                             }
                             
                             //删除Cell
                             [swipeTableViewCell.contentView setHidden:YES];
                             NSIndexPath *indexPath = [noticeTab indexPathForCell:swipeTableViewCell];
                             [noticeArray removeObjectAtIndex:indexPath.row];
                             [noticeTab beginUpdates];
                             [noticeTab deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                             [noticeTab endUpdates];
                         }
         ];
    }
}

-(void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity {
#if LOG_DELEGATE_METHODS
    NSLog(@"swipeTableViewCellDidResetState: %@ fromPoint: %@ animation: %d, velocity: %@", swipeTableViewCell, NSStringFromCGPoint(point), animation, NSStringFromCGPoint(velocity));
#endif
    if (point.x < 0 && -point.x > CGRectGetHeight(swipeTableViewCell.frame)) {
        NSIndexPath *indexPath = [noticeTab indexPathForCell:swipeTableViewCell];
        [noticeArray removeObjectAtIndex:indexPath.row];
        [noticeTab beginUpdates];
        [noticeTab deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        [noticeTab endUpdates];
    }
}
@end
