//
//  Team.m
//  CarHelp
//
//  Created by lynn on 13-7-14.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "Team.h"

@implementation Team
@synthesize teamDescripte;
@synthesize teamIcon;
@synthesize teamName;

- (id) init
{
    self = [super init];
    if (self)
    {
        teamName = [[NSString alloc]init];
        teamIcon = [[NSString alloc]init];
        teamDescripte = [[NSString alloc]init];
    }
    
    return self;
}

- (void) dealloc
{
    [teamIcon release];
    [teamName release];
    [teamDescripte release];
    [super dealloc];
}

- (id) copyWithZone:(NSZone *)zone
{
    Team *obj = NSCopyObject(self, 0, zone);
    if (obj)
    {
        teamIcon = [obj.teamIcon copy];
        teamName = [obj.teamName copy];
        teamDescripte = [obj.teamDescripte copy];
    }
    
    return obj;
}

- (id) mutableCopyWithZone:(NSZone *)zone
{
    Team *obj = NSCopyObject(self, 0, zone);
    if (obj)
    {
        teamIcon = [obj.teamIcon copy];
        teamName = [obj.teamName copy];
        teamDescripte = [obj.teamDescripte copy];
    }
    
    return obj;
}
@end
