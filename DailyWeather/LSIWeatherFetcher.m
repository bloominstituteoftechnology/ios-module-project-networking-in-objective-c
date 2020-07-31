//
//  LSIWeatherFetcher.m
//  DailyWeather
//
//  Created by Kelson Hartle on 7/18/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherFetcher.h"
#import "LSIErrors.h"
#import "LSIWeatherForecast.h"

static NSString *baseURLString = @"https://api.darksky.net/forecast/";

@implementation LSIWeatherFetcher

// https://api.darksky.net/forecast/0123456789abcdef9876543210fedcba/42.3601,-71.0589

-(void)fetchWeatherByLocation:(double)latitude longitude:(double)longitude completion:(WeatherFetcherCompletionHandler)completion;{
    
    NSLog(@"Fetching");
    
    NSString *latitudeString = [NSString stringWithFormat:@"%f", latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f", longitude];
    NSString *urlString = [NSString stringWithFormat:@"%@%@, %@",baseURLString,latitudeString,longitudeString];
    NSURL *finalUrl = [[NSURL alloc] initWithString:urlString];
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"URL: %@", finalUrl);
        
        if (error) {
            completion(nil, error);
        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"No weather data returned", LSIDataNilError);
            completion(nil,dataError);
            return;
        }
        
        NSError *jsonError = nil;
        // & = address of error
        
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        LSIWeatherForecast *forecastResult = [[LSIWeatherForecast alloc] initWithDictionary:weatherDictionary];
        completion(forecastResult, nil);
        
            }];
    
    [task resume];
};





@end
