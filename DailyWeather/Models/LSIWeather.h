//
//  LSIWeather.h
//  DailyWeather
//
//  Created by Ufuk Türközü on 16.04.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSICurrentForcast;
@class LSIHourlyForecast;
@class LSIDailyForecast;

@interface LSIWeather : NSObject

@property CLLocationCoordinate2D location;
@property LSICurrentForcast *currently;
@property NSArray<LSIDailyForecast *> *daily;
@property NSArray<LSIHourlyForecast *> *hourly;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
