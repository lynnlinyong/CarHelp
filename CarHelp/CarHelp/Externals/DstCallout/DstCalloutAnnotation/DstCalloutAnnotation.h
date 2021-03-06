//
//  DstCalloutAnnotation.h
//  CarHelp
//
//  Created by lynn on 13-7-4.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DstCalloutAnnotation : NSObject<BMKAnnotation>
@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;
@property (retain,nonatomic) NSDictionary *locationInfo;//callout吹出框要显示的各信息

- (id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)lon;
@end
