//
//  SettingSecureBoardViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-24.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "SettingSecureBoardViewController.h"

@interface SettingSecureBoardViewController ()

@end

@implementation SettingSecureBoardViewController

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
    self.title = @"安全应急救生卡";
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    scanBtn.frame = [UIView fitCGRect:CGRectMake(110, 300, 100, 30)];
    [scanBtn setTitle:@"扫描"
             forState:UIControlStateNormal];
    [scanBtn addTarget:self
                action:@selector(doScanBtnClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doScanBtnClicked:(id)sender
{
    SettingSecureDetailViewController *ssVc = [[SettingSecureDetailViewController alloc]init];
    [self.navigationController pushViewController:ssVc
                                         animated:YES];
    [ssVc release];
}
@end
