//
//  HSIDailyForecast.h
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSICurrentForecast.h"
#import "HSIDailyForecast.h"
#import "HSIHourlyForecast.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSIWeatherForecast : NSObject

@property HSICurrentForecast *currentForecast;
@property NSArray<HSIDailyForecast *> *dailyForecasts;
@property NSArray<HSIHourlyForecast *> *hourlyForecasts;

- (instancetype)initWithCurrentForecast:(HSICurrentForecast *)currentForecast dailyForecasts:(NSArray<HSIDailyForecast *> *)dailyForecasts hourlyForecasts:(NSArray<HSIHourlyForecast *> *)hourlyForecasts;

- (instancetype)initWithDictionary:(NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
