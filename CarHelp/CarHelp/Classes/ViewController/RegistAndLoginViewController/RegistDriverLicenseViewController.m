//
//  RegistDriverLicenseViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-22.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "RegistDriverLicenseViewController.h"

@interface RegistDriverLicenseViewController ()

@end

@implementation RegistDriverLicenseViewController

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
    self.title = @"拍一张驾驶证正面照";
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
    UIButton *fuBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    fuBtn.frame = [UIView fitCGRect:CGRectMake(40, 300, 100, 30)];
    [fuBtn setTitle:@"以后再说"
           forState:UIControlStateNormal];
    [fuBtn addTarget:self
              action:@selector(doButtonClicked:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fuBtn];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextBtn.frame = [UIView fitCGRect:CGRectMake(160, 300, 100, 30)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self
                action:@selector(doButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    switch (btn.tag)
    {
        case 0: //以后再说
        {
            LoginViewController *lgVc = (LoginViewController *) [self searchViewController:NSStringFromClass([LoginViewController class])];
            [self.navigationController popToViewController:lgVc animated:YES];
            break;
        }
        case 1: //下一步
        {
            RegistCarViewController *rcVc = [[RegistCarViewController alloc]init];
            [self.navigationController pushViewController:rcVc
                                                 animated:YES];
            [rcVc release];
            break;
        }
        default:
            break;
    }
}

@end
