//
//  CBDDailyForcastViewController.m
//  DailyWeather
//
//  Created by Christopher Devito on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDDailyForcastViewController.h"

@interface CBDDailyForcastViewController ()

// MARK: - Private properties

// MARK: - IBOutlets
@property (weak, nonatomic) IBOutlet UIImageView *currentIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *cityStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTemperatureLabel;
@property (strong, nonatomic) IBOutlet UITableView *dailyTableView;


@end

@implementation CBDDailyForcastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
