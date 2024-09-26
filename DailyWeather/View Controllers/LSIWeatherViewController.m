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
#import "LSICurrentForecast.h"
#import "LSIWeatherIcons.h"
#import "LSISettingsTableVC.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

// Properties

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
@property (nonatomic) LSICurrentForecast *forecast;

// Outlets
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *chanceOfRainLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *uvIndexLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;



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
    
    [self.toolBar setBackgroundImage:[UIImage new]
                  forToolbarPosition:UIBarPositionAny
                          barMetrics:UIBarMetricsDefault];
    [self.toolBar setShadowImage:[UIImage new]
              forToolbarPosition:UIBarPositionAny];
}


- (IBAction)settingsTapped:(UIBarButtonItem *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    LSISettingsTableVC *settingsVC = [storyboard instantiateViewControllerWithIdentifier:@"LSISettingsTableVC"];
    
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    
    [self presentViewController:navigationVC animated:YES completion:nil];
    
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
    
  if(!_requestedLocation) {
        _requestedLocation = YES;
        __block BOOL requestedLocation = _requestedLocation;
        
        [self requestCurrentPlacemarkForLocation:location withCompletion:^(CLPlacemark *place, NSError *error) {
            
            NSLog(@"Location: %@, %@", place.locality, place.administrativeArea);
            self.placemark = place;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
            });
            requestedLocation = NO;
        }];
    }
    
}

- (void)updateViews {
    if (self.placemark) {
       self.locationLabel.text = [NSString stringWithFormat:@"%@, %@",
                               self.placemark.locality,
                               self.placemark.administrativeArea];
        self.summaryLabel.text = self.forecast.summary;
    }
    
    if (self.forecast) {
        
        NSLog(@"TEMP: %@", self.forecast);
        self.temperatureLabel.text = [NSString stringWithFormat: @"%0.0fºF", self.forecast.temperature];
        
        self.weatherImage.image = [LSIWeatherIcons weatherImageForIconName:self.forecast.icon];
    }
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
