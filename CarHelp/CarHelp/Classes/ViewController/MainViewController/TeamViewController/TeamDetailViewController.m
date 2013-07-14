//
//  TeamDetailViewController.m
//  CarHelp
//
//  Created by lynn on 13-7-14.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "TeamDetailViewController.h"

@interface TeamDetailViewController ()

@end

@implementation TeamDetailViewController
@synthesize team;

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
    teamDetailTab.delegate = nil;
    teamDetailTab.dataSource = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [teamDetailTab release];
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    self.title = @"团成员管理";
    
    teamDetailTab = [[UITableView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(0, 0, 320, 420)]
                                                style:UITableViewStyleGrouped];
    teamDetailTab.delegate = self;
    teamDetailTab.dataSource = self;
    [self.view addSubview:teamDetailTab];
    
    
    photoWall = [[HGPhotoWall alloc] initWithFrame:CGRectZero];
    [photoWall setPhotos:[NSArray arrayWithObjects:
                               @"http://www.weiphone.com/images_v3/logo.png",
                               @"http://www.cocoachina.com/cms/uploads/allimg/121204/4196-1212041055480-L.jpg",
                               @"http://www.cocoachina.com/cms/uploads/allimg/121204/4196-1212041513010-L.jpg",
                               @"http://www.cocoachina.com/cms/uploads/allimg/121204/4196-1212041F4430-L.jpg",
                               @"http://www.cocoachina.com/cms/uploads/allimg/121204/4196-121204091R70-L.jpg",
                               @"http://cc.cocimg.com/bbs/attachment/upload/21/126211338811104.jpg", nil]];
    photoWall.delegate = self;
    [photoWall setEditModel:YES];
}

- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 3;
            break;
        }
        case 1:
        {
            return 1;
            break;
        }
        default:
            break;
    }
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return photoWall;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return photoWall.frame.size.height;
    }
    
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idString = @"idString";
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
                    if (!cell)
                    {
                        cell = [[UITableViewCell alloc]initWithStyle:
                                UITableViewCellStyleDefault reuseIdentifier:idString];
                    }
                    UILabel *infoLab = [[UILabel alloc]init];
                    infoLab.text  = [NSString stringWithFormat:@"团名称:%@", team.teamName];
                    infoLab.frame = CGRectMake(10, 12, 200, 20);
                    infoLab.backgroundColor = [UIColor clearColor];
                    [cell addSubview:infoLab];
                    [infoLab release];
                    return cell;
                    break;
                }
                case 1:
                {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
                    if (!cell)
                    {
                        cell = [[UITableViewCell alloc]initWithStyle:
                                UITableViewCellStyleDefault reuseIdentifier:idString];
                    }
                    UILabel *infoLab = [[UILabel alloc]init];
                    infoLab.text  = @"团形象:";
                    infoLab.frame = CGRectMake(10, 12, 80, 20);
                    infoLab.backgroundColor = [UIColor clearColor];
                    [cell addSubview:infoLab];
                    [infoLab release];
                    
                    UIImageView *teamImgView = [[UIImageView alloc]init];
                    teamImgView.frame = CGRectMake(90, 2, 40, 40);
                    teamImgView.image = [UIImage imageNamed:team.teamIcon];
                    [cell addSubview:teamImgView];
                    [teamImgView release];
                    return cell;
                    break;
                }
                case 2:
                {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
                    if (!cell)
                    {
                        cell = [[UITableViewCell alloc]initWithStyle:
                                UITableViewCellStyleDefault reuseIdentifier:idString];
                    }
                    UILabel *infoLab = [[UILabel alloc]init];
                    infoLab.text  = [NSString stringWithFormat:@"团描述:%@", team.teamDescripte];
                    infoLab.frame = CGRectMake(10, 12, 200, 20);
                    infoLab.backgroundColor = [UIColor clearColor];
                    [cell addSubview:infoLab];
                    [infoLab release];
                    return cell;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:
                        UITableViewCellStyleDefault reuseIdentifier:idString];
            }
            UILabel *cntLab = [[UILabel alloc]init];
            cntLab.backgroundColor = [UIColor clearColor];
            cntLab.text  = @"删除并退出";
            cntLab.textAlignment = NSTextAlignmentCenter;
            cntLab.frame = CGRectMake(50, 12, 200, 20);
            [cell addSubview:cntLab];
            [cntLab release];
            return cell;
            break;
        }
        default:
            break;
    }

    return nil;
}

#pragma mark -
#pragma mark - HGPhotoWallDelegate
- (void) photoWallReaload
{
    [teamDetailTab reloadData];
}

- (void)photoWallPhotoTaped:(NSUInteger)idex
{
    index = idex;
    UIActionSheet *actionSheetTemp = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:@"删除图片"
                                                        otherButtonTitles:nil, nil];
    [actionSheetTemp showInView:self.view];
    [actionSheetTemp release];
    [teamDetailTab reloadData];
}

- (void)photoWallMovePhotoFromIndex:(NSInteger)index toIndex:(NSInteger)newIndex
{
    
}

- (void)photoWallAddAction
{
    [photoWall addPhoto:@"http://cc.cocimg.com/bbs/attachment/upload/92/1226921340986127.jpg"];
}

- (void)photoWallAddFinish
{
    
}

- (void)photoWallDeleteFinish
{
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [photoWall deletePhotoByIndex:index];
    }
}
@end
