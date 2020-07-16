//
//  HourlyWeather.h
//  DailyWeather
//
//  Created by Bling Morley on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HourlyWeather : NSObject

@property NSDate *time;
@property NSString *summary;
@property UIImage *icon;
@property NSDate *sunrise;
@property NSDate *sunset;
@property double precipProbability;
@property double precipIntensity;
@property NSString *precipType;
@property double temperatureHigh;
@property double temperatureLow;
@property double apparentTemperature;
@property double humidity;
@property double pressure;
@property double windSpeed;
@property int windBearing;
@property int uvIndex;


- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(UIImage *)icon
                     sunrise:(NSDate *)sunrise
                      sunset:(NSDate *)sunset
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                  precipType:(NSString *)precipType
             temperatureHigh:(double)temperatureHigh
              temperatureLow:(double)temperatureLow
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(int)windBearing
                     uvIndex:(int)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
