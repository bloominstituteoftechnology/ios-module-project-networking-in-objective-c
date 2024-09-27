//
//  HourlyWeather.h
//  DailyWeather
//
//  Created by Nick Nguyen on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HourlyWeather : NSObject


@property (nonatomic, readonly) NSString *icon;
@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly) double temperature;


- (instancetype)initWithIcon:(NSString *)icon time:(NSDate*)time temperature:(double)temperature;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary index:(int )index;
@end

NS_ASSUME_NONNULL_END
