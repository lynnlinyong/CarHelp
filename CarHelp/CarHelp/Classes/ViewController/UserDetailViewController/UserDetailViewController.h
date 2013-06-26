//
//  UserDetailViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-24.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserDetailViewController : UIViewController<
                                                    UITableViewDelegate,
                                                    UITableViewDataSource>
{
    User *user;
    UITableView *userTab;
}

@property (nonatomic, retain) User *user;
@end
