//
//  MenuViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<
                                                UITableViewDelegate,
                                                UITableViewDataSource,
                                                UserBoardViewDelegate>
{
    User *user;
}

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSMutableArray *viewContrs;
@property (nonatomic, retain) UITableView *menuTab;

@end
