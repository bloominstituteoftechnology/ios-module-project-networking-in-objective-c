//
//  DSOWeatherController.m
//  DailyWeather
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "DSOWeatherController.h"
#import "LSIErrors.h"
#import "LSILog.h"
#import "LSIWeatherForcast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

//https://api.darksky.net/forecast/[key]/[latitude],[longitude]
//GET https://api.darksky.net/forecast/0123456789abcdef9876543210fedcba/42.3601,-71.0589

static NSString *baseURLString = @"https://api.darksky.net/forecast/18990986362b5b52af4a81dd7775c5af";

@implementation DSOWeatherController

- (instancetype) init {
  if (self) {
    _currentForecast = [[LSIWeatherForcast alloc] init];
    _hourlyForecast = [[NSMutableArray<LSIHourlyForecast *> alloc] init];
    _dailyForecast = [[NSMutableArray<LSIDailyForecast *> alloc] init];
  }
  return self;
}
- (void)fetchWeatherByLocation:(double)latitude
                     longitude:(double)longitude
                completionBloc:(void (^)(NSError * _Nullable error))completionBlock
{
//  NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString];
//  NSString *locationCoordinates = [NSString stringWithFormat:@"%f,%f", latitude, longitude];
//  NSURL *requestURL = [baseURL URLByAppendingPathComponent:locationCoordinates];
//
//  //Test URL
//  NSLog(@"%@", requestURL.absoluteString);
  
  //BUILD URL
   NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString];
  NSString *locationCoordinates = [NSString stringWithFormat:@"%f,%f", latitude, longitude];
  NSURL *requestURL = [baseURL URLByAppendingPathComponent:locationCoordinates];
//   NSString *latitudeString = [NSString stringWithFormat:@"%f", latitude];
//   NSString *longtitudeString = [NSString stringWithFormat:@"%f", longitude];
//   NSString *urlString = [NSString stringWithFormat:@"%@%@, %@", baseURLString,latitudeString,longtitudeString];
//   NSURL *url = [[NSURL alloc] initWithString:urlString];
   
   NSURLSessionTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      NSLog(@"Inside of datatask commpletionHandler with url: %@", requestURL);
     if (error) {
       completionBlock(error);
       return;
     }
     if (!data) {
       NSError *dataError = errorWithMessage(@"No Data was returned from this location", LSIDataNilError);
       completionBlock(dataError);
       return;
     }
 /////
     
//     NSError *jsonError = nil;
//     NSDictionary *weather = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//     if (jsonError) {
//       completion(nil, jsonError);
//       return;
//     }
//
//     LSIWeatherForcast *result = [[LSIWeatherForcast alloc] initWithDictionary:weather];
//     completion(result,nil);
//   }];
//   [dataTask resume];
     
         [self parseJSONData:data completionBloc:^(NSError * _Nullable error){
             completionBlock(error);
             return;
         }];
     }];

     [dataTask resume];
}

- (void)parseJSONData:(NSData *)data
       completionBloc:(void (^)(NSError * _Nullable error))completionBlock {

    NSError *jsonError = nil;

    // Create dictionary from data
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

    if (jsonError) {
        completionBlock(jsonError);
        return;
    }

    // current weather:
    NSDictionary *currentForecastDic = json[@"currently"];
  _currentForecast = [[LSIWeatherForcast alloc] initWithDictionary:currentForecastDic];
  NSLog(@"Current weather summary %@", self.currentForecast.apparentTemperature);

    // daily weather
    NSDictionary *dailyContainer = json[@"daily"];
    NSArray *dailyArray = dailyContainer[@"data"];
    //Clear the array
    [self.dailyForecast removeAllObjects];
    for (NSDictionary *day in dailyArray) {
        LSIDailyForecast *newDay = [[LSIDailyForecast alloc] initWithDictionary:day];
        [self.dailyForecast addObject:newDay];
    }
    NSLog(@"Days Count: %d first day: %@", self.dailyForecast.count, self.dailyForecast[0].summary);

    //  hourly
    NSDictionary *hourlyContainer = json[@"hourly"];
    NSArray *hourlyArray = hourlyContainer[@"data"];
    // Clear the array
    [self.hourlyForecast removeAllObjects];
    for (NSDictionary *hour in hourlyArray) {
        LSIHourlyForecast *newHour = [[LSIHourlyForecast alloc] initWithDictionary:hour];
        [self.hourlyForecast addObject:newHour];
    }
    NSLog(@"Hours Count: %d first hour: %@", self.hourlyForecast.count, self.hourlyForecast[0].summary);

    completionBlock(nil);
}

@end
