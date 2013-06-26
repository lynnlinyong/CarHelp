//
//  UIViewController+SearchViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "ShareData.h"
#import "UIViewController+SearchViewController.h"

@implementation UIViewController (SearchViewController)
- (UIViewController *)searchViewController:(NSString *)viewCtrName
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *navctr = (UINavigationController *)appDelegate.window.rootViewController;
    NSArray *ctrArray = navctr.viewControllers;
    for (UIViewController *vc in ctrArray)
    {
        if ([NSStringFromClass([vc class]) isEqualToString:viewCtrName])
        {
            return vc;
        }
    }
    
    return nil;
}
@end
