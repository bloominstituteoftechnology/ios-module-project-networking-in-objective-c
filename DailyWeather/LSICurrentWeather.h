//
//  LSICurrentWeather.h
//  DailyWeather
//
//  Created by Bhawnish Kumar on 6/11/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSICurrentWeather : NSObject

@property (nonatomic, readonly) NSDate *time; // unix time, required.
@property (nonatomic, readonly, nullable, copy) NSString *summary;
@property (nonatomic, readonly, nullable, copy) NSString *icon;
@property (nonatomic, readonly, nullable) NSNumber *precipProbability;
@property (nonatomic, readonly, nullable) NSNumber *precipIntensity;
@property (nonatomic, readonly) double temperature; // required
@property (nonatomic, readonly) double apparentTemperature; // required, Feels like
@property (nonatomic, readonly, nullable) NSNumber *humidity;
@property (nonatomic, readonly, nullable) NSNumber *pressure;
@property (nonatomic, readonly, nullable) NSNumber *windSpeed;
@property (nonatomic, readonly, nullable) NSNumber *windBearing;
@property (nonatomic, readonly, nullable) NSNumber *uvIndex;

- (instancetype)initWithTime:(NSDate *)time summary:(NSString *)summary icon:(NSString *)icon precipProbability:(NSNumber *)precipProbability precipIntensity:(NSNumber *)precipIntensity temperature:(double)temperature apparentTemperature:(double)apparentTemperature humidity:(NSNumber *)humidity pressure:(NSNumber *)pressure windSpeed:(NSNumber *)windSpeed windBearing:(NSNumber *)windBearing uvIndex:(NSNumber *)uvIndex;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
