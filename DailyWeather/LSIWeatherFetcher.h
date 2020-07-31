//
//  LSIWeatherFetcher.h
//  DailyWeather
//
//  Created by Kelson Hartle on 7/18/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSIWeatherForecast;

typedef void(^WeatherFetcherCompletionHandler) (NSArray * _Nullable weather, NSError * _Nullable error);


@interface LSIWeatherFetcher : NSObject

- (void)fetchWeatherByLocation:(double)latitude
                     longitude:(double)longitude
                    completion:(WeatherFetcherCompletionHandler)completion;


@end

NS_ASSUME_NONNULL_END
