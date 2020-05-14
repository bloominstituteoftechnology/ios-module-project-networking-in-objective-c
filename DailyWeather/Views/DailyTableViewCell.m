//
//  DailyTableViewCell.m
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "DailyTableViewCell.h"

// Aha... so the () is what seems to tell the compiler, hey this is extra/private... interesting.
@interface DailyTableViewCell ()
// MARK:- Outlets
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempHighLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempLowLabel;

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

@end
