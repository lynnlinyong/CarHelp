//
//  HelpFriendListViewController.h
//  CarHelp
//
//  Created by lynn on 13-7-9.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpFriendTableViewCell.h"

@interface HelpFriendListViewController : UIViewController<
                                                        UITableViewDelegate,
                                                        UITableViewDataSource,
                                                        HelpFriendTableViewCellDelegate>
{
    NSMutableArray  *frdArray;
    UITableView     *frdTab;
}

@property (nonatomic, retain) NSMutableArray   *frdArray;
@end
