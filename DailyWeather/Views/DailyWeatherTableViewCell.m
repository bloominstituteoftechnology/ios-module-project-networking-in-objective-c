//
//  DailyWeatherTableViewCell.m
//  DailyWeather
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "DailyWeatherTableViewCell.h"
#import "LSIDailyForecast.h"
#import "LSIWeatherIcons.h"

@interface DailyWeatherTableViewCell ()

//OUTLETS
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *dayTempHighLbl;
@property (weak, nonatomic) IBOutlet UILabel *dayTempLowLbl;


@end

@implementation DailyWeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setForecast:(LSIDailyForecast *)forecast  {
  _forecast = forecast;
  
  [self updateViews];
}


- (void)updateViews {
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(int)self.forecast.time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];

    self.dayLabel.text = [dateFormatter stringFromDate:self.forecast.time];
    self.weatherIcon.image = [LSIWeatherIcons weatherImageForIconName:self.forecast.icon];
    self.dayTempHighLbl.text = self.forecast.temperatureHigh.stringValue;
    self.dayTempLowLbl.text = self.forecast.temperatureLow.stringValue;
}

@end
