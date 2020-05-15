//
//  LSIWeatherFetch.h
//  DailyWeather
//
//  Created by Lydia Zhang on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSIWeatherForcast;
typedef void (^LSIWeatherFetcherCompletion)(LSIWeatherForcast *_Nullable weather, NSError * _Nullable error);
@interface LSIWeatherFetch : NSObject

- (void)fetchWeatherByLocationLatitude:(double)latitude longitude:(double)longitude completion:(LSIWeatherFetcherCompletion)completion;

@end

NS_ASSUME_NONNULL_END
