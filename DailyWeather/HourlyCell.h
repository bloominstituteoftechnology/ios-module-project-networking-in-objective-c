//
//  HourlyCell.h
//  DailyWeather
//
//  Created by Cora Jacobson on 11/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HourlyForecast.h"

NS_ASSUME_NONNULL_BEGIN

@interface HourlyCell : UICollectionViewCell

@property (nonatomic) IBOutlet UILabel *time;
@property (nonatomic) IBOutlet UILabel *temperature;
@property (nonatomic) IBOutlet UIImageView *icon;

@end

NS_ASSUME_NONNULL_END
