//
//  CBDHourlyForcast.h
//  DailyWeather
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDWeatherBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBDHourlyForcast : CBDWeatherBase

@property (nonatomic) NSString *precipType;
@property (nonatomic) NSNumber *temperatureLow;
@property (nonatomic) NSNumber *temperatureHigh;
@property (nonatomic) NSNumber * apparentTemperature;
@property (nonatomic) NSNumber *temperature;

- (instancetype)initWithTemperatureLow:(NSNumber *)temperatureLow
                       temperatureHigh:(NSNumber *)temperatureHigh
                   apparentTemperature:(NSNumber *)apparentTemperature
                           temperature:(NSNumber *)temperature
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
