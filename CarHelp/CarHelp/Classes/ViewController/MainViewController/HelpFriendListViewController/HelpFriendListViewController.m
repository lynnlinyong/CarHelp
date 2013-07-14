//
//  HelpFriendListViewController.m
//  CarHelp
//
//  Created by lynn on 13-7-9.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "HelpFriendListViewController.h"

@interface HelpFriendListViewController ()

@end

@implementation HelpFriendListViewController
@synthesize frdArray;

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

- (void) dealloc
{
    [frdArray removeAllObjects];
    [frdArray release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    self.title = @"助友列表";
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(doSelector:)];
    self.navigationItem.rightBarButtonItem = barBtnItem;
    
    frdTab = [[UITableView alloc]init];
    frdTab.delegate = self;
    frdTab.dataSource = self;
    frdTab.frame = [UIView fitCGRect:CGRectMake(0, 0, 320, 420)];
    [self.view addSubview:frdTab];
}

- (void) doSelector:(id)sender
{
    
}

#pragma mark -
#pragma mark - HelpFriendTableViewCellDelegate
- (void)tableViewCell:(HelpFriendTableViewCell *)cell index:(int)index
{
    NSIndexPath *indexPath = [frdTab indexPathForCell:cell];
    NSMutableDictionary *dic = [frdArray objectAtIndex:indexPath.row];
    switch (index)
    {
        case 0:             //助友详细资料
        {
            FriendDetailViewController *fdVc = [[FriendDetailViewController alloc]init];
            fdVc.frd = [dic objectForKey:@"USER"];
            [self.navigationController pushViewController:fdVc animated:YES];
            [fdVc release];
            break;
        }
        case 1:             //请求帮助
        {
            NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:NOTICE_REQUEST_FRIEND_HELP],
                                     NOTICE_TYPE,dic, @"ID_DIC", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                object:nil
                                                              userInfo:infoDic];
            
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark - UITableViewDelegate and UITableViewDatasource
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return frdArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idString = @"idString";
    HelpFriendTableViewCell *cell = (HelpFriendTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell)
    {
        cell = [[[HelpFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:idString]autorelease];
    }
    
    NSDictionary *dic = [frdArray objectAtIndex:indexPath.row];
    Friend *frd = [dic objectForKey:@"USER"];
    [cell.headBtn setImage:[UIImage imageNamed:frd.head]
                  forState:UIControlStateNormal];
    cell.nameLab.text = frd.userName;
    cell.delegate = self;
    return cell;
}

@end
