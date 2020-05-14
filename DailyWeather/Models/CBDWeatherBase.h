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
@property (nonatomic, readwrite) NSString *summary;
@property (nonatomic, readwrite) NSString *icon;
@property (nonatomic, readwrite) NSNumber *precipProbability;
@property (nonatomic, readwrite) NSNumber *precipIntensity;
@property (nonatomic, readwrite) NSNumber *humidity;
@property (nonatomic, readwrite) NSNumber *pressure;
@property (nonatomic, readwrite) NSNumber *windSpeed;
@property (nonatomic, readwrite) NSNumber *windBearing;
@property (nonatomic, readwrite) NSNumber *uvIndex;

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
