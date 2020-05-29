//
//  DSOWeatherController.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//Foward the classes here
@class LSIDailyForecast;
@class LSIHourlyForecast;
@class LSICurrentWeather;
@class LSIWeatherForcast;

typedef void(^WeatherFetcherCompletionHandler) (NSArray * _Nullable weather, NSError * _Nullable error);


NS_ASSUME_NONNULL_BEGIN

@interface DSOWeatherController : NSObject

@property (nonatomic, readonly) LSIWeatherForcast *currentForecast;
@property (nonatomic, readonly) NSMutableArray<LSIHourlyForecast *> *hourlyForecast;
@property (nonatomic, readonly) NSMutableArray<LSIDailyForecast *> *dailyForecast;

//Fetch from API
- (void)fetchWeatherByLocation:(double)latitude
longitude:(double)longitude
completion:(WeatherFetcherCompletionHandler)completion;

- (void)parseJSONData:(NSData *)data
completionBloc:(void (^)(NSError * _Nullable error))completionBlock;

@end

NS_ASSUME_NONNULL_END
