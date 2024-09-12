//
//  LSIWeatherFetcher.m
//  DailyWeather
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherFetcher.h"
#import "LSIErrors.h"
#import "LSIWeatherForcast.h"

//https://api.darksky.net/forecast/[key]/[latitude],[longitude]
//GET https://api.darksky.net/forecast/0123456789abcdef9876543210fedcba/42.3601,-71.0589

static NSString *baseURL = @"https://api.darksky.net/forecast/18990986362b5b52af4a81dd7775c5af";

@implementation LSIWeatherFetcher

- (instancetype)init {
  self = [super init];
  if (self) {}
  return self;
}

- (void)fetchWeatherByLocation:(double)latitide
                    longtitude:(double)longtitude
                    completion:(WeatherFetcherCompletionHandler)completion
{
  //BUILD URL
  NSString *latitudeString = [NSString stringWithFormat:@"%f", latitide];
  NSString *longtitudeString = [NSString stringWithFormat:@"%f", longtitude];
  NSString *urlString = [NSString stringWithFormat:@"%@%@, %@", baseURL,latitudeString,longtitudeString];
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  
  NSURLSessionTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (error) {
      completion(nil, error);
      return;
    }
    if (!data) {
      NSError *dataError = errorWithMessage(@"No Data was returned from this location", LSIDataNilError);
      completion(nil, dataError);
      return;
    }
    NSError *jsonError = nil;
    NSDictionary *weather = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
      completion(nil, jsonError);
      return;
    }
    
    LSIWeatherForcast *result = [[LSIWeatherForcast alloc] initWithDictionary:weather];
    completion(result,nil);
  }];
  [dataTask resume];
}

@end
