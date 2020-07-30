//
//  WeatherFetcher.m
//  DailyWeather
//
//  Created by Sean Acres on 7/30/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "WeatherFetcher.h"
#import "LSIWeatherResults.h"
#import "LSIErrors.h"

static NSString *const WeatherFetcherBaseURLString = @"https://api.darksky.net/forecast/18990986362b5b52af4a81dd7775c5af";

@implementation WeatherFetcher

- (void)fetchWeatherWithCompletionHandler:(WeatherFetcherCompletionHandler)completionHandler
{

}

- (void)fetchWeatherWithLatitude:(double)latitude
                       longitude:(double)longitude
               completionHandler:(WeatherFetcherCompletionHandler)completionHandler
{
    if (!completionHandler) return;
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:WeatherFetcherBaseURLString];

    NSString *latitudeLongitudeString = [NSString stringWithFormat:@"%f,%f", latitude, longitude];
    
    NSURL *url = [urlComponents.URL URLByAppendingPathComponent:latitudeLongitudeString];

    NSLog(@"Fetching weather: %@", url);
    
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
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!dictionary) {
            NSLog(@"Error decoding JSON: %@", jsonError);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });
            
            return;
        }
        
        LSIWeatherResults *results = [[LSIWeatherResults alloc] initWithDictionary:dictionary];
        
        if (!results) {
            NSError *apiError =errorWithMessage(@"Missing/Invalid JSON dict", LSIAPIError);
            NSLog(@"Error getting results: %@", apiError);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, apiError);
            });
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(results, nil);
        });
        
    }] resume];
}

@end
