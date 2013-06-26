//
//  ChatListViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-21.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatListViewController : UIViewController<
                                                    UITableViewDelegate,
                                                    UITableViewDataSource>
{
    NSMutableArray  *chatArray;
    UITableView     *chatTab;
}

@end
