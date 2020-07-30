//
//  LSIWeatherViewController.m
//
//  Created by Paul Solt on 2/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "LSIWeatherViewController.h"
#import "LSIWeatherIcons.h"
#import "LSICardinalDirection.h"
#import "LSIErrors.h"
#import "LSILog.h"
#import "LSIFileHelper.h"
#import "LSIWeatherForecast.h"
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

// MARK: - Properties
@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
@property (nonatomic) LSIWeatherForecast *weatherForecast;

@property (nonatomic) IBOutlet UIToolbar *toolbar;
@property (nonatomic) IBOutlet UIImageView *iconImageView;

@property (nonatomic) IBOutlet UILabel *cityAndStateLabel;
@property (nonatomic) IBOutlet UILabel *summaryLabel;
@property (nonatomic) IBOutlet UILabel *temperatureLabel;

@property (nonatomic) IBOutlet UILabel *windLabel;
@property (nonatomic) IBOutlet UILabel *humidityPercentageLabel;
@property (nonatomic) IBOutlet UILabel *chanceOfRainLabel;
@property (nonatomic) IBOutlet UILabel *apparentTemperatureLabel;
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
    
    //MARK:- Delete later
    [self updateViews];
    
    // TODO: Transparent toolbar with info button (Settings)
    [self.toolbar setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.toolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
    [self.toolbar isTranslucent];
    
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
    
    
    
    
    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
}

- (void)updateViews {
    if (self.placemark) {
        // TODO: Update the City, State label
        self.cityAndStateLabel.text = [NSString stringWithFormat:@"%@, %@", self.placemark.locality, self.placemark.administrativeArea];
    }
    
    // TODO: Update the UI based on the current forecast
    NSString *iconName = self.weatherForecast.currently.icon;
    UIImage *icon = [LSIWeatherIcons weatherImageForIconName:iconName];
    self.iconImageView.image = icon;

    NSString *temperature = [NSString stringWithFormat:@"%.0f°F", self.weatherForecast.currently.temperature];
    self.temperatureLabel.text = temperature;

    NSString *windDirection = [LSICardinalDirection directionForHeading:self.weatherForecast.currently.windBearing];
    NSString *windSpeed = [NSString stringWithFormat:@"%.0f", self.weatherForecast.currently.windSpeed];
    self.windLabel.text = [NSString stringWithFormat:@"%@ %@ mph", windDirection, windSpeed];

    NSString *humidity = [NSString stringWithFormat:@"%.0f", self.weatherForecast.currently.humidity*100];
    self.humidityPercentageLabel.text = [NSString stringWithFormat:@"%@%%", humidity];

    NSString *precipProbability = [NSString stringWithFormat:@"%.0f", self.weatherForecast.currently.precipProbability*100];
    self.chanceOfRainLabel.text = [NSString stringWithFormat:@"%@%%", precipProbability];

    NSString *apparentTemperature = [NSString stringWithFormat:@"%.0f°", self.weatherForecast.currently.apparentTemperature];
    self.apparentTemperatureLabel.text = apparentTemperature;

    double pressureInMillibars = self.weatherForecast.currently.pressure;
    NSString *pressureInInchesOfMercury = [NSString stringWithFormat:@"%.2f", pressureInMillibars * 0.02953];
    self.pressureLabel.text = [NSString stringWithFormat:@"%@ inHg", pressureInInchesOfMercury];

    NSString *uvIndex = [NSString stringWithFormat:@"%.0f", self.weatherForecast.currently.uvIndex];
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
