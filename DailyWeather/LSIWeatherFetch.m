//
//  LSIWeatherFetch.m
//  DailyWeather
//
//  Created by Lydia Zhang on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherFetch.h"
#import "LSIErrors.h"
#import "LSIWeatherForcast.h"

static NSString *baseURL = @"https://api.darksky.net/forecast/18990986362b5b52af4a81dd7775c5af";

@implementation LSIWeatherFetch

- (instancetype)init {
    self = [super init];
    if (self) {}
    return self;
}

- (void)fetchWeatherByLocationLatitude:(double)latitude longitude:(double)longitude completion:(LSIWeatherFetcherCompletion)completion{
    
    NSString *latitudeString = [NSString stringWithFormat:@"%f",latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f",longitude];
    NSString *urlString = [NSString stringWithFormat:@"%@%@,%@", baseURL,latitudeString,longitudeString];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    
    NSURLSessionTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error){
        
        if (error) {
            completion(nil,error);
            return;
        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"No weather data in this location returned", LSIDataNilError);
            completion(nil,dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *weather = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completion(nil,jsonError);
            return;
        }
        
        LSIWeatherForcast *result =[ [LSIWeatherForcast alloc] initWithDictionary:weather];
        completion(result,nil);
    }];
    [dataTask resume];
}

@end
