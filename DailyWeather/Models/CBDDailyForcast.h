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
@property (nonatomic) NSNumber *temperatureLow;
@property (nonatomic) NSNumber *temperatureHigh;

- (instancetype)initWithTemperatureLow:(NSNumber *)temperatureLow
                       temperatureHigh:(NSNumber *)temperatureHigh
                           sunriseTime:(NSDate *)sunriseTime
                            sunsetTime:(NSDate *)sunsetTime
                            precipType:(NSString *)precipType
                                  time:(NSDate *)time
                               summary:(NSString *)summary
                                  icon:(NSString *)icon
                     precipProbability:(NSNumber *)precipProbability
                       precipIntensity:(NSNumber *)precipIntensity
                              humidity:(NSNumber *)humidity
                              pressure:(NSNumber *)pressure
                             windSpeed:(NSNumber *)windSpeed
                           windBearing:(NSNumber *)windBearing
                               uvIndex:(NSNumber *)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
