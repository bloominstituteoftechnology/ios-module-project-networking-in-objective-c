//
//  LSIWeatherViewController.m
//
//  Created by Paul Solt on 2/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "LSIWeatherViewController.h"
#import "LSIWeatherIcons.h"
#import "LSIErrors.h"
#import "LSILog.h"
#import "LSIWeatherForecast.h"
#import "LSIFileHelper.h"
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UILabel *cityStateLabel;
@property (strong, nonatomic) UILabel *summaryLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *temperatureLabel;
@property (strong, nonatomic) UILabel *windLabel;
@property (strong, nonatomic) UILabel *feelsLikeLabel;
@property (strong, nonatomic) UILabel *windDetailLabel;
@property (strong, nonatomic) UILabel *feelsLikeDetailLabel;
@property (strong, nonatomic) UILabel *humidityLabel;
@property (strong, nonatomic) UILabel *pressureLabel;
@property (strong, nonatomic) UILabel *humidityDetailLabel;
@property (strong, nonatomic) UILabel *pressureDetailLabel;
@property (strong, nonatomic) UILabel *chanceOfRainLabel;
@property (strong, nonatomic) UILabel *uvIndexLabel;
@property (strong, nonatomic) UILabel *chanceOfRainDetailLabel;
@property (strong, nonatomic) UILabel *uvIndexDetailLabel;
@property (strong, nonatomic) UIButton *settingsButton;
@property (nonatomic) LSIWeatherForecast *weatherForecast;
@property (nonatomic) LSICurrentForecast *currentForecast;
@property (nonatomic) LSIDailyForecast *dailyForecast;
@property (nonatomic) LSIHourlyForecast *hourlyForcast;


@end

// NOTE: You must declare the Category before the main implementation,
// otherwise you'll see errors about the type not being correct if you
// try to move delegate methods out of the main implementation body
@interface LSIWeatherViewController (CLLocationManagerDelegate) <CLLocationManagerDelegate>

@end


@implementation LSIWeatherViewController



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
    
    [self initViews];
    [self subviewConstraints];
    [self forcastWeather];
    [self updateViews];
    
    // TODO: Transparent toolbar with info button (Settings)
    
    
    // TODO: Handle settings button pressed
    
     [_settingsButton addTarget:self action:@selector(settingsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

//https://developer.apple.com/documentation/corelocation/converting_between_coordinates_and_user-friendly_place_names
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
    
    // TODO: 1. Parse CurrentWeather.json from App Bundle and update UI
    
    NSURL *currentWeatherURL = [[NSBundle mainBundle] URLForResource:@"Weather" withExtension:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:currentWeatherURL];
    
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    self.currentForecast = [[LSICurrentForecast alloc] initWithDictionary:json];
    if (error) {
        NSLog(@"JSON Parsing Error: %@", error);
    }
    
    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
}

- (void)settingsButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"SettingsSegue" sender:self];
}

- (void)forcastWeather {
    
    NSURL *currentWeatherURL = [[NSBundle mainBundle] URLForResource:@"Hourly" withExtension:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:currentWeatherURL];

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    _hourlyForcast = [[LSIHourlyForecast alloc] initWithDictionary:json];
    if (error) {
        NSLog(@"JSON Parsing Error: %@", error);
    }
    
}

- (void)initViews {
    
    // MARK: - Init Top View and Top View Subviews
    
    _topView = [[UIView alloc] init];
    [self.view addSubview:_topView];
    _topView.backgroundColor = [UIColor systemBlueColor];
    _topView.translatesAutoresizingMaskIntoConstraints = NO;
    _cityStateLabel = [[UILabel alloc] init];
    [_topView addSubview:_cityStateLabel];
    _summaryLabel = [[UILabel alloc] init];
    [_topView addSubview:_summaryLabel];
    _iconImageView = [[UIImageView alloc] init];
    [_topView addSubview:_iconImageView];
    _temperatureLabel = [[UILabel alloc] init];
    [_topView addSubview:_temperatureLabel];
    
    // MARK: - Init Bottom View and Bottom View Subviews
    
    _bottomView = [[UIView alloc] init];
    [self.view addSubview:_bottomView];
    _bottomView.backgroundColor = [UIColor colorWithRed:0 green:0.3421058357 blue:0.7128220201 alpha:1];
    _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    _windLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_windLabel];
    _feelsLikeLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_feelsLikeLabel];
    _windDetailLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_windDetailLabel];
    _feelsLikeDetailLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_feelsLikeDetailLabel];
    _humidityLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_humidityLabel];
    _pressureLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_pressureLabel];
    _humidityDetailLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_humidityDetailLabel];
    _pressureDetailLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_pressureDetailLabel];
    _chanceOfRainLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_chanceOfRainLabel];
    _uvIndexLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_uvIndexLabel];
    _chanceOfRainDetailLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_chanceOfRainDetailLabel];
    _uvIndexDetailLabel = [[UILabel alloc] init];
    [_bottomView addSubview:_uvIndexDetailLabel];
    _settingsButton = [[UIButton alloc] init];
    [_bottomView addSubview:_settingsButton];
}

- (void)subviewConstraints {
    
    // MARK: - Top View Subviews Translate Autoresizing Mask Into Constraints
    
    _cityStateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _summaryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _temperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // MARK: - Top View Constraints
    
    [_topView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_topView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_topView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_topView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.4 constant:0].active = YES;
    
    [_iconImageView.bottomAnchor constraintEqualToAnchor:_cityStateLabel.topAnchor constant:0].active = YES;
    [_iconImageView.heightAnchor constraintEqualToConstant:64].active = YES;
    [_iconImageView.widthAnchor constraintEqualToConstant:64].active = YES;
    [_iconImageView.centerXAnchor constraintEqualToAnchor:_topView.centerXAnchor].active = YES;
    _iconImageView.image = [UIImage imageNamed:@"clear-day"];
    
    [_cityStateLabel.bottomAnchor constraintEqualToAnchor:_summaryLabel.topAnchor constant:0].active = YES;
    [_cityStateLabel.leadingAnchor constraintEqualToAnchor:_topView.leadingAnchor].active = YES;
    [_cityStateLabel.trailingAnchor constraintEqualToAnchor:_topView.trailingAnchor].active = YES;
    [_cityStateLabel setTextColor:UIColor.whiteColor];
    _cityStateLabel.font = [UIFont systemFontOfSize:28.0];
    _cityStateLabel.textAlignment = NSTextAlignmentCenter;
    _cityStateLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
    _cityStateLabel.text = @"San Francisco, CA";
    
    [_summaryLabel.leadingAnchor constraintEqualToAnchor:_topView.leadingAnchor].active = YES;
    [_summaryLabel.trailingAnchor constraintEqualToAnchor:_topView.trailingAnchor].active = YES;
    [_summaryLabel.centerYAnchor constraintEqualToAnchor:_topView.centerYAnchor].active = YES;
    [_summaryLabel.centerXAnchor constraintEqualToAnchor:_topView.centerXAnchor].active = YES;
    [_summaryLabel setTextColor:UIColor.whiteColor];
    _summaryLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _summaryLabel.textAlignment = NSTextAlignmentCenter;
    _summaryLabel.text = @"Clear";
    
    [_temperatureLabel.topAnchor constraintEqualToAnchor:_summaryLabel.bottomAnchor constant:16].active = YES;
    [_temperatureLabel.leadingAnchor constraintEqualToAnchor:_topView.leadingAnchor].active = YES;
    [_temperatureLabel.trailingAnchor constraintEqualToAnchor:_topView.trailingAnchor].active = YES;
    [_temperatureLabel setTextColor:UIColor.whiteColor];
    _temperatureLabel.textAlignment = NSTextAlignmentCenter;
    _temperatureLabel.font = [UIFont systemFontOfSize:60.0 weight:UIFontWeightLight];
    _temperatureLabel.text = @"72°F";
    
    // MARK: - Bottom View Subviews Translate Autoresizing Mask Into Constraints
    
    _windLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _windDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _feelsLikeDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _humidityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _pressureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _humidityDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _pressureDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _chanceOfRainLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _uvIndexLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _chanceOfRainDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _uvIndexDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _settingsButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    // MARK: - Bottom View Constraints
    
    [_bottomView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [_bottomView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_bottomView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_bottomView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.6 constant:0].active = YES;
    
    [_windLabel.leadingAnchor constraintEqualToAnchor:_bottomView.leadingAnchor constant:20].active = YES;
    [_windLabel.trailingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:-20].active = YES;
    [_windLabel.topAnchor constraintEqualToAnchor:_bottomView.topAnchor constant:20].active = YES;
    [_windLabel setTextColor:UIColor.grayColor];
    _windLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    _windLabel.text = @"WIND";
    
    [_feelsLikeLabel.topAnchor constraintEqualToAnchor:_bottomView.topAnchor constant:20].active = YES;
    [_feelsLikeLabel.trailingAnchor constraintEqualToAnchor:_bottomView.trailingAnchor constant:-20].active = YES;
    [_feelsLikeLabel.leadingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:20].active = YES;
    [_feelsLikeLabel setTextColor:UIColor.grayColor];
    _feelsLikeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    _feelsLikeLabel.text = @"FEELS LIKE";
    
    [_windDetailLabel.topAnchor constraintEqualToAnchor:_windLabel.bottomAnchor constant:0].active = YES;
    [_windDetailLabel.leadingAnchor constraintEqualToAnchor:_bottomView.leadingAnchor constant:20].active = YES;
    [_windDetailLabel.trailingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:-20].active = YES;
    [_windDetailLabel setTextColor:UIColor.whiteColor];
    _windDetailLabel.font = [UIFont systemFontOfSize:28.0 weight:UIFontWeightLight];
    _windDetailLabel.text = @"E 8 mph";
    
    [_feelsLikeDetailLabel.topAnchor constraintEqualToAnchor:_feelsLikeLabel.bottomAnchor constant:0].active = YES;
    [_feelsLikeDetailLabel.leadingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:20].active = YES;
    [_feelsLikeDetailLabel.trailingAnchor constraintEqualToAnchor:_bottomView.trailingAnchor constant:0].active = YES;
    [_feelsLikeDetailLabel setTextColor:UIColor.whiteColor];
    _feelsLikeDetailLabel.font = [UIFont systemFontOfSize:28.0 weight:UIFontWeightLight];
    _feelsLikeDetailLabel.text = @"73°";
    
    [_humidityLabel.leadingAnchor constraintEqualToAnchor:_bottomView.leadingAnchor constant:20].active = YES;
    [_humidityLabel.trailingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:-20].active = YES;
    [_humidityLabel.topAnchor constraintEqualToAnchor:_windDetailLabel.bottomAnchor constant:16].active = YES;
    [_humidityLabel setTextColor:UIColor.grayColor];
    _humidityLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    _humidityLabel.text = @"HUMIDITY";
    
    [_pressureLabel.topAnchor constraintEqualToAnchor:_feelsLikeDetailLabel.bottomAnchor constant:16].active = YES;
    [_pressureLabel.trailingAnchor constraintEqualToAnchor:_bottomView.trailingAnchor constant:-20].active = YES;
    [_pressureLabel.leadingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:20].active = YES;
    [_pressureLabel setTextColor:UIColor.grayColor];
    _pressureLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    _pressureLabel.text = @"PRESSURE";
    
    [_humidityDetailLabel.topAnchor constraintEqualToAnchor:_humidityLabel.bottomAnchor constant:0].active = YES;
    [_humidityDetailLabel.leadingAnchor constraintEqualToAnchor:_bottomView.leadingAnchor constant:20].active = YES;
    [_humidityDetailLabel.trailingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:-20].active = YES;
    [_humidityDetailLabel setTextColor:UIColor.whiteColor];
    _humidityDetailLabel.font = [UIFont systemFontOfSize:28.0 weight:UIFontWeightLight];
    _humidityDetailLabel.text = @"40%";
    
    [_pressureDetailLabel.topAnchor constraintEqualToAnchor:_pressureLabel.bottomAnchor constant:0].active = YES;
    [_pressureDetailLabel.leadingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:20].active = YES;
    [_pressureDetailLabel.trailingAnchor constraintEqualToAnchor:_bottomView.trailingAnchor constant:-20].active = YES;
    [_pressureDetailLabel setTextColor:UIColor.whiteColor];
    _pressureDetailLabel.font = [UIFont systemFontOfSize:28.0 weight:UIFontWeightLight];
    _pressureDetailLabel.text = @"30.35 inHg";
    
    [_chanceOfRainLabel.leadingAnchor constraintEqualToAnchor:_bottomView.leadingAnchor constant:20].active = YES;
    [_chanceOfRainLabel.trailingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:-20].active = YES;
    [_chanceOfRainLabel.topAnchor constraintEqualToAnchor:_humidityDetailLabel.bottomAnchor constant:16].active = YES;
    [_chanceOfRainLabel setTextColor:UIColor.grayColor];
    _chanceOfRainLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    _chanceOfRainLabel.text = @"CHANCE OF RAIN";
    
    [_uvIndexLabel.topAnchor constraintEqualToAnchor:_pressureDetailLabel.bottomAnchor constant:16].active = YES;
    [_uvIndexLabel.trailingAnchor constraintEqualToAnchor:_bottomView.trailingAnchor constant:-20].active = YES;
    [_uvIndexLabel.leadingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:20].active = YES;
    [_uvIndexLabel setTextColor:UIColor.grayColor];
    _uvIndexLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    _uvIndexLabel.text = @"UV INDEX";
    
    [_chanceOfRainDetailLabel.topAnchor constraintEqualToAnchor:_chanceOfRainLabel.bottomAnchor constant:0].active = YES;
    [_chanceOfRainDetailLabel.leadingAnchor constraintEqualToAnchor:_bottomView.leadingAnchor constant:20].active = YES;
    [_chanceOfRainDetailLabel.trailingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:-20].active = YES;
    [_chanceOfRainDetailLabel setTextColor:UIColor.whiteColor];
    _chanceOfRainDetailLabel.font = [UIFont systemFontOfSize:28.0 weight:UIFontWeightLight];
    _chanceOfRainDetailLabel.text = @"15%";
    
    [_uvIndexDetailLabel.topAnchor constraintEqualToAnchor:_uvIndexLabel.bottomAnchor constant:0].active = YES;
    [_uvIndexDetailLabel.leadingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:20].active = YES;
    [_uvIndexDetailLabel.trailingAnchor constraintEqualToAnchor:_bottomView.trailingAnchor constant:-20].active = YES;
    [_uvIndexDetailLabel setTextColor:UIColor.whiteColor];
    _uvIndexDetailLabel.font = [UIFont systemFontOfSize:28.0 weight:UIFontWeightLight];
    _uvIndexDetailLabel.text = @"0";
    [_settingsButton.bottomAnchor constraintEqualToAnchor:_bottomView.bottomAnchor constant:-50].active = YES;
    [_settingsButton.trailingAnchor constraintEqualToAnchor:_bottomView.trailingAnchor constant:-20].active = YES;
    [_settingsButton.heightAnchor constraintEqualToConstant:20].active = YES;
    [_settingsButton.widthAnchor constraintEqualToConstant:20].active = YES;
    [_settingsButton setImage:[UIImage systemImageNamed:@"info.circle.fill"] forState:UIControlStateNormal];
    _settingsButton.tintColor = [UIColor whiteColor];
}

- (void)updateViews {
    
    _temperatureLabel.text = [NSString stringWithFormat:@"%.0f°F", _currentForecast.temperature];
    _feelsLikeDetailLabel.text = [NSString stringWithFormat:@"%.0f°F",  _currentForecast.apparentTemperature];
    _humidityDetailLabel.text = [NSString stringWithFormat:@"%.0f %%",  _currentForecast.humidity];
    _pressureDetailLabel.text = [NSString stringWithFormat:@"%.2f inHg",  _currentForecast.pressure];
    _chanceOfRainDetailLabel.text = [NSString stringWithFormat:@"%.0f %%",  _currentForecast.precipProbability];
    _uvIndexDetailLabel.text = [NSString stringWithFormat:@"%.0f",  _currentForecast.uvIndex];
    
    _temperatureLabel.text = [NSString stringWithFormat:@"%f°F", _weatherForecast.current.temperature];
    _feelsLikeDetailLabel.text = [NSString stringWithFormat:@"%f°F",  _weatherForecast.current.apparentTemperature];
    _humidityDetailLabel.text = [NSString stringWithFormat:@"%f %%",  _weatherForecast.current.humidity];
    _pressureDetailLabel.text = [NSString stringWithFormat:@"%f inHg",  _weatherForecast.current.pressure];
    _chanceOfRainDetailLabel.text = [NSString stringWithFormat:@"%f %%",  _weatherForecast.current.precipProbability];
    _uvIndexDetailLabel.text = [NSString stringWithFormat:@"%f",  _weatherForecast.current.uvIndex];
    
    if (self.placemark) {
        self.cityStateLabel.text = [NSString stringWithFormat:@"%@, %@",
                               self.placemark.locality,
                               self.placemark.administrativeArea];
        self.summaryLabel.text = self.currentForecast.summary;
    }
    
    if (self.currentForecast) {
        
        NSLog(@"TEMP: %@", self.currentForecast);
        self.temperatureLabel.text = [NSString stringWithFormat: @"%.0fºF", self.currentForecast.temperature];
        
        self.iconImageView.image = [LSIWeatherIcons weatherImageForIconName:self.currentForecast.icon];
    }
    
    _temperatureLabel.text = [NSString stringWithFormat:@"%.0f°F", _dailyForecast.temperatureHigh];
    _feelsLikeDetailLabel.text = [NSString stringWithFormat:@"%.0f°F",  _dailyForecast.apparentTemperatureHigh];
    _humidityDetailLabel.text = [NSString stringWithFormat:@"%.0f %%",  _dailyForecast.humidity];
    _pressureDetailLabel.text = [NSString stringWithFormat:@"%.2f inHg",  _dailyForecast.pressure];
    _chanceOfRainDetailLabel.text = [NSString stringWithFormat:@"%.0f %%",  _dailyForecast.precipProbability];
    _uvIndexDetailLabel.text = [NSString stringWithFormat:@"%.0f",  _dailyForecast.uvIndex];
    
    _temperatureLabel.text = [NSString stringWithFormat:@"%.0f°F", _hourlyForcast.temperature];
    _feelsLikeDetailLabel.text = [NSString stringWithFormat:@"%.0f°F",  _hourlyForcast.apparentTemperature];
    _humidityDetailLabel.text = [NSString stringWithFormat:@"%.0f %%",  _hourlyForcast.humidity];
    _pressureDetailLabel.text = [NSString stringWithFormat:@"%.2f inHg",  _hourlyForcast.pressure];
    _chanceOfRainDetailLabel.text = [NSString stringWithFormat:@"%.0f %%",  _hourlyForcast.precipProbability];
    _uvIndexDetailLabel.text = [NSString stringWithFormat:@"%.0f",  _hourlyForcast.uvIndex];
}

@end

/// MARK: CLLocationManagerDelegate Methods

@implementation LSIWeatherViewController(CLLocationManagerDelegate)

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locationManager Error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"locationManager: found location %@", locations.firstObject);
    
    CLLocation *location = locations.firstObject;
    
    // 1. Request Weather for location
    
    [self requestWeatherForLocation: location];
    
    // 2. Request User-Friendly Place Names for Lat/Lon coordinate
    
    [self requestUserFriendlyLocation: location];
    
    // Stop updating location after getting one (NOTE: this is faster than doing a single location request)
    [manager stopUpdatingLocation];
}

@end
