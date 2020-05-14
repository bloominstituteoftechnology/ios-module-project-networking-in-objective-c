//
//  CBDDailyForecastTableViewCell.m
//  DailyWeather
//
//  Created by Christopher Devito on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDDailyForecastTableViewCell.h"
@interface CBDDailyForecastTableViewCell () {
    
}

// MARK: - IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *dayOfWeekLabel;
@property (strong, nonatomic) IBOutlet UIImageView *dailyIconImageView;
@property (strong, nonatomic) IBOutlet UILabel *highTemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *lowTemperatureLabel;

@end
@implementation CBDDailyForecastTableViewCell

// MARK: - Properties

// MARK: - IBOutlets


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
