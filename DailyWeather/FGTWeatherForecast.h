//
//  FGTWeatherForecast.h
//  DailyWeather
//
//  Created by FGT MAC on 7/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FGTWeatherForecast : NSObject

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly) NSString *summary;
@property (nonatomic, readonly) NSString *icon;
@property (nonatomic, readonly) NSNumber *precipProbability;
@property (nonatomic, readonly) NSNumber *precipIntensity;
@property (nonatomic, readonly) NSNumber *temperature;
@property (nonatomic, readonly) NSNumber *apparentTemperature;
@property (nonatomic, readonly) NSNumber *humidity;
@property (nonatomic, readonly) NSNumber *pressure;
@property (nonatomic, readonly) NSNumber *windSpeed;
@property (nonatomic, readonly) NSNumber *windBearing;
@property (nonatomic, readonly) NSNumber *uvIndex;

-(instancetype)initWithTime:(NSDate *)aTime
                    summary:(NSString *)aSummary
                       icon:(NSString *)aIcon
          precipProbability:(NSNumber *)aPrecipProbability
            precipIntensity:(NSNumber *)aPrecipIntensity
                temperature:(NSNumber *)aTemperature
        apparentTemperature:(NSNumber *)aApparentTemperature
                   humidity:(NSNumber *)aHumidity
                   pressure:(NSNumber *)aPressure
                  windSpeed:(NSNumber *)aWindSpeed
                windBearing:(NSNumber *)aWindBearing
                    uvIndex:(NSNumber *)aUvIndex NS_DESIGNATED_INITIALIZER;



- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end

NS_ASSUME_NONNULL_END
