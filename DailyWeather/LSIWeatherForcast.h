//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by Bhawnish Kumar on 6/10/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIHourlyWeather;
@class LSIDailyForcast;
@class LSICurrentWeather;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject

@property (nonatomic, readonly) LSICurrentWeather *currently;
@property (nonatomic, readonly) LSIDailyForcast *daily;
@property (nonatomic, readonly) LSIHourlyWeather *hourly;

- (instancetype)initWithCurrently:(LSICurrentWeather *)currently
                            daily:(LSIDailyForcast *)daily
                           hourly:(LSIHourlyWeather *)hourly;



- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
