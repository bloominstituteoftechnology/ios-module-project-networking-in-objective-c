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
#import "LSIWeatherForcast.h"
#import "LSIFileHelper.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
@property (nonatomic) LSIWeatherForcast *weatherForcase;

@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempLabel;

@property (strong, nonatomic) IBOutlet UILabel *windLabel;
@property (strong, nonatomic) IBOutlet UILabel *apparentLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidyLabel;
@property (strong, nonatomic) IBOutlet UILabel *pressureLabel;
@property (strong, nonatomic) IBOutlet UILabel *rainProbLabel;
@property (strong, nonatomic) IBOutlet UILabel *uvLabel;

@end




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

- (void)requestWeatherForLocation:(CLLocation *)location {
    
    // TODO: 1. Parse CurrentWeather.json from App Bundle and update UI
    NSData *data = loadFile(@"CurrentWeather.json", [LSIWeatherForcast class]);
    NSError *error = nil;
    NSDictionary *weather = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Error requesting weather json file: %@", weather);
        return;
    }
    _weatherForcase = [[LSIWeatherForcast alloc]initWithDictionary:weather];
    
    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
}

- (void)updateViews {
    
    if (self.placemark) {
        // TODO: Update the City, State label
        _iconImage.image = [LSIWeatherIcons weatherImageForIconName:_weatherForcase.icon];
        _locationLabel.text = _placemark.name;
        _summaryLabel.text = _weatherForcase.summary;
        _tempLabel.text = _weatherForcase.temperature.stringValue;
        
        _windLabel.text = _weatherForcase.windSpeed.stringValue;
        _apparentLabel.text = _weatherForcase.apparentTemperature.stringValue;
        _humidyLabel.text = _weatherForcase.humidity.stringValue;
        _pressureLabel.text = _weatherForcase.pressure.stringValue;
        _rainProbLabel.text = _weatherForcase.precipProbability.stringValue;
        _uvLabel.text = _weatherForcase.uvIndex.stringValue;
        
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
