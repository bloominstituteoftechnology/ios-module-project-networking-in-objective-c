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

@property (nonatomic) double temperature;
@property (nonatomic) double apparentTemperature;

- (instancetype)initWithTemperature:(double)temperature
                apparentTemperature:(double)apparentTemperature
                               time:(NSDate *)time
                            summary:(NSString *)summary
                               icon:(NSString *)icon
                  precipProbability:(double)precipProbability
                    precipIntensity:(double)precipIntensity
                           humidity:(double)humidity
                           pressure:(double)pressure
                          windSpeed:(double)windSpeed
                        windBearing:(double)windBearing
                            uvIndex:(double)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
