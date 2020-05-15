//
//  LSIWeatherIcons.h
//  WeatherObjC
//
//  Created by Paul Solt on 2/12/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSIWeatherIcons : NSObject


/// Current images supported include
///     clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night,
///     hail, thunderstorm, tornado, or huricane
///     sunrise, sunset
///  NOTE: If any other value is provided, it will return a ? icon
+ (UIImage *)weatherImageForIconName:(NSString *)iconName;


@end


