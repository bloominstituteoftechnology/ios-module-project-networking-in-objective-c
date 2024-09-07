//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Cody Morley on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentWeather.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

@property CurrentWeather *currently;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
