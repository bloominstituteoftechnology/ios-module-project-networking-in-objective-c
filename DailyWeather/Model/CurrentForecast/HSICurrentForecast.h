//
//  HSICurrentForecast.h
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSICurrentForecast : NSObject

@property (nonatomic) NSDate *time;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic) double precipProbability;
@property (nonatomic) double precipIntensity;

@property (nonatomic) double temperature;
@property (nonatomic) double apparentTemperature;

@property (nonatomic) double humidity;

@property (nonatomic) double pressure;

@property (nonatomic) double windSpeed;
@property (nonatomic) int windBearing;

- (instancetype) initWithTime:(NSDate *)time summary:(NSString *)summary icon:(NSString *)icon precipProbability:(double)precipProbability precipIntensity:(double)precipIntensity temperature:(double)temperature apparentTemperature:(double)apparentTemperature humidity:(double)humidity pressure:(double)pressure windSpeed:(double)windSpeed windBearing:(int)windBearing;

- (instancetype) initWithDictionary:(NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
