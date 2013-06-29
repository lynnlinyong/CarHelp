//
//  LoginViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize userNameFld;
@synthesize pwdFld;

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
    self.title = @"登录";
    
    [self initUI];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidUnload
{
    pwdFld.delegate = nil;
    userNameFld.delegate = nil;
    weiboEngine = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [pwdFld      release];
    [userNameFld release];
    [weiboEngine release];
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    UILabel *userNameLab = [[UILabel alloc]init];
    userNameLab.frame    = [UIView fitCGRect:CGRectMake(70, 80, 60, 20)];
    userNameLab.text     = @"用户名";
    [self.view addSubview:userNameLab];
    [userNameLab release];
    
    UILabel *pwdLab = [[UILabel alloc]init];
    pwdLab.frame    = [UIView fitCGRect:CGRectMake(70, 140, 60, 20)] ;
    pwdLab.text     = @"密码";
    [self.view addSubview:pwdLab];
    [pwdLab release];
    
    userNameFld = [[UITextField alloc]init];
    userNameFld.borderStyle = UITextBorderStyleLine;
    userNameFld.delegate = self;
    userNameFld.frame = [UIView fitCGRect:CGRectMake(70, 100, 180, 30)];
    [self.view addSubview:userNameFld];
    
    pwdFld = [[UITextField alloc]init];
    pwdFld.borderStyle = UITextBorderStyleLine;
    pwdFld.delegate = self;
    pwdFld.frame = [UIView fitCGRect:CGRectMake(70, 160, 180, 30)];
    [self.view addSubview:pwdFld];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registBtn.frame = [UIView fitCGRect:CGRectMake(20, 210, 80, 30)];
    [registBtn  setTitle:@"注册"
                forState:UIControlStateNormal];
    [registBtn addTarget:self
                  action:@selector(doRegistBtnClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = [UIView fitCGRect:CGRectMake(120, 210, 80, 30)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self
                 action:@selector(doLoginBtnClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *fgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    fgBtn.frame = [UIView fitCGRect:CGRectMake(220, 210, 80, 30)];
    [fgBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [fgBtn addTarget:self
              action:@selector(doFgBtnClicked:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fgBtn];
    
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
    
    /**
     * Init Tecent Weibo SDK
     **/
    weiboEngine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey
                                           andSecret:WiressSDKDemoAppSecret
                                      andRedirectUrl:REDIRECTURI];
    [weiboEngine setRootViewController:self];
    
    /**
     * Init Sina Weibo SDK
     **/
    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey
                                        appSecret:kAppSecret
                                   appRedirectURI:kAppRedirectURI
                                      andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
}

- (void) gotoMainView
{
    MainViewController *mVc     = [[MainViewController alloc]init];
    MenuViewController *menuVc  = [[MenuViewController alloc]init];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:mVc];
    DDMenuController *dMenuVc   = [[DDMenuController alloc]initWithRootViewController:nvc];
    dMenuVc.leftViewController  = menuVc;
    [self.navigationController pushViewController:dMenuVc
                                         animated:YES];
}

#pragma mark -
#pragma mark UIButton Clicked Action
- (void) doLoginBtnClicked:(id)sender
{
    [self gotoMainView];
}

- (void) doRegistBtnClicked:(id)sender
{
    RegistViewController *rvc = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:rvc
                                         animated:YES];
    [rvc release];
}

- (void) doFgBtnClicked:(id)sender
{
    ForgetPwdViewController *fgVc = [[ForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:fgVc animated:YES];
    [fgVc release];
}

- (void) doSinaBtnClicked:(id)sender
{
    [sinaweibo logIn];
}

- (void) doTcBtnClicked:(id)sender
{
    [weiboEngine logInWithDelegate:self
                         onSuccess:@selector(onSuccessLogin)
                         onFailure:@selector(onFailureLogin:)];
}

#pragma mark -
#pragma mark - Tecent Weibo Call Back
- (void)onSuccessLogin
{
    [self gotoMainView];
}

- (void)onFailureLogin:(NSError *)error
{
//    [indicatorView stopAnimating];
    NSString *message = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error domain]
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    [message   release];
}

#pragma mark -
#pragma mark - SinaWeibo Delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sweibo.userID, sweibo.accessToken, sweibo.expirationDate,sweibo.refreshToken);
    [self gotoMainView];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
}

#pragma mark - 
#pragma mark - SinaWeiboRequest Delegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
@end
