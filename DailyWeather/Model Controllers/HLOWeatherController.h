//
//  WeatherController.h
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// Class forward all models
@class LSIWeatherForecast;
@class LSIDailyForecast;
@class LSIHourlyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface HLOWeatherController : NSObject

// What I'll need...
// A current weather property
@property (nonatomic, readonly) LSIWeatherForecast *currentForecast;
// An array of hourly weather
@property (nonatomic, readonly) NSArray<LSIHourlyForecast *> *hourlyForecast;
// An array of daily weather
@property (nonatomic, readonly) NSArray<LSIDailyForecast *> *dailyForecast;
// Method for fetching from API

- (void)fetchForecastWithLatitude:(NSNumber *)latitude
                           longitude:(NSNumber *)longitude;

// Method for parsing the data separately (So that I may call this method with mock data)

- (void)parseJSONData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
