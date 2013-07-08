//
//  HelpCalloutAnnotation.m
//  CarHelp
//
//  Created by lynn on 13-7-7.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "HelpCalloutAnnotation.h"

@implementation HelpCalloutAnnotation
@synthesize latitude;
@synthesize longitude;
@synthesize locationInfo;

- (id)initWithLatitude:(CLLocationDegrees)lat
          andLongitude:(CLLocationDegrees)lon
{
    if (self = [super init])
    {
        self.latitude  = lat;
        self.longitude = lon;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude  = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}
@end
