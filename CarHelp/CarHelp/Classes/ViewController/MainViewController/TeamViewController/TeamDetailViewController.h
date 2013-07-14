//
//  TeamDetailViewController.h
//  CarHelp
//
//  Created by lynn on 13-7-14.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamDetailViewController : UIViewController<
                                                    HGPhotoWallDelegate,
                                                    UITableViewDelegate,
                                                    UITableViewDataSource>
{
    int             index;
    HGPhotoWall     *photoWall;
    UITableView     *teamDetailTab;
}

@property (nonatomic, retain) Team *team;
@end
