//
//  RegistHeadViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-22.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "RegistCarViewController.h"
#import "RegistHeadViewController.h"

@interface RegistHeadViewController ()

@end

@implementation RegistHeadViewController

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
    self.title = @"选择头像";
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
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [headBtn setTitle:@"选择头像"
             forState:UIControlStateNormal];
    [headBtn setFrame:[UIView fitCGRect:CGRectMake(110, 60, 100, 30)]];
    [headBtn addTarget:self
                action:@selector(doHeadClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doHeadClicked:(id)sender
{
    RegistCarViewController *rcVc = [[RegistCarViewController alloc]init];
    [self.navigationController pushViewController:rcVc animated:YES];
    [rcVc release];
}

@end
