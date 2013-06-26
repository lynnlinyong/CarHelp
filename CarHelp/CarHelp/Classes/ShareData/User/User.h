//
//  User.h
//  CarHelp
//
//  Created by lynn on 13-6-24.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCopying, NSMutableCopying>
{
    NSString        *userName;      //用户名
    NSString        *head;          //头像
    long            score;          //积分
    long            honre;          //荣誉值
    long            helpCount;      //帮助数
    /**
     *缺少活跃度
     **/
    
    NSString        *secureName;    //投保人姓名
    NSString        *idNum;         //身份证号
    NSString        *email;         //邮箱
    NSString        *phoneNum;      //移动电话
}

@property (nonatomic, retain) NSString *head;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, assign) long score;
@property (nonatomic, assign) long honre;
@property (nonatomic, assign) long helpCount;
@property (nonatomic, retain) NSString *secureName;
@property (nonatomic, retain) NSString *idNum;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *phoneNum;

@end
