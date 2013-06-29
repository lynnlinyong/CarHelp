//
//  UserDetailViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-24.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "UserDetailViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController
@synthesize user;

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
    self.title = @"个人资料";
    
    UIImageView *headImgView = [[UIImageView alloc]init];
    headImgView.image = [UIImage imageNamed:user.head];
    headImgView.frame = CGRectMake(120, 20, 80, 80);
    [self.view addSubview:headImgView];
    [headImgView release];
    
//    UIButton *fastBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    if (frd.isFastFrd)
//    {
//        [fastBtn setTitle:@"取消密友"
//                 forState:UIControlStateNormal];
//    }
//    else
//    {
//        [fastBtn setTitle:@"设为密友"
//                 forState:UIControlStateNormal];
//    }
//    fastBtn.frame = [UIView fitCGRect:CGRectMake(220, 20, 100, 30)];
//    [fastBtn addTarget:self
//                action:@selector(doFastBtnClicked:)
//      forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:fastBtn];
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.text  = user.userName;
    nameLab.frame = [UIView fitCGRect:CGRectMake(10, 110, 100, 20)];
    [self.view addSubview:nameLab];
    [nameLab release];
    
    UILabel *scoreLab = [[UILabel alloc]init];
    scoreLab.text  = [NSString stringWithFormat:@"积分:%ld", user.score];
    scoreLab.frame = [UIView fitCGRect:CGRectMake(120, 110, 100, 20)];
    [self.view addSubview:scoreLab];
    [scoreLab release];
    
    UILabel *hcLab = [[UILabel alloc]init];
    hcLab.text  = [NSString stringWithFormat:@"施助数:%ld", user.helpCount];
    hcLab.frame = [UIView fitCGRect:CGRectMake(220, 110, 100, 20)];
    [self.view addSubview:hcLab];
    [hcLab release];
    
    UILabel *honreLab = [[UILabel alloc]init];
    honreLab.text  = [NSString stringWithFormat:@"荣誉:%ld", user.honre];
    honreLab.frame = [UIView fitCGRect:CGRectMake(120, 130, 100, 20)];
    [self.view addSubview:honreLab];
    [honreLab release];
    
    UILabel *activeLab = [[UILabel alloc]init];
    activeLab.text  = [NSString stringWithFormat:@"活跃度:达人"];
    activeLab.frame = [UIView fitCGRect:CGRectMake(220, 130, 100, 20)];
    [self.view addSubview:activeLab];
    [activeLab release];
    
    userTab = [[UITableView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(0, 150, 320, 270)]
                                          style:UITableViewStyleGrouped];
    userTab.delegate   = self;
    userTab.dataSource = self;
    [self.view addSubview:userTab];
}

#pragma mark -
#pragma mark - UITableViewDelegate and UITableViewDatasource
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 4;
            break;
        }
        case 1:
        {
            return 1;
            break;
        }
        case 2:
        {
            return 1;
            break;
        }
        default:
            break;
    }
    
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idString    = @"idString";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:idString]autorelease];
    }
    
    switch (indexPath.section)
    {
        case 0:
        {
            UILabel *cntLab = [[UILabel alloc]init];
            cntLab.frame = CGRectMake(20, 10, 300, 20);
            cntLab.backgroundColor = [UIColor clearColor];
            [cell addSubview:cntLab];
            switch (indexPath.row)
            {
                case 0:
                {
                    cntLab.text = [NSString stringWithFormat:@"投保人姓名:%@", user.secureName];
                    break;
                }
                case 1:
                {
                    cntLab.text = [NSString stringWithFormat:@"身份证号码:%@", user.idNum];
                    break;
                }
                case 2:
                {
                    cntLab.text = [NSString stringWithFormat:@"电子邮箱:%@", user.email];
                    break;
                }
                case 3:
                {
                    cntLab.text = [NSString stringWithFormat:@"移动电话:%@", user.phoneNum];
                    break;
                }
                default:
                    break;
            }
            [cntLab release];
            break;
        }
        case 1:
        {
            UILabel *pwdLab = [[UILabel alloc]init];
            pwdLab.frame = CGRectMake(60, 10, 200, 20);
            pwdLab.text  = @"修改密码";
            pwdLab.textAlignment   = NSTextAlignmentCenter;
            pwdLab.backgroundColor = [UIColor clearColor];
            [cell addSubview:pwdLab];
            [pwdLab release];
            break;
        }
        case 2:
        {
            UILabel *logOutLab = [[UILabel alloc]init];
            logOutLab.frame = CGRectMake(60, 10, 200, 20);
            logOutLab.text  = @"退出登录";
            logOutLab.textAlignment   = NSTextAlignmentCenter;
            logOutLab.backgroundColor = [UIColor clearColor];
            [cell addSubview:logOutLab];
            [logOutLab release];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            break;
        }
        case 1:     //修改密码
        {
            UpdatePwdViewController *upVc = [[UpdatePwdViewController alloc]init];
            [self.navigationController pushViewController:upVc
                                                 animated:YES];
            [upVc release];
            break;
        }
        case 2:     //退出登录
        {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UINavigationController *navCtr  = (UINavigationController *)appDelegate.window.rootViewController;
            LoginViewController *lVc = (LoginViewController *)[self searchViewController:@"LoginViewController"];
            [navCtr popToViewController:lVc
                               animated:YES];
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
