//
//  PackageViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-21.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "PackageScanViewController.h"

@interface PackageScanViewController ()

@end

@implementation PackageScanViewController

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
    self.title = @"我的装备";
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    [scanBtn addTarget:self
                action:@selector(doScanBtnClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    scanBtn.frame = [UIView fitCGRect:CGRectMake(110, 300, 100, 30)];
    [self.view addSubview:scanBtn];
}

#pragma mark - 
#pragma mark - UIButton Clicked Action
- (void) doScanBtnClicked:(id)sender
{
    PackageDetalViewController *pVc = [[PackageDetalViewController alloc]init];
    [self.navigationController pushViewController:pVc
                                         animated:YES];
    [pVc release];
}
@end
