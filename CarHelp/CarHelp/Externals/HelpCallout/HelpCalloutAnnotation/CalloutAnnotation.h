//
//  HelpCalloutAnnotation.h
//  CarHelp
//
//  Created by lynn on 13-7-7.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalloutAnnotation : CustomPointAnnotation
@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;
- (id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)lon;
@end
