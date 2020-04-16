//
//  LSICurrentForecast.h
//  DailyWeather
//
//  Created by Chris Gonzales on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSICurrentForecast : NSObject

@property NSDate *time;
@property NSString *summary;
@property NSString *icon;
@property double temperature;
@property double windSpeed;
@property double windBearing;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
