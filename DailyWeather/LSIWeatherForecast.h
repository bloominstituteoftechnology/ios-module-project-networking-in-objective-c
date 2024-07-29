//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Michael on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSICurrentForecast;
@class LSIDailyForecast;
@class LSIHourlyForecast;

@interface LSIWeatherForecast : NSObject

@property CLLocationCoordinate2D location;
@property LSICurrentForecast *current;
@property NSArray<LSIDailyForecast *> *daily;
@property NSArray<LSIHourlyForecast *> *hourly;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
