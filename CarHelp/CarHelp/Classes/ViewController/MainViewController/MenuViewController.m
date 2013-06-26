//
//  MenuViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize menuTab;
@synthesize user;
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
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload
{
    menuTab.delegate   = nil;
    menuTab.dataSource = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [menuTab release];
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    user = [[User alloc]init];
    user.userName = @"张三";
    user.score = 1000;
    user.helpCount = 50;
    user.honre = 5000;
    user.head  = @"boy_1";
    user.secureName = @"Lynn";
    user.phoneNum   = @"1234567889";
    user.email = @"lynn.lingyong@gmail.com";
    user.idNum = @"12222222224567899";
    
    UserBoardView *ubView = [[UserBoardView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(0, 0, 300, 100)] withUser:user];
    ubView.delegate = self;
    [self.view addSubview:ubView];
    [ubView release];
    
    menuTab = [[UITableView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(0, 100, 300, 360)]];
    menuTab.delegate   = self;
    menuTab.dataSource = self;
    [self.view addSubview:menuTab];
}

#pragma mark -
#pragma mark UITableViewDelegate and UITableDatasource
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idString = @"idString";
    UITableViewCell *cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:idString]autorelease];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(5, 0, cell.frame.size.width, cell.frame.size.height);
    [cell addSubview:label];
    
    switch (indexPath.row)
    {
        case 0:
        {
            label.text = @"首页";
            break;
        }
        case 1:
        {
            label.text = @"会话";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 2:
        {
            label.text = @"我的助友";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 3:
        {
            label.text = @"我的装备";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 4:
        {
            label.text = @"扫一扫";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 5:
        {
            label.text = @"保险激活";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 6:
        {
            label.text = @"求助黑匣子";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 7:
        {
            label.text = @"设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 8:
        {
            label.text = @"开启乘车安全";
            UISwitch *sw = [[UISwitch alloc]init];
            sw.frame = CGRectMake(cell.frame.size.width-100, cell.frame.size.height/2-30/2,
                                100, 30);
            [cell addSubview:sw];
            [sw release];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        }
        default:
            break;
    }
    [label release];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDMenuController *menuVc = (DDMenuController *)[self searchViewController:NSStringFromClass([DDMenuController class])];
    switch (indexPath.row)
    {
        case 0:     //首页
        {
            MainViewController *mvc     = [[MainViewController alloc]init];
            UINavigationController *nVc = [[UINavigationController alloc] initWithRootViewController:mvc];
            [menuVc setRootController:nVc
                             animated:YES];
            break;
        }
        case 1:     //会话
        {
            ChatListViewController *cVc = [[ChatListViewController alloc]init];
            UINavigationController *nVc = [[UINavigationController alloc] initWithRootViewController:cVc];
            [menuVc setRootController:nVc
                             animated:YES];
            break;
        }
        case 2:    //助友列表
        {
            FriendsViewController *fVc = [[FriendsViewController alloc]init];
            UINavigationController*nvc = [[UINavigationController alloc]initWithRootViewController:fVc];
            [menuVc setRootController:nvc
                             animated:YES];
            break;
        }
        case 3:    //我的装备
        {
            PackageScanViewController *pVc = [[PackageScanViewController alloc]init];
            UINavigationController*nvc = [[UINavigationController alloc]initWithRootViewController:pVc];
            [menuVc setRootController:nvc animated:YES];
            break;
        }
        case 4:    //扫一扫
        {
            QRViewController *qVc = [[QRViewController alloc]init];
            UINavigationController*nvc = [[UINavigationController alloc]initWithRootViewController:qVc];
            [menuVc setRootController:nvc animated:YES];
            break;
        }
        case 5:    //保险激活
        {
            SecureViewController *sVc = [[SecureViewController alloc]init];
            UINavigationController*nvc = [[UINavigationController alloc]initWithRootViewController:sVc];
            [menuVc setRootController:nvc animated:YES];
            break;
        }
        case 6:    //救帮黑匣子
        {
            HelpHistoryViewController *hVc = [[HelpHistoryViewController alloc]init];
            UINavigationController*nvc = [[UINavigationController alloc]initWithRootViewController:hVc];
            [menuVc setRootController:nvc animated:YES];
            break;
        }
        case 7:    //设置
        {
            SettingViewController *sVc = [[SettingViewController alloc]init];
            UINavigationController*nvc = [[UINavigationController alloc]initWithRootViewController:sVc];
            [menuVc setRootController:nvc animated:YES];
            break;
        }
        case 8:
        {
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - UserBoardViewDelegate
- (void) userBoardView:(UserBoardView *)view headClicked:(id)sender
{
    DDMenuController *menuVc = (DDMenuController *)[self searchViewController:NSStringFromClass([DDMenuController class])];
    UserDetailViewController *udVc = [[UserDetailViewController alloc]init];
    udVc.user = user;
    UINavigationController*nvc = [[UINavigationController alloc]initWithRootViewController:udVc];
    [menuVc setRootController:nvc animated:YES];
}
@end
