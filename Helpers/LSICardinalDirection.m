//
//  LSICardinalDirection.m
//
//  Created by Paul Solt on 2/17/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICardinalDirection.h"

@implementation LSICardinalDirection

+ (NSString *)directionForHeading:(double)bearing {
    double increment = 45.0;
    double offset = increment / 2.0;
    double cleanedBearing = fmod(bearing, 360.0); // maps 720 to 360 so it doesn't go out of bounds
    NSLog(@"cleaned: %f %f", bearing, cleanedBearing);
    int index = (int)((cleanedBearing + offset) / increment); // N = [-22.5 - 22.5)
    NSArray *cardinals = @[@"N", @"NE", @"E", @"SE", @"S", @"SW", @"W", @"NW", @"N"];
    return cardinals[index];
}

@end
