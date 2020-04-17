//
//  LSIDailyForecastResult.h
//  DailyWeather
//
//  Created by Nick Nguyen on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LSIDailyForecast;
@interface LSIDailyForecastResult : NSObject

@property (nonatomic, readonly, copy) NSArray<LSIDailyForecast *> *result;

- (instancetype)initWithResult:(NSArray<LSIDailyForecast *> *)result;

@end

NS_ASSUME_NONNULL_END
