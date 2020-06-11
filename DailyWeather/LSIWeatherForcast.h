//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by Bhawnish Kumar on 6/10/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject

@property (nonatomic) NSDate *time;
@property (nonatomic, nullable, readonly) NSString *summaryç;
@property(nonatomic, nullable, readonly)  NSString *icon;
@property (nonatomic, nullable, readonly) NSNumber *precipProbability;
@property (nonatomic, nullable, readonly) NSNumber *precipIntensity;
@property (nonatomic, nullable, readonly) NSNumber *temperatur;
@property (nonatomic, nullable, readonly) NSNumber *apperantTemperature;
@property (nonatomic, nullable, readonly) NSNumber *humidity;
@property (nonatomic, nullable, readonly) NSNumber *pressure;
@property (nonatomic, nullable, readonly) NSNumber *windSpeed;
@property (nonatomic, nullable, readonly) NSNumber *windBearing;
@property (nonatomic, nullable, readonly) NSNumber *uvIndex;


@end

NS_ASSUME_NONNULL_END
