//
//  Team.h
//  CarHelp
//
//  Created by lynn on 13-7-14.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject <NSCopying, NSMutableCopying>
{
    NSString    *teamIcon;
    NSString    *teamName;
    NSString    *teamDescripte;
}

@property (nonatomic, retain) NSString  *teamIcon;
@property (nonatomic, retain) NSString  *teamName;
@property (nonatomic, retain) NSString  *teamDescripte;
@end
