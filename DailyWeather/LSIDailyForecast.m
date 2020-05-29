//
//  LSIDailyForecast.m
//  DailyWeather
//
//  Created by Sal B Amer on 5/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecast.h"

@implementation LSIDailyForecast

- (instancetype)initWithTime:(NSDate *)time
            summary:(NSString *)summary
               icon:(NSString *)icon
        sunriseTime:(NSDate *)sunriseTime
         sunsetTime:(NSDate *)sunsetTime
    precipIntensity:(NSNumber *)precipIntensity
  precipProbability:(NSNumber *)precipProbability
         precipType:(NSString *)precipType
    temperatureHigh:(NSNumber *)temperatureHigh
     temperatureLow:(NSNumber *)temperatureLow
apparentTemperature:(NSNumber *)apparentTemperature
           humidity:(NSNumber *)humidity
           pressure:(NSNumber *)pressure
          windSpeed:(NSNumber *)windSpeed
        windBearing:(NSNumber *)windBearing
            uvIndex:(NSNumber *)uvIndex
{
  if (self = [super init]) {
    _time = time;
    _summary = [summary copy];
    _icon = [icon copy];
    _sunriseTime = sunriseTime;
    _sunsetTime = sunsetTime;
    _precipIntensity = precipIntensity;
    _precipProbability = precipProbability;
    _precipType = [precipType copy];
    _temperatureHigh = temperatureHigh;
    _temperatureLow = temperatureLow;
    _apparentTemperature = apparentTemperature;
    _humidity = humidity;
    _pressure = pressure;
    _windSpeed = windSpeed;
    _windBearing = windBearing;
    _uvIndex = uvIndex;
  }
  return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  NSNumber *timeInSeconds = [dictionary objectForKey:@"time"];
  if ([timeInSeconds isKindOfClass:[NSNull class]]) {
      timeInSeconds = nil;
  } else if (![timeInSeconds isKindOfClass:[NSNumber class]]) return nil;
  NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInSeconds.longValue];
  
  NSString *summary = [dictionary objectForKey:@"summary"];
  if ([summary isKindOfClass:[NSNull class]]) {
      summary = nil;
  } else if (![summary isKindOfClass:[NSString class]]) return nil;
  
  NSString *icon = [dictionary objectForKey:@"icon"];
  if ([icon isKindOfClass:[NSNull class]]) {
      icon = nil;
  } else if (![icon isKindOfClass:[NSString class]]) return nil;
  
  timeInSeconds = [dictionary objectForKey:@"sunriseTime"];
  if ([timeInSeconds isKindOfClass:[NSNull class]]) {
      timeInSeconds = nil;
  } else if (![timeInSeconds isKindOfClass:[NSNumber class]]) return nil;
  NSDate *sunriseTime = [NSDate dateWithTimeIntervalSince1970:timeInSeconds.longValue];
  
  timeInSeconds = [dictionary objectForKey:@"sunsetTime"];
  if ([timeInSeconds isKindOfClass:[NSNull class]]) {
      timeInSeconds = nil;
  } else if (![timeInSeconds isKindOfClass:[NSNumber class]]) return nil;
  NSDate *sunsetTime = [NSDate dateWithTimeIntervalSince1970:timeInSeconds.longValue];
  
  NSNumber *precipProbability = [dictionary objectForKey:@"precipProbability"];
  if ([precipProbability isKindOfClass:[NSNull class]]) {
      precipProbability = nil;
  } else if (![precipProbability isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *precipIntensity = [dictionary objectForKey:@"precipIntensity"];
  if ([precipIntensity isKindOfClass:[NSNull class]]) {
      precipIntensity = nil;
  } else if (![precipIntensity isKindOfClass:[NSNumber class]]) return nil;

  
  NSString *precipType = [dictionary objectForKey:@"precipType"];
  if ([precipType isKindOfClass:[NSNull class]]) {
      precipType = nil;
  } else if (![precipType isKindOfClass:[NSString class]]) return nil;
  
  NSNumber *temperatureLow = [dictionary objectForKey:@"temperatureLow"];
  if ([temperatureLow isKindOfClass:[NSNull class]]) {
      temperatureLow = nil;
  } else if (![temperatureLow isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *temperatureHigh = [dictionary objectForKey:@"temperatureHigh"];
  if ([temperatureHigh isKindOfClass:[NSNull class]]) {
      temperatureHigh = nil;
  } else if (![temperatureHigh isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *apparentTemperature = [dictionary objectForKey:@"apparentTemperatureHigh"];
  if ([apparentTemperature isKindOfClass:[NSNull class]]) {
      apparentTemperature = nil;
  } else if (![apparentTemperature isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *humidity = [dictionary objectForKey:@"humidity"];
  if ([humidity isKindOfClass:[NSNull class]]) {
      humidity = nil;
  } else if (![humidity isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *pressure = [dictionary objectForKey:@"pressure"];
  if ([pressure isKindOfClass:[NSNull class]]) {
      pressure = nil;
  } else if (![pressure isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *windSpeed = [dictionary objectForKey:@"windSpeed"];
  if ([windSpeed isKindOfClass:[NSNull class]]) {
      windSpeed = nil;
  } else if (![windSpeed isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *windBearing = [dictionary objectForKey:@"windBearing"];
  if ([windBearing isKindOfClass:[NSNull class]]) {
      windBearing = nil;
  } else if (![windBearing isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *uvIndex = [dictionary objectForKey:@"uvIndex"];
  if ([uvIndex isKindOfClass:[NSNull class]]) {
      uvIndex = nil;
  } else if (![uvIndex isKindOfClass:[NSNumber class]]) return nil;
  
  return [self initWithTime:time
                    summary:summary
                       icon:icon
                sunriseTime:sunriseTime
                 sunsetTime:sunsetTime
            precipIntensity:precipIntensity
          precipProbability:precipProbability
                 precipType:precipType
            temperatureHigh:temperatureHigh
             temperatureLow:temperatureLow
        apparentTemperature:apparentTemperature
                   humidity:humidity
                   pressure:pressure
                  windSpeed:windSpeed
                windBearing:windBearing
                    uvIndex:uvIndex];
}

@end
