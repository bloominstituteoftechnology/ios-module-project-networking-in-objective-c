//
//  FGTWeatherForecast.m
//  DailyWeather
//
//  Created by FGT MAC on 7/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "FGTWeatherForecast.h"
#import "LSIWeatherIcons.h"
#import "LSICardinalDirection.h"

@implementation FGTWeatherForecast

- (instancetype)init
{
    return [self initWithTime: NSDate.now
                      summary: @""
                         icon: [UIImage imageNamed:@""]
            precipProbability: 0
              precipIntensity: 0
                  temperature: 0
          apparentTemperature: 0
                     humidity: 0
                     pressure: 0
                    windSpeed: 0
                  windBearing: @""
                      uvIndex: 0];
}

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
                    uvIndex:(double)aUvIndex
{
    self = [super init];
    if(self){
        _time = aTime;
        _summary = aSummary;
        _icon = aIcon;
        _precipProbability = aPrecipProbability;
        _precipIntensity = aPrecipIntensity;
        _temperature = aTemperature;
        _apparentTemperature = aApparentTemperature;
        _humidity = aHumidity;
        _pressure = aPressure;
        _windSpeed = aWindSpeed;
        _windBearing = aWindBearing;
        _uvIndex = aUvIndex;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    //Using the Weather.json file
    NSDictionary *currently = [aDictionary objectForKey:@"currently"];
    if(![currently isKindOfClass:NSDictionary.class]) return nil;
    
    NSNumber *timeInMilliseconds = [currently objectForKey:@"time"];
    if(![timeInMilliseconds isKindOfClass:NSNumber.class])return  nil;
    //Convert to valite date type
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000];
    
    NSString *summary = [currently objectForKey:@"summary"];
    if(![summary isKindOfClass:NSString.class]) return nil;
    
    NSString *iconString = [currently objectForKey:@"icon"];
    if(![iconString isKindOfClass:NSString.class])return nil;
    UIImage *icon = [LSIWeatherIcons weatherImageForIconName:iconString];
    
    
    NSNumber *precipProbability =[currently objectForKey:@"precipProbability"];
    if(![precipProbability isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *precipIntensity =[currently objectForKey:@"precipIntensity"];
    if(![precipIntensity isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *temperature =[currently objectForKey:@"temperature"];
    if(![temperature isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *apparentTemperature =[currently objectForKey:@"apparentTemperature"];
    if(![apparentTemperature isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *humidity =[currently objectForKey:@"humidity"];
    if(![humidity isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *pressure =[currently objectForKey:@"pressure"];
    if(![pressure isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *windSpeed =[currently objectForKey:@"windSpeed"];
    if(![windSpeed isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *windBearingRaw =[currently objectForKey:@"windBearing"];
    if(![windBearingRaw isKindOfClass:NSNumber.class])return nil;
    //Convert using helper method
    NSString *windBearing = [LSICardinalDirection directionForHeading: windBearingRaw.doubleValue];
    
    NSNumber *uvIndex =[currently objectForKey:@"uvIndex"];
    if(![uvIndex isKindOfClass:NSNumber.class])return nil;
    
    return [self initWithTime: time
                      summary: summary
                         icon: icon
            precipProbability: precipProbability.doubleValue
              precipIntensity: precipIntensity.doubleValue
                  temperature: temperature.doubleValue
          apparentTemperature: apparentTemperature.doubleValue
                     humidity: humidity.doubleValue
                     pressure: pressure.doubleValue
                    windSpeed: windSpeed.doubleValue
                  windBearing: windBearing
                      uvIndex: uvIndex.doubleValue];
}

@end
