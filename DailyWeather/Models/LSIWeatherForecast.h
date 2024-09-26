//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Claudia Maciel on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@class LSICurrentForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

- (instancetype)initWithCurrently:(LSICurrentForecast *)currently
                            daily:(NSArray<LSIDailyForecast *> *)daily
                           hourly:(NSArray<LSIHourlyForecast *> *)hourly
                         latitude:(double)latitude
                        longitude:(double)longitude
                         timezone:(NSString *)timezone;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) LSICurrentForecast *currently;
@property (nonatomic, readonly, copy) NSArray<LSIDailyForecast *> *daily;
@property (nonatomic, readonly, copy) NSArray<LSIHourlyForecast *> *hourly;
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly, copy) NSString *timezone;

@end

NS_ASSUME_NONNULL_END
