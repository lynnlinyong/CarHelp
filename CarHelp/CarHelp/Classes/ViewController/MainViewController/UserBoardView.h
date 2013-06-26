//
//  UserBoardView.h
//  CarHelp
//
//  Created by lynn on 13-6-24.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class UserBoardView;
@protocol UserBoardViewDelegate <NSObject>

- (void) userBoardView:(UserBoardView *)view headClicked:(id)sender;

@end

@interface UserBoardView : UIView
{    
    UILabel     *unLab;
    UILabel     *hcLab;
    UILabel     *scoreLab;
    UILabel     *honorLab;
    UILabel     *activeLab;
    UIButton    *headBtn;
}

@property (nonatomic, assign) id<UserBoardViewDelegate> delegate;
- (id) initWithFrame:(CGRect)frame withUser:(User *)user;
@end
