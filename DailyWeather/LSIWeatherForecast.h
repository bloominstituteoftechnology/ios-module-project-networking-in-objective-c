//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Cora Jacobson on 11/18/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentForecast.h"
#import "DailyForecast.h"
#import "HourlyForecast.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

@property (nonatomic, readonly) CurrentForecast *currentWeather;
@property (nonatomic, readonly) NSArray<DailyForecast *> *dailyWeather;
@property (nonatomic, readonly) NSArray<HourlyForecast *> *hourlyWeather;

- (instancetype)initWithCurrentWeather:(CurrentForecast *)currentWeather
                          dailyWeather:(NSArray<DailyForecast *> *)dailyWeather
                         hourlyWeather:(NSArray<HourlyForecast *> *)hourlyWeather;

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end

NS_ASSUME_NONNULL_END
