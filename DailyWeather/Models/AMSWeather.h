//
//  AMSWeather.h
//  DailyWeather
//
//  Created by Alexander Supe on 19.03.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMSCurrentForecast.h"
#import "AMSDailyWeather.h"
#import "AMSHourlyWeather.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMSWeather : NSObject

@property (nonatomic, readonly) AMSCurrentForecast *currently;
@property (nonatomic, readonly) NSMutableArray<AMSDailyWeather *> *daily;
@property (nonatomic, readonly) NSMutableArray<AMSHourlyWeather *> *hourly;

- (instancetype)initWithCurrently:(AMSCurrentForecast *)currently
                            daily:(NSMutableArray<AMSDailyWeather *> *)daily
                           hourly:(NSMutableArray<AMSHourlyWeather *> *)hourly;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
