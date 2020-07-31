//
//  WeatherNetwork.m
//  DailyWeather
//
//  Created by Matthew Martindale on 7/30/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "WeatherNetwork.h"
#import "LSIWeatherForcast.h"
#import "LSIWeatherIcons.h"
#import "LSIErrors.h"
#import "LSICurrentForecast.h"
#import "LSIHourlyForecast.h"
#import "LSIDailyForecast.h"

static NSString *const WeatherAPIBaseURLString = @"https://api.darksky.net/forecast/18990986362b5b52af4a81dd7775c5af/37.8267,-122.4233";

@implementation WeatherNetwork

- (void)fetchWeatherForecast:(WeatherFetchCompletionHandler)completionHandler
{
    if (!completionHandler) return;
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:WeatherAPIBaseURLString];
    
    NSURL *url = urlComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
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
        
        LSIWeatherForcast *weatherForecastResults = [[LSIWeatherForcast alloc] initWithDictionary:dictionary];
        if (!weatherForecastResults) {
            NSError *apiError = errorWithMessage(@"Invalid JSON dictionary", LSIAPIError);
            NSLog(@"Error decoding results dictionary: %@", apiError);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, apiError);
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(weatherForecastResults, nil);
        });
        
    }]resume];
}

@end
