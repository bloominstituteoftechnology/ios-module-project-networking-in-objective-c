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
#import "AMSWeatherController.h"
#import "LSICardinalDirection.h"
#import "LSIWeatherIcons.h"
#import "DailyWeather-Swift.h"
#import "AMSWeatherTableViewController.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

@property CLLocationManager *locationManager;
@property (nonatomic) CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;

//Top Outlets
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

//Bottom Outlets
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *chanceOfRainLabel;
@property (weak, nonatomic) IBOutlet UILabel *uvIndexLabel;

@property (weak, nonatomic) IBOutlet CustomSegmentedControl *detailSegment;
@property (weak, nonatomic) IBOutlet UIView *forecastView;
@property (nonatomic) AMSWeatherTableViewController *forecastTableView;

@property (nonatomic) AMSWeather *weather;

- (void)setUpViews:(AMSWeather *)weather;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(segmentChanged:) name:@"SegmentChanged" object:nil];
    
    self.forecastTableView = [self childViewControllers].firstObject;
}

-(void)getWeather {
    AMSWeatherController *forecast = [[AMSWeatherController alloc] init];
    [forecast getJson:^(AMSWeather * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self->_weather = data;
        [self setUpViews:data];
    } location: _location.coordinate];
}

- (void)setUpViews:(AMSWeather *)weather {
    self->_weatherImageView.image = [LSIWeatherIcons weatherImageForIconName:weather.currently.icon];
    self->_temperatureLabel.text = [NSString stringWithFormat:@"%d°", weather.currently.temperature.intValue];
    self->_windLabel.text = [NSString stringWithFormat:@"%@ %d mph", [LSICardinalDirection directionForHeading:weather.currently.windBearing.doubleValue], weather.currently.windSpeed.intValue];
    self->_feelsLikeLabel.text = [NSString stringWithFormat:@"%d°", weather.currently.apparentTemperature.intValue];
    self->_humidityLabel.text = [NSString stringWithFormat:@"%.0f%%", weather.currently.humidity.doubleValue*100];
    self->_pressureLabel.text = [NSString stringWithFormat:@"%.2f inHg", weather.currently.pressure.doubleValue/33.8639];
    self->_chanceOfRainLabel.text = [NSString stringWithFormat:@"%.0f%%", weather.currently.precipProbability.doubleValue*100];
    self->_uvIndexLabel.text = [NSString stringWithFormat:@"%d", weather.currently.uvIndex.intValue];
}

-(void)segmentChanged: (NSNotification *)notification {
    long segmentIndex = _detailSegment.selectedIndex;
    if (segmentIndex == 0) {
        [_forecastView setHidden:YES];
    } else if (segmentIndex == 1) {
        [_forecastView setHidden:NO];
        [_forecastTableView setWeather:self.weather];
        [_forecastTableView setIsDaily:NO];
    } else if (segmentIndex == 2) {
        [_forecastView setHidden:NO];
        [_forecastTableView setWeather:self.weather];
        [_forecastTableView setIsDaily:YES];
    }
}

- (void)setLocation:(CLLocation *)location {
    _location = location;
    [self getWeather];
}

- (void)setPlacemark:(CLPlacemark *)placemark {
    _placemark = placemark;
    _locationLabel.text = [NSString stringWithFormat:@"%@, %@", placemark.locality, placemark.administrativeArea];
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
            });
            requestedLocation = NO;
        }];
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
    
    
    // 2. Request User-Friendly Place Names for Lat/Lon coordinate
    
    [self requestUserFriendlyLocation: location];
    
    // Stop updating location after getting one (NOTE: this is faster than doing a single location request)
    [manager stopUpdatingLocation];
}

@end
