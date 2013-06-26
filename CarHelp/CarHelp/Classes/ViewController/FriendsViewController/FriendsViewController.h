//
//  FriendsViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-21.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsViewController : UIViewController<
                                                    UISearchBarDelegate,
                                                    UITableViewDelegate,
                                                    UITableViewDataSource,
                                                    UISearchDisplayDelegate>
{
    NSMutableArray  *searchArray;
    NSMutableArray  *frdArray;
    
    UITableView     *frdTab;
    UISearchBar     *searchBar;
    UISearchDisplayController *searchDisplay;
}
@end
