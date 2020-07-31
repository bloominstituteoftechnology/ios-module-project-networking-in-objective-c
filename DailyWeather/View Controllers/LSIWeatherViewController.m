//
//  LSIWeatherViewController.m
//
//  Created by Paul Solt on 2/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "LSIWeatherViewController.h"
#import "../Helpers/LSIWeatherIcons.h"
#import "../LambdaSDK/LSIErrors.h"
#import "../LambdaSDK/LSILog.h"
#import "../Model/LSIWeatherForcast.h"
#import "../Model/LSICurrentForecast.h"
#import "../Model/LSIDailyForecast.h"
#import "../Model/LSIHourlyForecast.h"
#import "../Helpers/LSICardinalDirection.h"
#import "../LambdaSDK/LSIFileHelper.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
@property (nonatomic) LSICurrentForecast *weatherForecast;

@property (nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic) IBOutlet UILabel *cityAndStateLabel;
@property (nonatomic) IBOutlet UILabel *summaryLabel;
@property (nonatomic) IBOutlet UILabel *temperatureLabel;
@property (nonatomic) IBOutlet UILabel *windSpeedAndDirectionLabel;
@property (nonatomic) IBOutlet UILabel *humidityLabel;
@property (nonatomic) IBOutlet UILabel *changeOfRainLabel;
@property (nonatomic) IBOutlet UILabel *feelsLikeLabel;
@property (nonatomic) IBOutlet UILabel *pressureLabel;
@property (nonatomic) IBOutlet UILabel *uvIndexLabel;

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
    
        // Parse CurrentWeather.json from App Bundle and update UI
        NSData *weatherData = loadFile(@"CurrentWeather.json", [LSIWeatherViewController class]);
        
        NSError *jsonError = nil;
        NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
        
        self.weatherForecast = [[LSICurrentForecast alloc] initWithDictionary:weatherDictionary];
    
    [self updateViews];
}

- (void)updateViews {
    if (self.placemark) {
        // TODO: Update the City, State label
        self.cityAndStateLabel.text = [NSString stringWithFormat:@"%@, %@", self.placemark.locality, self.placemark.administrativeArea];
    }
    
    // TODO: Update the UI based on the current forecast
    NSString *icon = self.weatherForecast.icon;
    
    UIImage *iconImage = [LSIWeatherIcons weatherImageForIconName:icon];
    self.iconImageView.image = iconImage;
    
    NSString *summary = [NSString stringWithFormat:@"%@", self.weatherForecast.summary];
    self.summaryLabel.text = summary;
    
    NSString *temperature = [NSString stringWithFormat:@"%.0f°F", self.weatherForecast.temperature];
    self.temperatureLabel.text = temperature;
    
    NSString *windDirection = [LSICardinalDirection directionForHeading:self.weatherForecast.windBearing];
    NSString *windSpeed = [NSString stringWithFormat:@"%.0f", self.weatherForecast.windSpeed];
    self.windSpeedAndDirectionLabel.text = [NSString stringWithFormat:@"%@ %@", windDirection, windSpeed];
    
    NSString *humidity = [NSString stringWithFormat:@"%.0f", self.weatherForecast.humidity*100];
    self.humidityLabel.text = [NSString stringWithFormat:@"%@", humidity];
    
    NSString *precipProbability = [NSString stringWithFormat:@"%d", self.weatherForecast.precipProbability];
    self.changeOfRainLabel.text = [NSString stringWithFormat:@"%@", precipProbability];
    
    NSString *apparentTemperature = [NSString stringWithFormat:@"%.0f", self.weatherForecast.apparentTemperature];
    self.feelsLikeLabel.text = apparentTemperature;
    
    double pressure = self.weatherForecast.pressure;
    NSString *pressureInHg = [NSString stringWithFormat:@"%.2f", pressure * 0.02953];
    self.pressureLabel.text = [NSString stringWithFormat:@"%@", pressureInHg];
    
    NSString *uvIndex = [NSString stringWithFormat:@"%.0d", self.weatherForecast.uvIndex];
    self.uvIndexLabel.text = [NSString stringWithFormat:@"%@", uvIndex];
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
