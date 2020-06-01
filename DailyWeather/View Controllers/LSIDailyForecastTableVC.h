//
//  LSIDailyForecastTableVC.h
//  DailyWeather
//
//  Created by David Wright on 5/31/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSIDailyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIDailyForecastTableVC : UITableViewController

@property (nonatomic) NSArray<LSIDailyForecast *> *dailyForecast;

@end

NS_ASSUME_NONNULL_END
