//
//  DailyWeatherTableViewCell.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSIDailyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface DailyWeatherTableViewCell : UITableViewCell
@property (nonatomic) LSIDailyForecast *forecast;

@end

NS_ASSUME_NONNULL_END
