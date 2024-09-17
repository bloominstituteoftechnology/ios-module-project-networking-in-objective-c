//
//  SAHHourlyForecast.h
//  DailyWeather
//
//  Created by scott harris on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAHHourlyForecast : NSObject

@property NSDate *time;
@property NSString *summary;
@property NSString *icon;
@property double precipProbability;
@property double precipIntensity;
@property NSString *precipType;
@property double temperature;
@property double apparentTemperature;
@property double humidity;
@property double pressure;
@property double windSpeed;
@property double windBearing;
@property double uvIndex;

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                  precipType:(NSString *)precipType
             temperature:(double)temperature
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(double)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
