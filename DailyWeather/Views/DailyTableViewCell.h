//
//  DailyTableViewCell.h
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSIDailyForecast;
NS_ASSUME_NONNULL_BEGIN

@interface DailyTableViewCell : UITableViewCell

@property (nonatomic) LSIDailyForecast *forecast;

@end

NS_ASSUME_NONNULL_END
