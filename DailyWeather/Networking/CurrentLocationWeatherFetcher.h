//
//  CurrentLocationWeatherFetcher.h
//  DailyWeather
//
//  Created by Nick Nguyen on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LSICurrenWeatherMock;
@class CurrentUserLocationWeather;
typedef void (^LSICurrentLocationFetcherCompletionBlock)(CurrentUserLocationWeather  *_Nullable weather, NSError * _Nullable error);

@interface CurrentLocationWeatherFetcher : NSObject

- (void)fetchCurrentWeatherUsingLatitude:(double)latitude longtitude:(double)longitude completionBlock:(LSICurrentLocationFetcherCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END

