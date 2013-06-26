//
//  SecureViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-21.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "SecureViewController.h"

@interface SecureViewController ()

@end

@implementation SecureViewController
@synthesize pwdFld;
@synthesize accountFld;

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
    self.title = @"保险激活";
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
    UILabel *accountLab = [[UILabel alloc]init];
    accountLab.text  = @"保险激活账号";
    accountLab.frame = [UIView fitCGRect:CGRectMake(10, 60, 160, 20)];
    [self.view addSubview:accountLab];
    [accountLab release];
    
    accountFld = [[UITextField alloc]init];
    accountFld.delegate = self;
    accountFld.borderStyle = UITextBorderStyleLine;
    accountFld.frame = [UIView fitCGRect:CGRectMake(10, 90, 300, 30)];
    [self.view addSubview:accountFld];
    
    UILabel *pwdLab = [[UILabel alloc]init];
    pwdLab.text  = @"保险激活密码";
    pwdLab.frame = [UIView fitCGRect:CGRectMake(10, 130, 160, 20)];
    [self.view addSubview:pwdLab];
    [pwdLab release];
    
    pwdFld = [[UITextField alloc]init];
    pwdFld.delegate = self;
    pwdFld.borderStyle = UITextBorderStyleLine;
    pwdFld.frame = [UIView fitCGRect:CGRectMake(10, 160, 300, 30)];
    [self.view addSubview:pwdFld];
    
    UIButton *activBtn = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
    activBtn.frame = [UIView fitCGRect:CGRectMake(110, 250, 100, 30)];
    [activBtn setTitle:@"激活" forState:UIControlStateNormal];
    [activBtn addTarget:self
                 action:@selector(doActiveBtnClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doActiveBtnClicked:(id)sender
{
    
}
@end
