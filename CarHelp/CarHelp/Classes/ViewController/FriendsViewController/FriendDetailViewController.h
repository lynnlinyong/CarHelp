//
//  FriendDetailViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-25.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@interface FriendDetailViewController : UIViewController<
                                                        UITableViewDelegate,
                                                        UITableViewDataSource>
{
    Friend  *frd;
    UITableView *frdTab;
}

@property (nonatomic, retain) Friend *frd;
@end
