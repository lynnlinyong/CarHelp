//
//  ViewController.m
//  GuideViewController
//
//  Created by lynn on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//#import "MainNavController.h"
//#import "ISColumnsController.h"
//#import "LoginViewController.h"
//#import "SearchCarViewController.h"
#import "MainSplashViewController.h"

@implementation MainSplashViewController
@synthesize pageControl = _pageControl;
@synthesize pageScroll  = _pageScroll;
@synthesize slView = _slView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _pageScroll  = [[UIScrollView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(0, 0, 320, 480)]];
    _pageScroll.pagingEnabled = YES;
    _pageScroll.delegate = self;
    _pageScroll.contentSize = CGSizeMake(self.view.frame.size.width*4, [UIScreen getCurrentBounds].size.height);
    [self.view addSubview:_pageScroll];
    
    UIImageView *spImgView = [[UIImageView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(0, 0, 320, 480)]];
    spImgView.backgroundColor = [UIColor redColor];
    [_pageScroll addSubview:spImgView];
    [spImgView release];
    
    UIImageView *spImgView1 = [[UIImageView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(320, 0, 320, 480)]];
    spImgView1.backgroundColor = [UIColor yellowColor];
    [_pageScroll addSubview:spImgView1];
    [spImgView1 release];
    
    UIImageView *spImgView2 = [[UIImageView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(320*2, 0, 320, 480)]];
    spImgView2.backgroundColor = [UIColor blueColor];
    [_pageScroll addSubview:spImgView2];
    [spImgView2 release];
    
    _slView = [[SplashLastView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(320*3, 0, 320, 480)]];
    _slView.delegate = self;
    [_pageScroll addSubview:_slView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:[UIView fitCGRect:CGRectMake(141, 400, 38, 36)]];
    _pageControl.numberOfPages = 4;
    _pageControl.currentPage   = 0;
    [self.view addSubview:_pageControl];
}

- (void)viewDidUnload
{
    _slView = nil;
    _pageControl = nil;
    _pageScroll  = nil;
    [super viewDidUnload];
}

-(void)dealloc
{
    [_slView release];
    [_pageScroll release];
    [_pageControl release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}

#pragma mark -
#pragma mark - SplashLastDelegate
- (void) splashView:(SplashLastView *)view doClicked:(UIButton *)btn
{
//    MainViewController *mVc     = [[[MainViewController alloc]init]autorelease];
    
    RegistViewController *rvc = [[[RegistViewController alloc]init]autorelease];
    
//    MenuViewController *menuVc  = [[[MenuViewController alloc]init]autorelease];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:rvc];
//    DDMenuController *dMenuVc   = [[DDMenuController alloc]initWithRootViewController:nvc];
//    dMenuVc.leftViewController  = menuVc;
    
    AppDelegate *appDelegate    = [[UIApplication sharedApplication]delegate];
    appDelegate.window.rootViewController = nvc;
}

@end
