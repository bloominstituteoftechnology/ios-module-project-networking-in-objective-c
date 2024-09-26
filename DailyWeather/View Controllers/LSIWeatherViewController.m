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
#import "LSICurrentWeather.h"
#import "LSIFileHelper.h"
#import "LSIWeatherIcons.h"
#import "LSICardinalDirection.h"
#import "LSIWeatherForecast.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;

// MARK: - Outlets

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *windLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidityLabel;
@property (strong, nonatomic) IBOutlet UILabel *chanceOfRainLabel;
@property (strong, nonatomic) IBOutlet UILabel *feelsLikeLabel;
@property (strong, nonatomic) IBOutlet UILabel *pressureLabel;
@property (strong, nonatomic) IBOutlet UILabel *uvIndexLabel;

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

- (void)parseCurrentWeather {
    // 1. Parse CurrentWeather.json from App Bundle and update UI

    // Load test object from file.
    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", [LSICurrentWeather class]);

    // Pass through JSON Serializer
    // Parse the dictionary and turn it into a CurrentWeather object
    NSError *jsonError = nil;
    NSDictionary *currentWeatherDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }

    // Pass it through LSIWeatherForecast initializer
    LSICurrentWeather *currentWeather = [[LSICurrentWeather alloc] initWithDictionary:currentWeatherDictionary];

    // TODO: icon
    UIImage *unknownImage = [LSIWeatherIcons weatherImageForIconName:@"unknown"];
    if (currentWeather.icon == nil) {
        _iconImageView.image = unknownImage;
    } else {
        UIImage *currentIcon = [LSIWeatherIcons weatherImageForIconName:currentWeather.icon];
        if (currentIcon == nil) {
            currentIcon = unknownImage;
        }
        _iconImageView.image = currentIcon;
    }

    // TODO: location
    _locationLabel.text = @"--";

    _summaryLabel.text = currentWeather.summary;

    _temperatureLabel.text = [NSString stringWithFormat:@"%.0fº", currentWeather.temperature];

    if ((currentWeather.windSpeed == nil) || (currentWeather.windBearing == nil)) {
        _windLabel.text = @"--";
    } else {
        double windSpeed = [currentWeather.windSpeed doubleValue];
        double windBearing = [currentWeather.windBearing doubleValue];
        NSString *windBearingStr = [LSICardinalDirection directionForHeading:windBearing];
        _windLabel.text = [NSString stringWithFormat:@"%@ %.0f mph", windBearingStr, windSpeed];
    }

    if (currentWeather.humidity == nil) {
        _humidityLabel.text = @"--";
    } else {
        double humidity = [currentWeather.humidity doubleValue] * 100;
        _humidityLabel.text = [NSString stringWithFormat:@"%.0f%%", humidity];
    }

    if (currentWeather.precipProbability == nil) {
        _chanceOfRainLabel.text =  @"--";
    } else {
        double precipProbability = [currentWeather.precipProbability doubleValue] * 100;
        _chanceOfRainLabel.text = [NSString stringWithFormat:@"%.0f%%", precipProbability];
    }

    _feelsLikeLabel.text = [NSString stringWithFormat:@"%.0fº", currentWeather.apparentTemperature];

    if (currentWeather.pressure == nil) {
        _pressureLabel.text =  @"--";
    } else {
        // Convert millibars to inches of mercury (inHg)
        double pressure = [currentWeather.pressure doubleValue] / 33.863886666667;
        _pressureLabel.text = [NSString stringWithFormat:@"%0.2F inHg", pressure];
    }

    if (currentWeather.pressure == nil) {
        _uvIndexLabel.text =  @"--";
    } else {
        int uvIndex = [currentWeather.uvIndex intValue];
        _uvIndexLabel.text = [NSString stringWithFormat:@"%d", uvIndex];
    }
}

- (void)parseWeather {
    // 2. Refactor and Parse Weather.json from App Bundle and update UI

    // Load test object from file.
    NSData *weatherData = loadFile(@"Weather.json", [LSIWeatherForecast class]);

    // Pass through JSON Serializer
    // Parse the dictionary and turn it into a Weather object
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }

    // Pass it through LSIWeatherForecast initializer
    LSIWeatherForecast *weather = [[LSIWeatherForecast alloc] initWithDictionary:weatherDictionary];

    // TODO: icon
    UIImage *unknownImage = [LSIWeatherIcons weatherImageForIconName:@"unknown"];
    if (weather.currently.icon == nil) {
        _iconImageView.image = unknownImage;
    } else {
        UIImage *currentIcon = [LSIWeatherIcons weatherImageForIconName:weather.currently.icon];
        if (currentIcon == nil) {
            currentIcon = unknownImage;
        }
        _iconImageView.image = currentIcon;
    }

    // TODO: location
    _locationLabel.text = @"--";

    _summaryLabel.text = weather.currently.summary;

    _temperatureLabel.text = [NSString stringWithFormat:@"%.0fº", weather.currently.temperature];

    if ((weather.currently.windSpeed == nil) || (weather.currently.windBearing == nil)) {
        _windLabel.text = @"--";
    } else {
        double windSpeed = [weather.currently.windSpeed doubleValue];
        double windBearing = [weather.currently.windBearing doubleValue];
        NSString *windBearingStr = [LSICardinalDirection directionForHeading:windBearing];
        _windLabel.text = [NSString stringWithFormat:@"%@ %.0f mph", windBearingStr, windSpeed];
    }

    if (weather.currently.humidity == nil) {
        _humidityLabel.text = @"--";
    } else {
        double humidity = [weather.currently.humidity doubleValue] * 100;
        _humidityLabel.text = [NSString stringWithFormat:@"%.0f%%", humidity];
    }

    if (weather.currently.precipProbability == nil) {
        _chanceOfRainLabel.text =  @"--";
    } else {
        double precipProbability = [weather.currently.precipProbability doubleValue] * 100;
        _chanceOfRainLabel.text = [NSString stringWithFormat:@"%.0f%%", precipProbability];
    }

    _feelsLikeLabel.text = [NSString stringWithFormat:@"%.0fº", weather.currently.apparentTemperature];

    if (weather.currently.pressure == nil) {
        _pressureLabel.text =  @"--";
    } else {
        // Convert millibars to inches of mercury (inHg)
        double pressure = [weather.currently.pressure doubleValue] / 33.863886666667;
        _pressureLabel.text = [NSString stringWithFormat:@"%0.2F inHg", pressure];
    }

    if (weather.currently.pressure == nil) {
        _uvIndexLabel.text =  @"--";
    } else {
        int uvIndex = [weather.currently.uvIndex intValue];
        _uvIndexLabel.text = [NSString stringWithFormat:@"%d", uvIndex];
    }
}

- (void)requestWeatherForLocation:(CLLocation *)location {
    
    [self parseCurrentWeather];

//    [self parseWeather];
}

- (void)updateViews {
    if (self.placemark) {
        // TODO: Update the City, State label
    }
    
    // TODO: Update the UI based on the current forecast
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
