//
//  CBDCurrentForcast.h
//  DailyWeather
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDWeatherBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBDCurrentForcast : CBDWeatherBase

@property (nonatomic) NSNumber *temperature;
@property (nonatomic) NSNumber *apparentTemperature;

- (instancetype)initWithTemperature:(NSNumber *)temperature
                apparentTemperature:(NSNumber *)apparentTemperature
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
