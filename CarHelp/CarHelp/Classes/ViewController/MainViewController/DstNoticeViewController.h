//
//  DstNoticeViewController.h
//  CarHelp
//
//  Created by lynn on 13-7-5.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DstNoticeViewController;
@protocol DstNoticeDelegate <NSObject>

- (void) viewController:(DstNoticeViewController *) viewController
                 sender:(id)sender;

@end

@interface DstNoticeViewController : UIViewController
@property (nonatomic, assign) id<DstNoticeDelegate> delegate;
@property (nonatomic, retain) NSDictionary  *resultDic;
@end
