//
//  DailyCell.h
//  DailyWeather
//
//  Created by Cora Jacobson on 11/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyForecast.h"

NS_ASSUME_NONNULL_BEGIN

@interface DailyCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *day;
@property (nonatomic) IBOutlet UILabel *high;
@property (nonatomic) IBOutlet UILabel *low;
@property (nonatomic) IBOutlet UIImageView *icon;

@end

NS_ASSUME_NONNULL_END
