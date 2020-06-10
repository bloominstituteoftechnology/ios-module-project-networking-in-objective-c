//
//  HSIDailyWeatherResults.h
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HSIDailyWeather;

@interface HSIDailyWeatherResults : NSObject

@property NSMutableArray<HSIDailyWeather *> *days;

- (instancetype)initWithArray:(NSMutableArray<HSIDailyWeatherResults *> *)array;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
