//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by Jorge Alvarez on 3/18/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject

@property (nonatomic, readonly) NSDate *time; // Required
@property (nonatomic, readonly, copy) NSString *summary; // Optional
@property (nonatomic, readonly, copy) NSString *icon; // Optional
@property (nonatomic, readonly) NSNumber *precipProbablity; // Optional
@property (nonatomic, readonly) NSNumber *precipIntensity; // Optional
@property (nonatomic, readonly) NSNumber *temperature; // Optional
@property (nonatomic, readonly) NSNumber *apparentTemperature; // Optional
@property (nonatomic, readonly) NSNumber *humidity; // Optional
@property (nonatomic, readonly) NSNumber *pressure; // Optional
@property (nonatomic, readonly) NSNumber *windSpeed; // Optional
@property (nonatomic, readonly) NSNumber *windBearing; // Optional
@property (nonatomic, readonly) NSNumber *uvIndex; // Optional

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(NSNumber *)precipProbability
             precipIntensity:(NSNumber *)precipIntensity
                 temperature:(NSNumber *)temperature
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
