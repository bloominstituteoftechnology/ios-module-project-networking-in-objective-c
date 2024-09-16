//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Kelson Hartle on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

@class LSICurrentForecast;
@class LSIDailyForecast;
@class LSIHourlyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

@property CLLocationCoordinate2D location;
@property (nonatomic, readonly) LSICurrentForecast *currently;
@property (nonatomic, readonly, copy) NSArray<LSIDailyForecast *> *daily;
@property (nonatomic, readonly, copy) NSArray<LSIHourlyForecast *> *hourly;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
