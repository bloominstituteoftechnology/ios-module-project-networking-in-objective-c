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

@property (nonatomic, readwrite) NSDate *time;
@property (nonatomic, readwrite, nullable) NSString *summary;
@property (nonatomic, readwrite, nullable) NSString *icon;
@property (nonatomic, readwrite, nullable) NSNumber *precipProbability;
@property (nonatomic, readwrite, nullable) NSNumber *precipIntensity;
@property (nonatomic, readwrite, nullable) NSNumber *humidity;
@property (nonatomic, readwrite, nullable) NSNumber *pressure;
@property (nonatomic, readwrite, nullable) NSNumber *windSpeed;
@property (nonatomic, readwrite, nullable) NSNumber *windBearing;
@property (nonatomic, readwrite, nullable) NSNumber *uvIndex;

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(NSNumber *)precipProbability
             precipIntensity:(NSNumber *)precipIntensity
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
           windSpeed:(NSNumber *)windSpeed
           windBearing:(NSNumber *)windBearing
           uvIndex:(NSNumber *)uvIndex;

//- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
