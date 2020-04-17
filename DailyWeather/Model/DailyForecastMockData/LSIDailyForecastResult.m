//
//  LSIDailyForecastResult.m
//  DailyWeather
//
//  Created by Nick Nguyen on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecastResult.h"

@implementation LSIDailyForecastResult

- (instancetype)initWithResult:(NSArray<LSIDailyForecast *> *)result
{
    self = [super init];
    if (self) {
        _result = [result copy];    
    }
    return self;
}
@end
