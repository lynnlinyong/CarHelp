//
//  SettingViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-21.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "ShareData.h"
#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    self.title = @"设置";
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidUnload
{
    setTab.delegate   = nil;
    setTab.dataSource = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [setTab release];
    [super dealloc];
}

#pragma mark -
#pragma mark - initUI
- (void) initUI
{
    setTab = [[UITableView alloc] initWithFrame:[UIView fitCGRect:CGRectMake(0, 0, 320, 420)]
                                          style:UITableViewStyleGrouped];
    setTab.delegate   = self;
    setTab.dataSource = self;
    setTab.scrollEnabled = NO;
    [self.view addSubview:setTab];
}

#pragma mark -
#pragma mark - UITableViewDelegate and UITableViewDatasource
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idString = @"idString";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:idString];
    
    UILabel *infoLab = [[UILabel alloc]init];
    infoLab.backgroundColor = [UIColor clearColor];
    infoLab.frame = CGRectMake(10, 0, cell.frame.size.width, cell.frame.size.height-10);
    [cell addSubview:infoLab];
    
    switch (indexPath.row)
    {
        case 0:     //声音提示
        {
            infoLab.text = @"声音提示";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UISwitch *sw = [[UISwitch alloc]init];
            sw.frame = CGRectMake(cell.frame.size.width-90, 10, 100, 30);
            [cell addSubview:sw];
            break;
        }
        case 1:     //安全应急救生卡
        {
            infoLab.text = @"安全应急就生卡";
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            break;
        }
        case 2:     //关于爱车帮帮帮
        {
            infoLab.text = @"关于爱车帮帮帮";
            break;
        }
        default:
            break;
    }
    
    [infoLab release];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            break;
        }
        case 1:     //安全救生卡
        {
            SettingSecureBoardViewController *ssVc = [[SettingSecureBoardViewController alloc]init];
            [self.navigationController pushViewController:ssVc animated:YES];
            [ssVc release];
            break;
        }
        case 2:     //帮助
        {
            SettingHelpViewController *shVc = [[SettingHelpViewController alloc]init];
            [self.navigationController pushViewController:shVc animated:YES];
            [shVc release];
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
