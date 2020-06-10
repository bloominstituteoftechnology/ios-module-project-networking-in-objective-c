//
//  HSIDailyWeather.m
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import "HSIDailyWeather.h"

@implementation HSIDailyWeather

- (instancetype)initWithIcon:(NSString *)icon
                highTemperature:(double)highTemperature
                 lowTemperature:(double)lowTemperature {
    self = [self init];

    if (self) {
        _icon = icon;
        _highTemperature = highTemperature;
        _lowTemperature = lowTemperature;
    }

    return self;
}

@end
