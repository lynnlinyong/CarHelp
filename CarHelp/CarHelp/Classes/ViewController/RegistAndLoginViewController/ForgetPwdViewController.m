//
//  ForgetPwdViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "ForgetPwdViewController.h"

@interface ForgetPwdViewController ()

@end

@implementation ForgetPwdViewController
@synthesize emailFld;

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
    self.title = @"忘记密码";

    [self initUI];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [emailFld release];
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    UILabel *infoLab = [[UILabel alloc]init];
    infoLab.frame = [UIView fitCGRect:CGRectMake(40, 50, 240, 80)];
    infoLab.text  = @"找回密码功能权限于邮件找回,爱车帮帮帮将把你重置密码的信息发送到您预留的邮箱中,请查收邮箱进行重置密码/短信找回.";
    infoLab.numberOfLines = 0;
    infoLab.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:infoLab];
    [infoLab release];
    
    UILabel *userNameLab = [[UILabel alloc]init];
    userNameLab.frame = [UIView fitCGRect:CGRectMake(40, 150, 100, 20)];
    userNameLab.text  = @"邮箱:";
    [self.view addSubview:userNameLab];
    [userNameLab release];
    
    emailFld = [[UITextField alloc]init];
    emailFld.delegate     = self;
    emailFld.frame        = [UIView fitCGRect:CGRectMake(40, 170, 200, 30)];
    emailFld.borderStyle  = UITextBorderStyleLine;
    [self.view addSubview:emailFld];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendBtn.frame = [UIView fitCGRect:CGRectMake(110, 210, 100, 30)];
    [sendBtn setTitle:@"找回密码"
             forState:UIControlStateNormal];
    [sendBtn addTarget:self
                action:@selector(doSendBtnClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
}

#pragma mark -
#pragma mark - Button Clicked Action
- (void) doSendBtnClicked:(id)sender
{
    
}

#pragma mark -
#pragma mark - UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
@end
