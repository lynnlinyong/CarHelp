//
//  HelpHistoryViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-21.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "ShareData.h"
#import "HelpHistoryViewController.h"

@interface HelpHistoryViewController ()

@end

@implementation HelpHistoryViewController

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
    historyTab.delegate = nil;
    historyTab.dataSource = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [historyTab release];
    historyTab = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    self.title = @"救帮黑匣子";
    
    historyArray = [[NSMutableArray alloc]init];
    
    historyTab = [[UITableView alloc]init];
    historyTab.frame = [UIView fitCGRect:CGRectMake(0, 0, 320, 420)];
    historyTab.delegate = self;
    historyTab.dataSource = self;
    [self.view addSubview:historyTab];
}

#pragma mark - 
#pragma mark - UITabelViewDelegate and UITableDatasource
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idString = @"idString";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:idString]autorelease];
    }
    cell.textLabel.text = @"张三帮助我";
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelpDetailViewController *hdVc = [[HelpDetailViewController alloc]init];
    [self.navigationController pushViewController:hdVc animated:YES];
    [hdVc release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
