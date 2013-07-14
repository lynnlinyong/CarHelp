//
//  TeamViewController.h
//  CarHelp
//
//  Created by lynn on 13-7-14.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamViewController : UIViewController <
                                                TeamTableViewCellDelegate,
                                                UITableViewDelegate,
                                                UITableViewDataSource>
{
    UITableView     *teamTab;
    NSMutableArray  *teamArray;
}
@end
