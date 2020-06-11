//
//  HSIHourlyWeather.h
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSIHourlyForecast : NSObject

@property (nonatomic) NSDate *time;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic) double precipProbability;
@property (nonatomic) double precipIntensity;
@property (nonatomic, copy) NSString *precipType;
@property (nonatomic) double temperatureLow;
@property (nonatomic) double temperatureHigh;
@property (nonatomic) double apparentTemperature;
@property (nonatomic) double humidity;
@property (nonatomic) double pressure;
@property (nonatomic) double windSpeed;
@property (nonatomic) int windBearing;
@property (nonatomic) int uvIndex;

- (instancetype) initWithTime:(NSDate *)time summary:(NSString *)summary icon:(NSString *)icon precipProbability:(double)precipProbability precipIntensity:(double)precipIntensity precipType:(NSString *)precipType temperatureLow:(double)temperatureLow temperatureHigh:(double)temperatureHigh apparentTemperature:(double)apparentTemperature humidity:(double)humidity pressure:(double)pressure windSpeed:(double)windSpeed windBearing:(double)windBearing uvIndex:(double)uvIndex;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
