//
//  SplashLastView.h
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashLastView;
@protocol SplashLastDelegate <NSObject>

- (void) splashView:(SplashLastView *) view doClicked:(UIButton *) btn;

@end

@interface SplashLastView : UIView
{
    
}
@property (assign,nonatomic) id<SplashLastDelegate> delegate;
@property (nonatomic, retain) UIImageView *spImgView;
@property (nonatomic, retain) UIButton    *goMainBtn;
@end
