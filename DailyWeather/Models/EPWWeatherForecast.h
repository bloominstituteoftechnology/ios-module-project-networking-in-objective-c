//
//  EPWWeatherForecast.h
//  DailyWeather
//
//  Created by Elizabeth Wingate on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class EPWCurrentForecast;
@class EPWDailyWeather;
@class EPWHourlyWeather;

NS_ASSUME_NONNULL_BEGIN


@interface EPWWeatherForecast : NSObject

@property CLLocationCoordinate2D location;
@property EPWCurrentForecast *current;
@property NSArray<EPWDailyWeather *> *daily;
@property NSArray<EPWHourlyWeather *> *hourly;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
