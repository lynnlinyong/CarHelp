//
//  MainSplashViewController.h
//  LivAllRadar
//
//  Created by Lynn on 12-10-25.
//  Copyright (c) 2012年 WiMi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareData.h"

@interface MainSplashViewController : UIViewController<UIScrollViewDelegate,
                                                       SplashLastDelegate>
{
    
}
@property (retain, nonatomic) UIPageControl  *pageControl;
@property (retain, nonatomic) UIScrollView   *pageScroll;
@property (nonatomic, retain) SplashLastView *slView;
@end