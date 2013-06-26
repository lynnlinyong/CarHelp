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

- (id) init
{
    self = [super init];
    if (self)
    {
        head = [[NSString alloc]init];
        userName   = [[NSString alloc]init];
        accountId  = [[NSString alloc]init];
        goodSkills = [[NSString alloc]init];
        
        score = 0;
        honre = 0;
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
    [super dealloc];
}

- (id) copyWithZone:(NSZone *)zone
{
    Friend *obj = NSCopyObject(self, 0, zone);
    if (obj)
    {
        head = [[NSString alloc]init];
        userName   = [[NSString alloc]init];
        accountId  = [[NSString alloc]init];
        goodSkills = [[NSString alloc]init];
        
        score = 0;
        honre = 0;
        isFastFrd = NO;
        helpCount = 0;
        packagePercent = 0.0;
    }
    
    return obj;
}

- (id) mutableCopyWithZone:(NSZone *)zone
{
    Friend *obj = NSCopyObject(self, 0, zone);
    if (obj)
    {
        head = [[NSString alloc]init];
        userName   = [[NSString alloc]init];
        accountId  = [[NSString alloc]init];
        goodSkills = [[NSString alloc]init];
        
        score = 0;
        honre = 0;
        isFastFrd = NO;
        helpCount = 0;
        packagePercent = 0.0;
    }
    
    return obj;
}
@end
