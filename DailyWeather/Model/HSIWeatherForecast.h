//
//  HSIDailyWeather.h
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSICurrentForecast.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSIWeatherForecast : NSObject

@property HSICurrentForecast *currentForecast;

- (instancetype)initWithDictionary:(NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
