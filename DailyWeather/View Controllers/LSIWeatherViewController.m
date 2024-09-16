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
#import "LSISettingsTableVC.h"
#import "CurrentForecast.h"
#import "DailyForecast.h"
#import "HourlyForecast.h"
#import "LSIWeatherForecast.h"
#import "LSIFileHelper.h"
#import "LSICardinalDirection.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;

@property (nonatomic) LSIWeatherForecast *weatherForecast;

// MARK: - UI Properties

@property (nonatomic) UIView *topView;
@property (nonatomic) UIImageView *icon;
@property (nonatomic) UILabel *locationLabel;
@property (nonatomic) UILabel * descriptionLabel;
@property (nonatomic) UILabel * temperatureLabel;
@property (nonatomic) UIView *bottomView;
@property (nonatomic) UILabel *windTitleLabel;
@property (nonatomic) UILabel *windLabel;
@property (nonatomic) UILabel *humidityTitleLabel;
@property (nonatomic) UILabel *humidityLabel;
@property (nonatomic) UILabel *rainChanceTitleLabel;
@property (nonatomic) UILabel *rainChanceLabel;
@property (nonatomic) UILabel *dewpointTitleLabel;
@property (nonatomic) UILabel *dewpointLabel;
@property (nonatomic) UILabel *feelsLikeTitleLabel;
@property (nonatomic) UILabel *feelsLikeLabel;
@property (nonatomic) UILabel *pressureTitleLabel;
@property (nonatomic) UILabel *pressureLabel;
@property (nonatomic) UILabel *UVTitleLabel;
@property (nonatomic) UILabel *UVLabel;
@property (nonatomic) UILabel *visibilityTitleLabel;
@property (nonatomic) UILabel *visibilityLabel;
@property (nonatomic) UIButton *infoButton;

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
    [self setUpSubviews];
    
    // TODO: Transparent toolbar with info button (Settings)
    // TODO: Handle settings button pressed
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
    
    NSData *weatherData = loadFile(@"Weather.json", LSIWeatherViewController.class);
    
    NSError *jsonError = nil;
    NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    
    if (!aDictionary) {
        NSLog(@"Error: %@", jsonError);
        return;
    }
    
    if (![aDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"aDictionary is not a dictionary!!");
        return;
    }
    
    _weatherForecast = [[LSIWeatherForecast alloc] initWithDictionary:aDictionary];
    
    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
}

- (void)updateViews {
    if (self.placemark) {
        // TODO: Update the City, State label
    }
    // TODO: Update the UI based on the current forecast
    _icon.image = [UIImage imageNamed:_weatherForecast.currentWeather.icon];
    _descriptionLabel.text = _weatherForecast.currentWeather.summary;
    _temperatureLabel.text = [NSString stringWithFormat:@"%.0f°F", _weatherForecast.currentWeather.temperature];
    
    if (_weatherForecast.currentWeather.windSpeed == 0) {
        _windLabel.text = @"No Wind";
    } else {
        NSString *bearing = [LSICardinalDirection directionForHeading:_weatherForecast.currentWeather.windBearing];
        _windLabel.text = [NSString stringWithFormat:@"%@ %.0fmph", bearing, _weatherForecast.currentWeather.windSpeed];
    }
    
    _humidityLabel.text = [NSString stringWithFormat:@"%.0f%%", (_weatherForecast.currentWeather.humidity*100.)];
    _rainChanceLabel.text = [NSString stringWithFormat:@"%.0f%%", (_weatherForecast.currentWeather.precipProbability*100.)];
    _dewpointLabel.text = [NSString stringWithFormat:@"%.0f°F", _weatherForecast.currentWeather.dewPoint];
    _feelsLikeLabel.text = [NSString stringWithFormat:@"%.0f°F", _weatherForecast.currentWeather.apparentTemperature];
    _pressureLabel.text = [NSString stringWithFormat:@"%.2f inHg", _weatherForecast.currentWeather.pressure];
    _UVLabel.text = [NSString stringWithFormat:@"%d", _weatherForecast.currentWeather.uvIndex];
    _visibilityLabel.text = [NSString stringWithFormat:@"%d miles", _weatherForecast.currentWeather.visibility];
}

- (void)setUpSubviews {
    CGFloat largeSpacer = (self.view.frame.size.height * 0.1);
    CGFloat mediumSpacer = (self.view.frame.size.height * 0.015);
    CGFloat smallSpacer = (self.view.frame.size.height * 0.005);
    
    _topView = [[UIView alloc] init];
    [self.view addSubview:_topView];
    _topView.translatesAutoresizingMaskIntoConstraints = NO;
    [_topView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_topView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_topView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_topView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.4].active = YES;
    _topView.backgroundColor = UIColor.systemBlueColor;
    
    _icon = [[UIImageView alloc] init];
    [_topView addSubview:_icon];
    _icon.translatesAutoresizingMaskIntoConstraints = NO;
    [_icon.heightAnchor constraintEqualToConstant:64.].active = YES;
    [_icon.widthAnchor constraintEqualToConstant:64.].active = YES;
    [_icon.centerXAnchor constraintEqualToAnchor:_topView.centerXAnchor].active = YES;
    [_icon.topAnchor constraintEqualToAnchor:_topView.topAnchor constant:largeSpacer].active = YES;
    _icon.image = [UIImage imageNamed:@"clear-day"];
    
    _locationLabel = [[UILabel alloc] init];
    [_topView addSubview:_locationLabel];
    _locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_locationLabel.centerXAnchor constraintEqualToAnchor:_topView.centerXAnchor].active = YES;
    [_locationLabel.topAnchor constraintEqualToAnchor:_icon.bottomAnchor constant:mediumSpacer].active = YES;
    _locationLabel.font = [UIFont boldSystemFontOfSize:28.];
    _locationLabel.textColor = UIColor.whiteColor;
    _locationLabel.text = @"San Francisco, CA";
    
    _descriptionLabel = [[UILabel alloc] init];
    [_topView addSubview:_descriptionLabel];
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_descriptionLabel.centerXAnchor constraintEqualToAnchor:_topView.centerXAnchor].active = YES;
    [_descriptionLabel.topAnchor constraintEqualToAnchor:_locationLabel.bottomAnchor].active = YES;
    _descriptionLabel.font = [UIFont systemFontOfSize:17.];
    _descriptionLabel.textColor = UIColor.whiteColor;
    _descriptionLabel.text = @"Clear";
    
    _temperatureLabel = [[UILabel alloc] init];
    [_topView addSubview:_temperatureLabel];
    _temperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_temperatureLabel.centerXAnchor constraintEqualToAnchor:_topView.centerXAnchor].active = YES;
    [_temperatureLabel.topAnchor constraintEqualToAnchor:_descriptionLabel.bottomAnchor constant:16.].active = YES;
    _temperatureLabel.font = [UIFont systemFontOfSize:60.];
    _temperatureLabel.textColor = UIColor.whiteColor;
    _temperatureLabel.text = @"70°F";
    
    _bottomView = [[UIView alloc] init];
    [self.view addSubview:_bottomView];
    _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [_bottomView.topAnchor constraintEqualToAnchor:_topView.bottomAnchor].active = YES;
    [_bottomView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_bottomView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_bottomView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    _bottomView.backgroundColor = [UIColor colorWithRed:0. green:(87./255.) blue:(182./255.) alpha:1.];

    _windTitleLabel = [[UILabel alloc] init];
    [self setUpTitleLabelWithLabel:_windTitleLabel title:@"WIND" isLeftSide:YES];
    [_windTitleLabel.topAnchor constraintEqualToAnchor:_bottomView.topAnchor constant:mediumSpacer].active = YES;
    
    _windLabel = [[UILabel alloc] init];
    [self setUpLabelWithLabel:_windLabel text:@"E 8mph" isLeftSide:YES];
    [_windLabel.topAnchor constraintEqualToAnchor:_windTitleLabel.bottomAnchor constant:smallSpacer].active = YES;
    
    _humidityTitleLabel = [[UILabel alloc] init];
    [self setUpTitleLabelWithLabel:_humidityTitleLabel title:@"HUMIDITY" isLeftSide:YES];
    [_humidityTitleLabel.topAnchor constraintEqualToAnchor:_windLabel.bottomAnchor constant:mediumSpacer].active = YES;
    
    _humidityLabel = [[UILabel alloc] init];
    [self setUpLabelWithLabel:_humidityLabel text:@"40\%" isLeftSide:YES];
    [_humidityLabel.topAnchor constraintEqualToAnchor:_humidityTitleLabel.bottomAnchor constant:smallSpacer].active = YES;
    
    _rainChanceTitleLabel = [[UILabel alloc] init];
    [self setUpTitleLabelWithLabel:_rainChanceTitleLabel title:@"CHANCE OF RAIN" isLeftSide:YES];
    [_rainChanceTitleLabel.topAnchor constraintEqualToAnchor:_humidityLabel.bottomAnchor constant:mediumSpacer].active = YES;
    
    _rainChanceLabel = [[UILabel alloc] init];
    [self setUpLabelWithLabel:_rainChanceLabel text:@"15\%" isLeftSide:YES];
    [_rainChanceLabel.topAnchor constraintEqualToAnchor:_rainChanceTitleLabel.bottomAnchor constant:smallSpacer].active = YES;
    
    _dewpointTitleLabel = [[UILabel alloc] init];
    [self setUpTitleLabelWithLabel:_dewpointTitleLabel title:@"DEWPOINT" isLeftSide:YES];
    [_dewpointTitleLabel.topAnchor constraintEqualToAnchor:_rainChanceLabel.bottomAnchor constant:mediumSpacer].active = YES;
    
    _dewpointLabel = [[UILabel alloc] init];
    [self setUpLabelWithLabel:_dewpointLabel text:@"60" isLeftSide:YES];
    [_dewpointLabel.topAnchor constraintEqualToAnchor:_dewpointTitleLabel.bottomAnchor constant:smallSpacer].active = YES;
    
    _feelsLikeTitleLabel = [[UILabel alloc] init];
    [self setUpTitleLabelWithLabel:_feelsLikeTitleLabel title:@"FEELS LIKE" isLeftSide:NO];
    [_feelsLikeTitleLabel.topAnchor constraintEqualToAnchor:_bottomView.topAnchor constant:mediumSpacer].active = YES;
    
    _feelsLikeLabel = [[UILabel alloc] init];
    [self setUpLabelWithLabel:_feelsLikeLabel text:@"72°F" isLeftSide:NO];
    [_feelsLikeLabel.topAnchor constraintEqualToAnchor:_feelsLikeTitleLabel.bottomAnchor constant:smallSpacer].active = YES;
    
    _pressureTitleLabel = [[UILabel alloc] init];
    [self setUpTitleLabelWithLabel:_pressureTitleLabel title:@"PRESSURE" isLeftSide:NO];
    [_pressureTitleLabel.topAnchor constraintEqualToAnchor:_feelsLikeLabel.bottomAnchor constant:mediumSpacer].active = YES;
    
    _pressureLabel = [[UILabel alloc] init];
    [self setUpLabelWithLabel:_pressureLabel text:@"30.35 inHg" isLeftSide:NO];
    [_pressureLabel.topAnchor constraintEqualToAnchor:_pressureTitleLabel.bottomAnchor constant:smallSpacer].active = YES;
    
    _UVTitleLabel = [[UILabel alloc] init];
    [self setUpTitleLabelWithLabel:_UVTitleLabel title:@"UV INDEX" isLeftSide:NO];
    [_UVTitleLabel.topAnchor constraintEqualToAnchor:_pressureLabel.bottomAnchor constant:mediumSpacer].active = YES;
    
    _UVLabel = [[UILabel alloc] init];
    [self setUpLabelWithLabel:_UVLabel text:@"0" isLeftSide:NO];
    [_UVLabel.topAnchor constraintEqualToAnchor:_UVTitleLabel.bottomAnchor constant:smallSpacer].active = YES;
    
    _visibilityTitleLabel = [[UILabel alloc] init];
    [self setUpTitleLabelWithLabel:_visibilityTitleLabel title:@"VISIBILITY" isLeftSide:NO];
    [_visibilityTitleLabel.topAnchor constraintEqualToAnchor:_UVLabel.bottomAnchor constant:mediumSpacer].active = YES;
    
    _visibilityLabel = [[UILabel alloc] init];
    [self setUpLabelWithLabel:_visibilityLabel text:@"8 miles" isLeftSide:NO];
    [_visibilityLabel.topAnchor constraintEqualToAnchor:_visibilityTitleLabel.bottomAnchor constant:smallSpacer].active = YES;
    
    _infoButton = [[UIButton alloc] init];
    [_bottomView addSubview:_infoButton];
    _infoButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_infoButton.bottomAnchor constraintEqualToAnchor:_bottomView.bottomAnchor constant:(-mediumSpacer * 2)].active = YES;
    [_infoButton.trailingAnchor constraintEqualToAnchor:_bottomView.trailingAnchor constant:(-mediumSpacer * 2)].active = YES;
    [_infoButton setImage:[UIImage systemImageNamed:@"info.circle.fill"] forState:normal];
    [_infoButton setTintColor:UIColor.whiteColor];
    [_infoButton addTarget:self action:@selector(presentTableVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)presentTableVC {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UINavigationController *navVC = [storyboard instantiateViewControllerWithIdentifier:@"SettingsNavController"];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)setUpTitleLabelWithLabel:(UILabel *)label title:(NSString *)title isLeftSide:(BOOL)isLeftSide {
    [_bottomView addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    if (isLeftSide) {
        [label.leadingAnchor constraintEqualToAnchor:_bottomView.leadingAnchor constant:20.].active = YES;
    } else {
        [label.leadingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:20.].active = YES;
    }
    label.font = [UIFont systemFontOfSize:13.];
    label.textColor = [UIColor colorWithWhite:0.8 alpha:1.];
    label.text = title;
}

- (void)setUpLabelWithLabel:(UILabel *)label text:(NSString *)text isLeftSide:(BOOL)isLeftSide {
    [_bottomView addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    if (isLeftSide) {
        [label.leadingAnchor constraintEqualToAnchor:_bottomView.leadingAnchor constant:20.].active = YES;
    } else {
        [label.leadingAnchor constraintEqualToAnchor:_bottomView.centerXAnchor constant:20.].active = YES;
    }
    label.font = [UIFont systemFontOfSize:28.];
    label.textColor = UIColor.whiteColor;
    label.text = text;
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
