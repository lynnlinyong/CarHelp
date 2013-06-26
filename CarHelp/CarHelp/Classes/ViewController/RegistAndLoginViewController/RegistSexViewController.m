//
//  RegistSexViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-22.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "RegistSexViewController.h"
#import "RegistHeadViewController.h"

@interface RegistSexViewController ()

@end

@implementation RegistSexViewController
@synthesize boyBtn;
@synthesize girlBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择性别";
    
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
    boyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    boyBtn.tag = 0;
    [boyBtn setTitle:@"我是男生" forState:UIControlStateNormal];
    [boyBtn setFrame:[UIView fitCGRect:CGRectMake(40, 60, 100, 30)]];
    [boyBtn addTarget:self
               action:@selector(doClickedAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:boyBtn];
    
    girlBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    girlBtn.tag = 1;
    [girlBtn setTitle:@"我是女生" forState:UIControlStateNormal];
    [girlBtn setFrame:[UIView fitCGRect:CGRectMake(180, 60, 100, 30)]];
    [girlBtn addTarget:self
                action:@selector(doClickedAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:girlBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doClickedAction:(id)sender
{
    UIButton *clickBtn = (UIButton *)sender;
    switch (clickBtn.tag)
    {
        case 0:     //男生
        {
            break;
        }
        case 1:     //女生
        {
            break;
        }
        default:
            break;
    }

    RegistHeadViewController *rhVc = [[RegistHeadViewController alloc]init];
    [self.navigationController pushViewController:rhVc animated:YES];
    [rhVc release];
}

@end
