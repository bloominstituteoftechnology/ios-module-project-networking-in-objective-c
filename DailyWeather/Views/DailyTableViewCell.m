//
//  DailyTableViewCell.m
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "DailyTableViewCell.h"
#import "LSIDailyForecast.h"
#import "LSIWeatherIcons.h"


// Aha... so the () is what seems to tell the compiler, hey this is extra/private... interesting.
@interface DailyTableViewCell ()
// MARK:- Outlets
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempHighLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempLowLabel;

// MARK:-  Properties
@end

@implementation DailyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// MARK:- Override setter
- (void)setForecast:(LSIDailyForecast *)forecast {
    // Setter
    _forecast = forecast;

    // didSet
    [self updateViews];
}

- (void)updateViews {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(int)self.forecast.time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];

    self.dayLabel.text = [dateFormatter stringFromDate:date];
    self.iconLabel.image = [LSIWeatherIcons weatherImageForIconName:self.forecast.icon];
    self.tempHighLabel.text = self.forecast.temperatureHigh.stringValue;
    self.tempLowLabel.text = self.forecast.temperatureLow.stringValue;
}
@end
