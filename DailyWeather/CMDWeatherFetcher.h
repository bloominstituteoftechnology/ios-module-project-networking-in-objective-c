//
//  CMDWeatherFetcher.h
//  DailyWeather
//
//  Created by Chris Dobek on 6/11/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMDWeatherForecast;

typedef void (^CMDWeatherFetcherCompletion)(CMDWeatherForecast *_Nullable forcast, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface CMDWeatherFetcher : NSObject

- (void)fetchWeatherAtLatitude:(double)latitude
                     longitude:(double)longitude
               completionBlock:(CMDWeatherFetcherCompletion)completionBlock;

@end

NS_ASSUME_NONNULL_END
