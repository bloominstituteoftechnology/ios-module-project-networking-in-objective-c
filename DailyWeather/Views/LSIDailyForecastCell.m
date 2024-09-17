//
//  LSIDailyForecastCell.m
//  DailyWeather
//
//  Created by David Wright on 5/31/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecastCell.h"
#import "LSIDailyForecast.h"
#import "LSIWeatherIcons.h"

@interface LSIDailyForecastCell ()

// IBOutlets
@property (nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic) IBOutlet UILabel *dayOfWeekLabel;
@property (nonatomic) IBOutlet UILabel *temperatureHighLabel;
@property (nonatomic) IBOutlet UILabel *temperatureLowLabel;

@end

@implementation LSIDailyForecastCell

// Custom getter/setter for dayForecast
@synthesize dayForecast = _dayForecast;

- (LSIDailyForecast *)dayForecast
{
    return _dayForecast;
}

- (void)setDayForecast:(LSIDailyForecast * _Nonnull)dayForecast
{
    _dayForecast = dayForecast;
    [self updateViews];
}


// Private methods
- (void)updateViews
{
    NSDateFormatter* dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat: @"EEEE"];
    NSLog(@"the day is: %@", [dayFormatter stringFromDate:[NSDate date]]);
    
    NSDate *date = self.dayForecast.time;
    NSString *dayOfWeek = [dayFormatter stringFromDate:date];
    self.temperatureHighLabel.text = dayOfWeek;
    
    NSString *iconName = self.dayForecast.icon;
    UIImage *icon = [LSIWeatherIcons weatherImageForIconName:iconName];
    self.iconImageView.image = icon;
    
    NSString *temperatureHigh = [NSString stringWithFormat:@"%.0f°F", self.dayForecast.temperatureHigh];
    self.temperatureHighLabel.text = temperatureHigh;
    
    NSString *temperatureLow = [NSString stringWithFormat:@"%.0f°F", self.dayForecast.temperatureLow];
    self.temperatureLowLabel.text = temperatureLow;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
