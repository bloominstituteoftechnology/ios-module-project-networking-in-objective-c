//
//  WeatherFetcher.m
//  DailyWeather
//
//  Created by Cora Jacobson on 11/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "WeatherFetcher.h"
#import "LSIErrors.h"
#import "LSIWeatherForecast.h"

static NSString *const WeatherFetcherBaseURLString = @"https://api.darksky.net/forecast/e79d21acb01d287235077aabb7b07190/";

@implementation WeatherFetcher

+ (void)fetchWeatherWithLatitude:(double)latitude
                       longitude:(double)longitude
               CompletionHandler:(nonnull WeatherFetcherCompletionHandler)completionHandler
{
    if (!completionHandler) return;
    
    NSString *pathString = [NSString stringWithFormat:@"%.4f,%.4f", latitude, longitude];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", WeatherFetcherBaseURLString, pathString];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSLog(@"Fetching Weather: %@", url);

    [[NSURLSession.sharedSession dataTaskWithURL:url
                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error fetching weather: %@", error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            
            return;
        }
        
        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&jsonError];
        if (!dictionary || ![dictionary isKindOfClass:NSDictionary.class]) {
            NSLog(@"Error decoding JSON: %@", jsonError);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });
            
            return;
        }
        
        LSIWeatherForecast *results = [[LSIWeatherForecast alloc] initWithDictionary:dictionary];
        if (!results) {
            NSError *apiError = errorWithMessage(@"Invalid JSON Dictionary", LSIAPIError);
            NSLog(@"Error decoding results dictionary: %@", apiError);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, apiError);
            });
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(results, nil);
        });
    }] resume];
}

@end
