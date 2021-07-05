//
//  LSIWeatherIcons.m
//
//  Created by Paul Solt on 2/12/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherIcons.h"

@interface LSIWeatherIcons ()
    
@end

@implementation LSIWeatherIcons

static NSArray<NSString *> *_icons = nil;
static NSString *unknownIcon = @"questionmark.circle.fill";

/// Based on possible entries from `icon`: https://openweathermap.org/weather-conditions

+ (NSArray<NSString *> *)weatherIcons {
    if(!_icons) {
        _icons = @[
            @"01d",
            @"01n",
            @"02d",
            @"02n",
            @"03d",
            @"03n",
            @"04d",
            @"04n",
            @"09d",
            @"09n",
            @"10d",
            @"10n",
            @"11d",
            @"11n",
            @"13d",
            @"13n",
            @"50d",
            @"50n",
        ];
    }
    return _icons;
}

+ (UIImage *)weatherImageForIconName:(NSString *)iconName {
    NSString *icon = iconName;
    if (![LSIWeatherIcons.weatherIcons containsObject: iconName]) {
        icon = @"unknown";
    }
    return [UIImage imageNamed:icon];;
}

@end
