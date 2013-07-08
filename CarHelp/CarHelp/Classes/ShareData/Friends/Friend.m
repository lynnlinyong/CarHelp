//
//  Friends.m
//  CarHelp
//
//  Created by lynn on 13-6-25.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "Friend.h"

@implementation Friend
@synthesize head;
@synthesize score;
@synthesize honre;
@synthesize userName;
@synthesize accountId;
@synthesize isFastFrd;
@synthesize helpCount;
@synthesize goodSkills;
@synthesize packagePercent;
@synthesize carNumber;
@synthesize drvExp;

- (id) init
{
    self = [super init];
    if (self)
    {
        head = [[NSString alloc]init];
        userName   = [[NSString alloc]init];
        accountId  = [[NSString alloc]init];
        goodSkills = [[NSString alloc]init];
        carNumber  = [[NSString alloc]init];
        
        drvExp = 0;
        score  = 0;
        honre  = 0;
        isFastFrd = NO;
        helpCount = 0;
        packagePercent = 0.0;
    }
    
    return self;
}

- (void) dealloc
{
    [head       release];
    [userName   release];
    [accountId  release];
    [goodSkills release];
    [carNumber  release];
    [super dealloc];
}

- (id) copyWithZone:(NSZone *)zone
{
    Friend *obj = NSCopyObject(self, 0, zone);
    if (obj)
    {
        head = [obj.head copy];
        userName   = [obj.userName copy];
        accountId  = [obj.accountId copy];
        goodSkills = [obj.goodSkills copy];
        carNumber  = [obj.carNumber copy];
        
        drvExp = obj.drvExp;
        score  = obj.score;
        honre  = obj.honre;
        isFastFrd = obj.isFastFrd;
        helpCount = obj.helpCount;
        packagePercent = obj.packagePercent;
    }
    
    return obj;
}

- (id) mutableCopyWithZone:(NSZone *)zone
{
    Friend *obj = NSCopyObject(self, 0, zone);
    if (obj)
    {
        head = [obj.head copy];
        userName   = [obj.userName   copy];
        accountId  = [obj.accountId  copy];
        goodSkills = [obj.goodSkills copy];
        carNumber  = [obj.carNumber  copy];
        
        drvExp = obj.drvExp;
        score  = obj.score;
        honre  = obj.honre;
        isFastFrd = obj.isFastFrd;
        helpCount = obj.helpCount;
        packagePercent = obj.packagePercent;
    }
    
    return obj;
}
@end
