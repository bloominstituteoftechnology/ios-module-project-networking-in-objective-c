//
//  WeatherVC.m
//  DailyWeather
//
//  Created by Cora Jacobson on 11/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "WeatherVC.h"
#import "LSIWeatherForecast.h"
#import "LSIWeatherIcons.h"
#import "LSIErrors.h"
#import "LSILog.h"
#import "LSICardinalDirection.h"
#import "WeatherFetcher.h"
#import "DailyCell.h"
#import "HourlyCell.h"

@interface WeatherVC () {
    BOOL _requestedLocation;
}

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;

@property (nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic) IBOutlet UILabel *summary;
@property (nonatomic) IBOutlet UILabel *temperature;
@property (nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic) IBOutlet UILabel *day;
@property (nonatomic) IBOutlet UILabel *high;
@property (nonatomic) IBOutlet UILabel *low;

@property (nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) LSIWeatherForecast *forecast;
@property (nonatomic) NSDateFormatter *formatter;

@end

@interface WeatherVC (CLLocationManagerDelegate) <CLLocationManagerDelegate>

@end

@implementation WeatherVC

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    self.tableView.dataSource = self;
    self.collectionView.dataSource = self;
    [self updateViews];
}

- (void)requestCurrentPlacemarkForLocation:(CLLocation *)location
                            withCompletion:(void (^)(CLPlacemark *, NSError *))completionHandler {
    if (location) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error) {
                completionHandler(nil, error);
                return;
            }
            
            if (placemarks.count >= 1) {
                CLPlacemark *place = placemarks.firstObject;
                
                completionHandler(place, nil);
                return;
                
            } else {
                NSError *placeError = errorWithMessage(@"No places match current location", LSIPlaceError);
                
                completionHandler(nil, placeError);
                return;
            }
        }];
        
    } else {
        NSLog(@"ERROR: Missing location, please provide location");
    }
}

- (void)requestUserFriendlyLocation:(CLLocation *)location {
    if(!_requestedLocation) {
        _requestedLocation = YES;
        __block BOOL requestedLocation = _requestedLocation;
        
        [self requestCurrentPlacemarkForLocation:location withCompletion:^(CLPlacemark *place, NSError *error) {
            
            NSLog(@"Location: %@, %@", place.locality, place.administrativeArea);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.location = location;
                self.placemark = place;
                [self updateViews];
            });
            requestedLocation = NO;
        }];
    }
}

- (void)requestWeatherForLocation:(CLLocation *)location {
    [WeatherFetcher fetchWeatherWithLatitude:location.coordinate.latitude
                                   longitude:location.coordinate.longitude
                           CompletionHandler:^(LSIWeatherForecast *weather, NSError *error) {
        self.forecast = weather;
        [self updateViews];
    }];
}

- (void)updateViews {
    if (self.placemark) {
        _locationLabel.text = _placemark.locality;
    }
    if (_forecast) {
        _summary.text = _forecast.currentWeather.summary;
        _temperature.text = [NSString stringWithFormat:@"%.0f°F", _forecast.currentWeather.temperature];
        _icon.image = [UIImage imageNamed:_forecast.currentWeather.icon];
        
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setLocalizedDateFormatFromTemplate:@"EEEE"];
        _day.text = [_formatter stringFromDate:_forecast.currentWeather.time];
        double highTemp = [_forecast.dailyWeather objectAtIndex:0].temperatureHigh;
        _high.text = [NSString stringWithFormat:@"%.0f", highTemp];
        double lowTemp = [_forecast.dailyWeather objectAtIndex:0].temperatureLow;
        _low.text = [NSString stringWithFormat:@"%.0f", lowTemp];
        [self.tableView reloadData];
        [self.collectionView reloadData];
    }
}

// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.forecast.dailyWeather.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DailyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DailyCell" forIndexPath:indexPath];
    [_formatter setLocalizedDateFormatFromTemplate:@"EEEE"];
    cell.day.text = [_formatter stringFromDate:[_forecast.dailyWeather objectAtIndex:indexPath.row].time];
    cell.high.text = [NSString stringWithFormat:@"%.0f", [_forecast.dailyWeather objectAtIndex:indexPath.row].temperatureHigh];
    cell.low.text = [NSString stringWithFormat:@"%.0f", [_forecast.dailyWeather objectAtIndex:indexPath.row].temperatureLow];
    cell.icon.image = [UIImage imageNamed:[_forecast.dailyWeather objectAtIndex:indexPath.row].icon];
    return cell;
}

// MARK: - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _forecast.hourlyWeather.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HourlyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HourlyCell" forIndexPath:indexPath];
    [_formatter setLocalizedDateFormatFromTemplate:@"h a"];
    cell.time.text = [_formatter stringFromDate:[_forecast.hourlyWeather objectAtIndex:indexPath.row].time];
    cell.temperature.text = [NSString stringWithFormat:@"%.0f°", [_forecast.hourlyWeather objectAtIndex:indexPath.row].temperature];
    cell.icon.image = [UIImage imageNamed:[_forecast.hourlyWeather objectAtIndex:indexPath.row].icon];
    return cell;
}

@end

/// MARK: CLLocationManagerDelegate Methods

@implementation WeatherVC (CLLocationManagerDelegate)

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locationManager Error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"locationManager: found location %@", locations.firstObject);
    
    CLLocation *location = locations.firstObject;
        
    [self requestWeatherForLocation: location];
        
    [self requestUserFriendlyLocation: location];

    [manager stopUpdatingLocation];
}

@end
