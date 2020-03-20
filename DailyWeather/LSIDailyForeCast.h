//
//  LSIDailyForecast.h
//  DailyWeather
//
//  Created by Michael on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIDailyForecast : NSObject

@property NSDate *time;
@property NSDate *sunriseTime;
@property NSDate *sunsetTime;
@property NSString *summary;
@property NSString *icon;
@property NSString *precipType;
@property double precipProbability;
@property double precipIntensity;
@property double temperatureLow;
@property double temperatureHigh;
@property double apparentTemperatureHigh;
@property double humidity;
@property double pressure;
@property double windSpeed;
@property double windBearing;
@property double uvIndex;

- (instancetype)initWithTime:(NSDate *)time
                sunsriseTime:(NSDate *)sunriseTime
                  sunsetTime:(NSDate *)sunsetTime
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                  precipType:(NSString *)precipType
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
              temperatureLow:(double)temperatureLow
             temperatureHigh:(double)temperatureHigh
     apparentTemperatureHigh:(double)apparentTemperatureHigh
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(double)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
