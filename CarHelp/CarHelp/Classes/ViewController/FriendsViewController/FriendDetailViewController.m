//
//  FriendDetailViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-25.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "FriendDetailViewController.h"

@interface FriendDetailViewController ()

@end

@implementation FriendDetailViewController
@synthesize frd;

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
    frdTab.delegate = nil;
    frdTab.dataSource = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [frdTab release];
    frdTab = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    self.title = @"助友资料";
    
    UIImageView *headImgView = [[UIImageView alloc]init];
    headImgView.image = [UIImage imageNamed:frd.head];
    headImgView.frame = CGRectMake(120, 20, 80, 80);
    [self.view addSubview:headImgView];
    [headImgView release];
    
    UIButton *fastBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    if (frd.isFastFrd)
    {
        [fastBtn setTitle:@"取消密友"
                 forState:UIControlStateNormal];
    }
    else
    {
        [fastBtn setTitle:@"设为密友"
                 forState:UIControlStateNormal];
    }
    fastBtn.frame = [UIView fitCGRect:CGRectMake(220, 20, 100, 30)];
    [fastBtn addTarget:self
                action:@selector(doFastBtnClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fastBtn];
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.text  = frd.userName;
    nameLab.frame = [UIView fitCGRect:CGRectMake(10, 110, 100, 20)];
    [self.view addSubview:nameLab];
    [nameLab release];
    
    UILabel *scoreLab = [[UILabel alloc]init];
    scoreLab.text  = [NSString stringWithFormat:@"积分:%ld", frd.score];
    scoreLab.frame = [UIView fitCGRect:CGRectMake(120, 110, 100, 20)];
    [self.view addSubview:scoreLab];
    [scoreLab release];
    
    UILabel *hcLab = [[UILabel alloc]init];
    hcLab.text  = [NSString stringWithFormat:@"施助数:%ld", frd.helpCount];
    hcLab.frame = [UIView fitCGRect:CGRectMake(220, 110, 100, 20)];
    [self.view addSubview:hcLab];
    [hcLab release];
    
    UILabel *honreLab = [[UILabel alloc]init];
    honreLab.text  = [NSString stringWithFormat:@"荣誉:%ld", frd.honre];
    honreLab.frame = [UIView fitCGRect:CGRectMake(120, 130, 100, 20)];
    [self.view addSubview:honreLab];
    [honreLab release];
    
    UILabel *activeLab = [[UILabel alloc]init];
    activeLab.text  = [NSString stringWithFormat:@"活跃度:达人"];
    activeLab.frame = [UIView fitCGRect:CGRectMake(220, 130, 100, 20)];
    [self.view addSubview:activeLab];
    [activeLab release];
    
    frdTab = [[UITableView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(0, 160, 320, 150)]
                                         style:UITableViewStyleGrouped];
    frdTab.delegate   = self;
    frdTab.dataSource = self;
    frdTab.scrollEnabled = NO;
    frdTab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:frdTab];
    
    UIButton *chatBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    chatBtn.tag   = 0;
    chatBtn.frame = [UIView fitCGRect:CGRectMake(110, 330, 100, 30)];
    [chatBtn setTitle:@"对话"
             forState:UIControlStateNormal];
    [chatBtn addTarget:self
                action:@selector(doButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chatBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doFastBtnClicked:(id)sender
{
    UIButton *fastBtn = (UIButton *) sender;
    frd.isFastFrd = !frd.isFastFrd;
    if (frd.isFastFrd)
    {
        [fastBtn setTitle:@"取消密友"
                 forState:UIControlStateNormal];
    }
    else
    {
        [fastBtn setTitle:@"设为密友"
                 forState:UIControlStateNormal];
    }
}

- (void) doButtonClicked:(id)sender
{
    //进入聊天界面
}

#pragma mark -
#pragma mark - UITableViewDelegate and UITableDatasource
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
    NSString *idString    = @"idString";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:idString]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *cntLab = [[UILabel alloc]init];
    cntLab.frame = CGRectMake(20, 10, 300, 20);
    cntLab.backgroundColor = [UIColor clearColor];
    [cell addSubview:cntLab];
    switch (indexPath.row)
    {
        case 0:     //助友助号
        {
            
            cntLab.text = [NSString stringWithFormat:@"助友助号:%@", frd.accountId];
            break;
        }
        case 1:     //装备
        {
            cntLab.text = [NSString stringWithFormat:@"装备完整度:%f", frd.packagePercent];
            break;
        }
        case 2:     //帮助特长
        {
            cntLab.text = [NSString stringWithFormat:@"帮助特长:%@", frd.goodSkills];
            break;
        }
        default:
            break;
    }
    [cntLab release];
    
    return cell;
}

@end
