//
//  HSIDailyForecast.h
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSIDailyForecast : NSObject

//r=required o=optional //d=dependent (on above property unless noted)
@property (nonatomic) NSDate *time; //r

@property (nonatomic, copy) NSString *summary; //o

@property (nonatomic, copy) NSString *icon; //o

@property (nonatomic) NSDate *sunriseTime; //o

@property (nonatomic) NSDate *sunsetTime; //o

@property (nonatomic) double precipProbability; //o
@property (nonatomic) double precipIntensity; //o d

@property (nonatomic, copy) NSString *precipType;//o

@property (nonatomic) double temperatureLow; //o
@property (nonatomic) double temperatureHigh; //o d

@property (nonatomic) double apparentTemperature; //o d (on temperature)

@property (nonatomic) double humidity; //o

@property (nonatomic) double pressure; //o

@property (nonatomic) double windSpeed; //o
@property (nonatomic) int windBearing; //o d

@property (nonatomic) int uvIndex; //o

- (instancetype)initWithTime:(NSDate *)time summmary:(NSString *)summary icon:(NSString *)icon sunriseTime:(NSDate *)sunriseTime sunsetTime:(NSDate *)sunsetTime precipProbability:(double)precipProbability precipIntensity:(double)precipIntensity precipType:(NSString *)precipType pressure:(double)pressure temperatureLow:(double)temperatureLow temperatureHigh:(double)temperatureHigh apparentTemperature:(double)apparentTemperature humidity:(double)humidity windSpeed:(double)windSpeed windBearing:(int)windBearing uvIndex:(int)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
