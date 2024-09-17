//
//  LSIDailyForecastCell.h
//  DailyWeather
//
//  Created by David Wright on 5/31/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LSIDailyForecast;

@interface LSIDailyForecastCell : UITableViewCell

@property (nonatomic) LSIDailyForecast *dayForecast;

@end

NS_ASSUME_NONNULL_END
