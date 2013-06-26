//
//  User.m
//  CarHelp
//
//  Created by lynn on 13-6-24.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize head;
@synthesize score;
@synthesize honre;
@synthesize userName;
@synthesize helpCount;
@synthesize secureName;
@synthesize idNum;
@synthesize email;
@synthesize phoneNum;

- (id) init
{
    self = [super init];
    if (self)
    {
        userName = [[NSString alloc]init];
        head  = [[NSString alloc]init];
        score = 0;
        honre = 0;
        helpCount = 0;
        
        secureName = [[NSString alloc]init];
        idNum      = [[NSString alloc]init];
        email      = [[NSString alloc]init];
        phoneNum   = [[NSString alloc]init];
    }
    
    return self;
}

- (void) dealloc
{
    [phoneNum release];
    [secureName release];
    [idNum release];
    [email release];
    
    [head release];
    [userName release];
    [super dealloc];
}

- (id) copyWithZone:(NSZone *)zone
{
    User *obj = NSCopyObject(self, 0, zone);
    if (obj)
    {
        obj.userName = [userName copy];
        obj.head  = [head copy];
        obj.score = score;
        obj.honre = honre;
        obj.helpCount = helpCount;
        
        obj.secureName = [secureName copy];
        obj.phoneNum = [phoneNum copy];
        obj.idNum = [idNum copy];
        obj.email = [email copy];
    }
    
    return obj;
}

- (id) mutableCopyWithZone:(NSZone *)zone
{
    User *obj = NSCopyObject(self, 0, zone);
    if (obj)
    {
        obj.userName = [userName copy];
        obj.head  = [head copy];
        obj.score = score;
        obj.honre = honre;
        obj.helpCount = helpCount;
        
        obj.secureName = [secureName copy];
        obj.phoneNum = [phoneNum copy];
        obj.idNum = [idNum copy];
        obj.email = [email copy];
    }
    
    return obj;
}
@end
