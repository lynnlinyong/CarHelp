//
//  ChatListViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-21.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "ShareData.h"
#import "ChatListViewController.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController

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
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void) viewDidUnload
{
    chatTab.delegate = nil;
    chatTab.dataSource = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [chatTab   release];
    [chatArray release];
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    self.title = @"会话";
    
    chatArray = [[NSMutableArray alloc]init];
    
    chatTab = [[UITableView alloc]init];
    chatTab.frame = [UIView fitCGRect:CGRectMake(0, 0, 320, 420)];
    chatTab.delegate = self;
    chatTab.dataSource = self;
    [self.view addSubview:chatTab];
}

#pragma mark -
#pragma mark - UITableViewDelegate and UITableDatasource
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    chatTab.frame = [UIView fitCGRect:CGRectMake(0, 0, 320, 1*44)];
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
    
    UIImageView *headImgView = [[UIImageView alloc]init];
    headImgView.image = [UIImage imageNamed:@"boy_1"];
    headImgView.frame = CGRectMake(5, 2, 40, 40);
    [cell addSubview:headImgView];
    [headImgView release];
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.text  = @"张三";
    nameLab.frame = CGRectMake(45, 2, 200, 20);
    nameLab.backgroundColor = [UIColor clearColor];
    [cell addSubview:nameLab];
    [nameLab release];
    
    UILabel *cntLab = [[UILabel alloc]init];
    cntLab.text  = @"吃饭了没!";
    cntLab.frame = CGRectMake(45, 22, 200, 20);
    cntLab.backgroundColor = [UIColor clearColor];
    [cell addSubview:cntLab];
    [cntLab release];
    
    UILabel *timeLab = [[UILabel alloc]init];
    timeLab.text  = @"13-6-25";
    timeLab.frame = CGRectMake(320-90, 2, 90, 20);
    timeLab.backgroundColor = [UIColor clearColor];
    [cell addSubview:timeLab];
    [timeLab release];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}
@end
