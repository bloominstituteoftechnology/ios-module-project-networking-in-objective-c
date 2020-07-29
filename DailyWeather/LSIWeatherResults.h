//
//  LSIWeatherResults.h
//  DailyWeather
//
//  Created by Sean Acres on 7/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSICurrentForecast;
@class LSIHourlyForecast;
@class LSIDailyForecast;

@interface LSIWeatherResults : NSObject

- (instancetype)initWithCurrentForecast:(LSICurrentForecast *)currentForecast
                        hourlyForecasts:(NSArray<LSIHourlyForecast *> *)hourlyForecasts
                         dailyForecasts:(NSArray<LSIDailyForecast *> *)dailyForecasts NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly, copy) LSICurrentForecast *currentForecast;
@property (nonatomic, readonly, copy) NSArray<LSIHourlyForecast *> *hourlyForecasts;
@property (nonatomic, readonly, copy) NSArray<LSIDailyForecast *> *dailyForecasts;

@end

NS_ASSUME_NONNULL_END
