//
//  PackageMineViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-24.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "PackageMineViewController.h"

@interface PackageMineViewController ()

@end

@implementation PackageMineViewController

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
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    UIBarButtonItem *scanBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"扫一扫"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(doScanBtnClicked:)];
    self.navigationItem.rightBarButtonItem = scanBarBtn;
    [scanBarBtn release];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doScanBtnClicked:(id)sender
{
    
}
@end
