//
//  RegistUserViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-22.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "ShareData.h"
#import "RegistUserViewController.h"

@interface RegistUserViewController ()

@end

@implementation RegistUserViewController
@synthesize phFld;
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
    self.title = @"联系方式";
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [super dealloc];
    [phFld    release];
    [emailFld release];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    UILabel *phLab = [[UILabel alloc]init];
    phLab.text  = @"联系方式";
    phLab.frame = [UIView fitCGRect:CGRectMake(40, 50, 80, 20)];
    [self.view addSubview:phLab];
    [phLab release];
    
    phFld = [[UITextField alloc]init];
    phFld.delegate = self;
    phFld.borderStyle = UITextBorderStyleLine;
    phFld.frame = [UIView fitCGRect:CGRectMake(40, 80, 200, 30)];
    [self.view addSubview:phFld];
    
    UILabel *emailLab = [[UILabel alloc]init];
    emailLab.text  = @"邮箱";
    emailLab.frame = [UIView fitCGRect:CGRectMake(40, 130, 80, 20)];
    [self.view addSubview:emailLab];
    [emailLab release];
    
    emailFld = [[UITextField alloc]init];
    emailFld.delegate = self;
    emailFld.borderStyle = UITextBorderStyleLine;
    emailFld.frame    = [UIView fitCGRect:CGRectMake(40, 160, 200, 30)];
    [self.view addSubview:emailFld];
    
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bgBtn.frame = [UIView fitCGRect:CGRectMake(110, 350, 100, 30)];
    [bgBtn setTitle:@"马上开始"
           forState:UIControlStateNormal];
    [bgBtn addTarget:self
              action:@selector(doBtnClicked:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doBtnClicked:(id)sender
{
    LoginViewController *lgVc = (LoginViewController *) [self searchViewController:NSStringFromClass([LoginViewController class])];
    [self.navigationController popToViewController:lgVc animated:YES];
}

#pragma mark -
#pragma mark - UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
