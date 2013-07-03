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
}

- (void) viewDidUnload
{
    searchPos.delegate = nil;
    searchView.delegate = nil;
    _mapView.delegate = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [curAddrInfo release];
    [searchPos release];
    [searchView release];
    [_mapView release];
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
    
    [self initUI];
}

#pragma mark -
#pragma mark Custom Action
- (void) initUI
{
    self.title = @"首页";
    
    pastLoc.longitude = 0.0f;
    pastLoc.latitude  = 0.0f;
    
    _mapView = [[BMKMapView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(0, 0, 320, 420)]];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
    curAddrInfo = nil;
    searchPos   = [[BMKSearch alloc]init];
    searchPos.delegate = self;
    
    searchView = [[NiftySearchView alloc] initWithFrame:CGRectMake(0, -76, 320, 76/2)
                                              andIsOnly:YES];
    searchView.delegate = (id)self;
    [self.view addSubview:searchView];
    
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

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    UIButton *actBtn = (UIButton *)sender;
    switch (actBtn.tag)
    {
        case 0:         //locateMe
        {
            [self showPost:_mapView.userLocation.location.coordinate];
            break;
        }
        case 1:         //search
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
        case 2:         //help
        {
            break;
        }
        case 3:         //search help
        {
            break;
        }
        case 4:         //search
        {
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
    BMKPointAnnotation *annn = (BMKPointAnnotation *)view.annotation;
    if ([view.annotation isKindOfClass:[BMKPointAnnotation class]])
    {   //如果点到了这个marker点，什么也不做
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
        dstAnn.locationInfo = [NSDictionary dictionaryWithObject:@"西丽"
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
        if (dstAnn.coordinate.latitude == view.annotation.coordinate.latitude && dstAnn.coordinate.longitude == view.annotation.coordinate.longitude)
        {
            [_mapView removeAnnotation:dstAnn];
            dstAnn = nil;
        }
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        CDLog(@"DST:%f,%f", [annotation coordinate].latitude, [annotation coordinate].longitude);
        
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
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
            [annView.contentView addSubview:cell];
            annView.dstPointCell = cell;
        }
        //开始设置添加marker时的赋值
        annView.dstPointCell.dstLab.text = [ann.locationInfo objectForKey:@"dstLoc"];
        return annView;
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
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    double x = userLocation.location.coordinate.latitude  - pastLoc.latitude;
    double y = userLocation.location.coordinate.longitude - pastLoc.longitude;
	if (userLocation != nil) {

        if (fabs(x)>=0.0001 || fabs(y)>=0.0001)
        {
            NSLog(@"%f %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
            
            //显示区域
            [self showPost:userLocation.location.coordinate];
            
            pastLoc = userLocation.location.coordinate;
            
            //获得地理编码
            [searchPos reverseGeocode:userLocation.location.coordinate];
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
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	if (error == 0) {
        if (_mapView.userLocation.coordinate.latitude == result.geoPt.latitude && _mapView.userLocation.coordinate.longitude == result.geoPt.longitude)
        {
            curAddrInfo = nil;
            curAddrInfo = [result retain];
            return;
        }
        
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
		item.coordinate = result.geoPt;
		item.title = result.strAddr;
		[_mapView addAnnotation:item];
		[item release];
        CDLog(@"result:%@, %@",    result.strAddr, result.addressComponent.city);
        CDLog(@"geoPt:%f, %f", result.geoPt.latitude,result.geoPt.longitude);
        
        //显示当前标注区域
        [self showPost:result.geoPt];
	}
    else
    {
        CDLog(@"error:%d", error);
    }
}
@end
