//
//  CBDDailyForcast.h
//  DailyWeather
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDWeatherBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBDDailyForcast : CBDWeatherBase

@property (nonatomic) NSDate *sunriseTime;
@property (nonatomic) NSDate *sunsetTime;
@property (nonatomic) NSString *precipType;
@property (nonatomic) double temperatureLow;
@property (nonatomic) double temperatureHigh;

- (instancetype)initWithTemperatureLow:(double)temperatureLow
                       temperatureHigh:(double)temperatureHigh
                           sunriseTime:(NSDate *)sunriseTime
                            sunsetTime:(NSDate *)sunsetTime
                            precipType:(NSString *)precipType
                                  time:(NSDate *)time
                               summary:(NSString *)summary
                                  icon:(NSString *)icon
                     precipProbability:(double)precipProbability
                       precipIntensity:(NSNumber *)precipIntensity
                              humidity:(double)humidity
                              pressure:(double)pressure
                             windSpeed:(double)windSpeed
                           windBearing:(double)windBearing
                               uvIndex:(double)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
