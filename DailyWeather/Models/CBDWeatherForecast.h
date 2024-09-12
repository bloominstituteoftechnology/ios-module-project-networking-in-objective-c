//
//  CBDWeatherForecast.h
//  DailyWeather
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBDCurrentForcast;
@class CBDDailyForcast;
@class CBDHourlyForcast;

NS_ASSUME_NONNULL_BEGIN

@interface CBDWeatherForecast : NSObject

@property (nonatomic) CBDCurrentForcast *currentForecast;
@property (nonatomic) NSArray<CBDHourlyForcast *> *hourlyForecasts;
@property (nonatomic) NSArray<CBDDailyForcast *> *dailyForecasts;

- (instancetype)initWithCurrentForecast:(CBDCurrentForcast *)currentForecast
                        hourlyForecasts:(NSArray *)hourlyForecasts
                         dailyForecasts:(NSArray *)dailyForecasts;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
