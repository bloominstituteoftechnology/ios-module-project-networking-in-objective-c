//
//  CBDWeatherBase.h
//  DailyWeather
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBDWeatherBase : NSObject

@property (nonatomic) NSDate *time;
@property (nonatomic) NSString *summary;
@property (nonatomic) NSString *icon;
@property (nonatomic) double precipProbability;
@property (nonatomic) NSNumber *precipIntensity;
@property (nonatomic) double humidity;
@property (nonatomic) double pressure;
@property (nonatomic) double windSpeed;
@property (nonatomic) double windBearing;
@property (nonatomic) double uvIndex;

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(double)precipProbability
             precipIntensity:(NSNumber *)precipIntensity
                    humidity:(double)humidity
                    pressure:(double)pressure
           windSpeed:(double)windSpeed
           windBearing:(double)windBearing
           uvIndex:(double)uvIndex;

//- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
