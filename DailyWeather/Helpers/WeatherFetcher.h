//
//  WeatherFetcher.h
//  DailyWeather
//
//  Created by Cora Jacobson on 11/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSIWeatherForecast.h"

typedef void(^WeatherFetcherCompletionHandler)(LSIWeatherForecast *_Nullable weather, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface WeatherFetcher : NSObject

+ (void)fetchWeatherWithLatitude:(double)latitude
                       longitude:(double)longitude
               CompletionHandler:(nonnull WeatherFetcherCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
