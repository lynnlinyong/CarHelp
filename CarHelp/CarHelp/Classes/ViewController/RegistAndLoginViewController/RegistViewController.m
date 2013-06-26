//
//  RegistViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "ShareData.h"
#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController
@synthesize pwdFld;
@synthesize rePwdFld;
@synthesize userNameFld;

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
    self.title = @"注册账号";
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
}

- (void) viewDidUnload
{
    pwdFld.delegate      = nil;
    rePwdFld.delegate    = nil;
    userNameFld.delegate = nil;
    
    [super viewDidUnload];
}

- (void) dealloc
{
    [pwdFld      release];
    [rePwdFld    release];
    [userNameFld release];
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    userNameFld = [[UITextField alloc]init];
    userNameFld.delegate = self;
    userNameFld.placeholder = @"用户名";
    userNameFld.borderStyle = UITextBorderStyleLine;
    userNameFld.frame = [UIView fitCGRect:CGRectMake(60, 50, 200, 30)];
    [self.view addSubview:userNameFld];
    
    pwdFld = [[UITextField alloc]init];
    pwdFld.delegate = self;
    pwdFld.placeholder = @"密码";
    pwdFld.borderStyle = UITextBorderStyleLine;
    pwdFld.frame = [UIView fitCGRect:CGRectMake(60, 90, 200, 30)];
    [self.view addSubview:pwdFld];
    
    rePwdFld = [[UITextField alloc]init];
    rePwdFld.delegate = self;
    rePwdFld.placeholder = @"重复密码";
    rePwdFld.borderStyle = UITextBorderStyleLine;
    rePwdFld.frame = [UIView fitCGRect:CGRectMake(60, 130, 200, 30)];
    [self.view addSubview:rePwdFld];
    
    UIButton *rgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rgBtn.frame = [UIView fitCGRect:CGRectMake(110, 180, 100, 30)];
    [rgBtn setTitle:@"注册"
           forState:UIControlStateNormal];
    [rgBtn addTarget:self
              action:@selector(doRgBtnClicked:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rgBtn];
    
    UILabel *loginLab = [[UILabel alloc]init];
    loginLab.frame = [UIView fitCGRect:CGRectMake(20, 300, 180, 20)];
    loginLab.text  = @"其他方式登录";
    [self.view addSubview:loginLab];
    [loginLab release];
    
    UIButton *tcBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tcBtn.frame = [UIView fitCGRect:CGRectMake(30, 330, 60, 30)];
    [tcBtn setTitle:@"QQ" forState:UIControlStateNormal];
    [tcBtn addTarget:self
              action:@selector(doTcBtnClicked:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tcBtn];
    
    UIButton *sinaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sinaBtn.frame = [UIView fitCGRect:CGRectMake(100, 330, 60, 30)];
    [sinaBtn setTitle:@"Sina" forState:UIControlStateNormal];
    [sinaBtn addTarget:self
              action:@selector(doSinaBtnClicked:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doRgBtnClicked:(id)sender
{
    RegistSexViewController *rsVc = [[RegistSexViewController alloc]init];
    [self.navigationController pushViewController:rsVc
                                         animated:YES];
    [rsVc release];
}

- (void) doSinaBtnClicked:(id)sender
{
    
}

- (void) doTcBtnClicked:(id)sender
{
    
}

#pragma mark -
#pragma mark - UITextFeildDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
