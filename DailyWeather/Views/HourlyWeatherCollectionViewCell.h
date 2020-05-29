//
//  HourlyWeatherCollectionViewCell.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LSIHourlyForecast;
@interface HourlyWeatherCollectionViewCell : UICollectionViewCell

@property (nonatomic) LSIHourlyForecast *forecast;
@property (nonatomic) BOOL isNow;

@end

NS_ASSUME_NONNULL_END
