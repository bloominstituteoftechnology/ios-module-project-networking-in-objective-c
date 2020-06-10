//
//  HSIDailyWeather.h
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSIDailyWeather : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic) double highTemperature;
@property (nonatomic) double lowTemperature;

- (instancetype)initWithIcon:(NSString *)icon highTemperature:(double)highTemperature lowTemperature:(double)lowTemperature;

@end

NS_ASSUME_NONNULL_END
