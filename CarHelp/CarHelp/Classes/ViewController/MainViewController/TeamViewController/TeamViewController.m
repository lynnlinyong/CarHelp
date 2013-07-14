//
//  TeamViewController.m
//  CarHelp
//
//  Created by lynn on 13-7-14.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "TeamViewController.h"

@interface TeamViewController ()

@end

@implementation TeamViewController

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

- (void) viewDidUnload
{
    teamTab.dataSource = nil;
    teamTab.delegate = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [teamTab release];
    [super dealloc];
}

#pragma mark - 
#pragma mark - Custom Action
- (void) initUI
{
    self.title = @"我的团";
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"添加"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(doAddTeam:)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    [rightBtnItem release];
    
    teamArray = [[NSMutableArray alloc]init];
    Team *team = [[Team alloc]init];
    team.teamName = @"南山一日游";
    team.teamDescripte = @"南山一日游";
    team.teamIcon = @"boy_1.png";
    [teamArray addObject:team];
    
    Team *team1 = [[Team alloc]init];
    team1.teamName = @"南山一日游";
    team1.teamDescripte = @"南山一日游";
    team1.teamIcon = @"boy_1.png";
    [teamArray addObject:team1];
    
    teamTab = [[UITableView alloc]init];
    teamTab.frame = [UIView fitCGRect:CGRectMake(0, 0, 320, 420)];
    teamTab.delegate   = self;
    teamTab.dataSource = self;
    [self.view addSubview:teamTab];
}

- (void) doAddTeam:(id)sender
{
    
}

#pragma mark -
#pragma mark - UITableViewDataSource and UITableViewDelegate
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return teamArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idString = @"idString";
    Team *team = [teamArray objectAtIndex:indexPath.row];
    TeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell)
    {
        cell = [[TeamTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:idString];
    }
    cell.team = team;
    cell.delegate = self;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - TeamTableViewCellDelegate
- (void) tableViewCell:(TeamTableViewCell *)cell index:(int)buttonIndex
{
    NSIndexPath *indexPath = [teamTab indexPathForCell:cell];
    Team *team = [teamArray objectAtIndex:indexPath.row];
    
    TeamDetailViewController *tdVc = [[TeamDetailViewController alloc]init];
    tdVc.team = [team copy];
    [self.navigationController pushViewController:tdVc
                                         animated:YES];
    [tdVc release];
}
@end
