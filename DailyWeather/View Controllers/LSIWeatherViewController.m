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
#import "LSICardinalDirection.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

// MARK: - Properties
@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;

// MARK: - Outlets
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *appTemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidityLabel;
@property (strong, nonatomic) IBOutlet UILabel *pressureLabel;
@property (strong, nonatomic) IBOutlet UILabel *precipProbabilityLabel;
@property (strong, nonatomic) IBOutlet UILabel *uvIndexLabel;

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

- (void)setPlacemark:(CLPlacemark *)placemark {
    _placemark = placemark;
    self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", placemark.locality ,placemark.administrativeArea];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    NSData *data = loadFile(@"CurrentWeather.json", [LSIWeatherForecast class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {
        NSLog(@"Error parsing JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);
    
    LSIWeatherForecast *weatherForcast = [[LSIWeatherForecast alloc] initWithDictionary:json];

    self.imageView.image = [LSIWeatherIcons weatherImageForIconName:weatherForcast.icon];
    self.summaryLabel.text = weatherForcast.summary;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%0.0f°F", weatherForcast.temperature.doubleValue];
    NSString *bearing = [LSICardinalDirection directionForHeading:weatherForcast.windBearing.doubleValue];
    self.windSpeedLabel.text = [NSString stringWithFormat:@"%@ %0.0f mph", bearing, weatherForcast.windSpeed.doubleValue];
    self.appTemperatureLabel.text = [NSString stringWithFormat:@"%0.0f°F", weatherForcast.apparentTemperature.doubleValue];
    self.humidityLabel.text = [NSString stringWithFormat:@"%0.0f%%", weatherForcast.humidity.doubleValue * 100.0];
    self.pressureLabel.text = [NSString stringWithFormat:@"%0.2f inHg", weatherForcast.pressure.doubleValue]; // is this right?
    self.precipProbabilityLabel.text = [NSString stringWithFormat:@"%0.0f%%", weatherForcast.precipProbablity.doubleValue];
    self.uvIndexLabel.text = [NSString stringWithFormat:@"%i", weatherForcast.uvIndex.intValue];
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
    
    // TODO: 1. Parse CurrentWeather.json from App Bundle and update UI
    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
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
