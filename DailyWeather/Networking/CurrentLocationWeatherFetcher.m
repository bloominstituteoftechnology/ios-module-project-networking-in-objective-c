//
//  CurrentLocationWeatherFetcher.m
//  DailyWeather
//
//  Created by Nick Nguyen on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CurrentLocationWeatherFetcher.h"
#import "LSILog.h"
#import "LSIErrors.h"
#import "CurrentUserLocationWeather.h"
#import "LSIDailyForecast.h"

static NSString *baseURLString = @"https://api.darksky.net/forecast/18990986362b5b52af4a81dd7775c5af";

@implementation CurrentLocationWeatherFetcher

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)fetchCurrentWeatherUsingLatitude:(double)latitude longtitude:(double)longitude completionBlock:(LSICurrentLocationFetcherCompletionBlock)completionBlock
{
    
    NSString *latitudeString = [NSString stringWithFormat:@"%f",latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f",longitude];
    NSString *stringURL =  [NSString stringWithFormat:@"%@/%@,%@",baseURLString,latitudeString,longitudeString];
    
    NSURL *url = [[NSURL alloc]initWithString:stringURL];
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"url: %@",url);
        
        if (error) {
            completionBlock(nil,error);
            return;
        }
        if (!data) {
            NSError *dataError = errorWithMessage(@"No data in URL response for current location weather", LSIDataNilError);
            completionBlock(nil,dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completionBlock(nil,jsonError);
            return;
        }
        CurrentUserLocationWeather *result = [[CurrentUserLocationWeather alloc] initWithDictionary:json];
        completionBlock(result,nil);
    } ];
    [task resume];
}

@end

