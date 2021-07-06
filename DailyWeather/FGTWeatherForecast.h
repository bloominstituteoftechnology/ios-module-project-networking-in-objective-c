//
//  FGTWeatherForecast.h
//  DailyWeather
//
//  Created by FGT MAC on 7/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FGTWeatherForecast : NSObject

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly) NSString *summary;
@property (nonatomic, readonly) UIImage *icon;
@property (nonatomic, readonly) double precipProbability;
@property (nonatomic, readonly) double precipIntensity;
@property (nonatomic, readonly) double temperature;
@property (nonatomic, readonly) double apparentTemperature;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly) NSString *windBearing;
@property (nonatomic, readonly) double uvIndex;

-(instancetype)initWithTime:(NSDate *)aTime
                    summary:(NSString *)aSummary
                       icon:(UIImage *)aIcon
          precipProbability:(double)aPrecipProbability
            precipIntensity:(double)aPrecipIntensity
                temperature:(double)aTemperature
        apparentTemperature:(double)aApparentTemperature
                   humidity:(double)aHumidity
                   pressure:(double)aPressure
                  windSpeed:(double)aWindSpeed
                windBearing:(NSString *)aWindBearing
                    uvIndex:(double)aUvIndex NS_DESIGNATED_INITIALIZER;



- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end

NS_ASSUME_NONNULL_END
