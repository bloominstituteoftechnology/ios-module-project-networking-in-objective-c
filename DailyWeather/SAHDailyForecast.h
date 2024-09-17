//
//  SAHDailyForecast.h
//  DailyWeather
//
//  Created by scott harris on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//time (unix time)
//summary
//icon
//sunriseTime
//sunsetTime
//precipProbability
//precipIntensity
//precipType ("rain", "snow", or "sleet", or nil)
//temperatureLow
//temperatureHigh
//apparentTemperature (Feels like)
//humidity
//pressure
//windSpeed
//windBearing
//uvIndex

@interface SAHDailyForecast : NSObject

@property NSDate *time;
@property NSString *summary;
@property NSString *icon;
@property NSDate *sunriseTime;
@property NSDate *sunsetTime;
@property double precipProbability;
@property double precipIntensity;
@property NSString *precipType;
@property double temperatureHigh;
@property double temperatureLow;
@property double apparentTemperature;
@property double humidity;
@property double pressure;
@property double windSpeed;
@property double windBearing;
@property double uvIndex;

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 sunriseTime:(NSDate *)sunriseTime
                  sunsetTime:(NSDate *)sunsetTime
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                  precipType:(NSString *)precipType
                 temperatureHigh:(double)temperatureHigh
              temperatureLow:(double)temperatureLow
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(double)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
