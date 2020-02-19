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

/// Based on possible entries from `icon`: https://darksky.net/dev/docs

+ (NSArray<NSString *> *)weatherIcons {
    if(!_icons) {
        _icons = @[
            @"clear-day",
            @"clear-day",
            @"clear-night",
            @"partly-cloudy-day",
            @"partly-cloudy-night",
            @"cloudy",
            @"rain",
            @"sleet",
            @"snow",
            @"wind",
            @"fog",
            
            // Extras may not be used, but mentioned in API docs
            @"hail",
            @"thunderstorm",
            @"tornado",
            
            // Extras for sunrise stretch goal
            @"sunrise",
            @"sunset",
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
