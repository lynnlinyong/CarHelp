//
//  UpdatePwdViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-28.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "UpdatePwdViewController.h"

@interface UpdatePwdViewController ()

@end

@implementation UpdatePwdViewController

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
    self.title = @"修改密码";
    
    oldPwdFld = [[UITextField alloc]init];
    oldPwdFld.tag = 1;
    oldPwdFld.frame = [UIView fitCGRect:CGRectMake(60, 50, 200, 30)];
    oldPwdFld.delegate = self;
    oldPwdFld.borderStyle = UITextBorderStyleLine;
    oldPwdFld.placeholder = @"旧密码";
    [self.view addSubview:oldPwdFld];
    
    newPwdFld = [[UITextField alloc]init];
    newPwdFld.tag = 2;
    newPwdFld.frame = [UIView fitCGRect:CGRectMake(60, 90, 200, 30)];
    newPwdFld.delegate = self;
    newPwdFld.borderStyle = UITextBorderStyleLine;
    newPwdFld.placeholder = @"新密码";
    [self.view addSubview:newPwdFld];
    
    reNewPwdFld = [[UITextField alloc]init];
    reNewPwdFld.tag = 3;
    reNewPwdFld.frame = [UIView fitCGRect:CGRectMake(60, 130, 200, 30)];
    reNewPwdFld.delegate = self;
    reNewPwdFld.borderStyle = UITextBorderStyleLine;
    reNewPwdFld.placeholder = @"重复新密码";
    [self.view addSubview:reNewPwdFld];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    updateBtn.frame = [UIView fitCGRect:CGRectMake(110, 250, 100, 30)];
    [updateBtn setTitle:@"修改"
               forState:UIControlStateNormal];
    [updateBtn addTarget:self
                  action:@selector(doUpdateBtnClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doUpdateBtnClicked:(id)sender
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
