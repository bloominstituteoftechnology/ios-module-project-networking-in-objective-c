//
//  AMSForcast.h
//  DailyWeather
//
//  Created by Alexander Supe on 20.03.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AMSForcast <NSObject>

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy) NSString *icon;
@property (nonatomic, readonly) NSNumber *precipProbability;
@property (nonatomic, readonly) NSNumber *precipIntensity;
@property (nonatomic, readonly, copy) NSString *precipType;
@property (nonatomic, readonly) NSNumber *temperatureLow;
@property (nonatomic, readonly) NSNumber *temperatureHigh;
@property (nonatomic, readonly) NSNumber *apparentTemperature;
@property (nonatomic, readonly) NSNumber *humidity;
@property (nonatomic, readonly) NSNumber *pressure;
@property (nonatomic, readonly) NSNumber *windSpeed;
@property (nonatomic, readonly) NSNumber *windBearing;
@property (nonatomic, readonly) NSNumber *uvIndex;

@end

NS_ASSUME_NONNULL_END
