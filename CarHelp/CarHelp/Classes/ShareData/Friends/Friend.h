//
//  Friends.h
//  CarHelp
//
//  Created by lynn on 13-6-25.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject <NSCopying, NSMutableCopying>
{
    NSString        *accountId;     //助号
    NSString        *userName;      //用户名
    NSString        *head;          //头像
    NSString        *goodSkills;    //特长
    long            score;          //积分
    long            honre;          //荣誉
    long            helpCount;      //帮助数
    float           packagePercent; //装备完善度
    BOOL            isFastFrd;      //是否是密友
    
    /**
     *缺少活跃度
     **/
}
@property (nonatomic, retain) NSString  *accountId;
@property (nonatomic, retain) NSString  *userName;
@property (nonatomic, retain) NSString  *head;
@property (nonatomic, retain) NSString  *goodSkills;
@property (nonatomic, assign) long score;
@property (nonatomic, assign) long honre;
@property (nonatomic, assign) long helpCount;
@property (nonatomic, assign) float packagePercent;
@property (nonatomic, assign) BOOL isFastFrd;
@end
