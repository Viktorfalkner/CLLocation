//
//  VNMViewController.m
//  CoreLocationPractice
//
//  Created by Marcus Smith on 6/29/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "VNMViewController.h"
#import <Parse/Parse.h>
#import "Location.h"

@interface VNMViewController () {
    //CLLocationManager allows us to get our location
    //Geocoder & placemark allow us to convert GPS coordinates into user-readable address
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@property (strong, nonatomic) IBOutlet UILabel *latitudeValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressValueLabel;
- (IBAction)getCurrentLocation:(id)sender;

@end

@implementation VNMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Instantiation of private instance variables
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)getCurrentLocation:(id)sender
{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error
{
    //Error message
    NSLog(@"didFailWithError: %@", error);
    
    //Error alertView
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    //Obtaining the location
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    //Setting the lat/long to the UILabels
    if (currentLocation != nil) {
        self.longitudeValueLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latitudeValueLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
    }
    
    //Stop LocationManager
    [locationManager stopUpdatingLocation];
    
    //Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            self.addressValueLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@", placemark.subThoroughfare, placemark.thoroughfare, placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

@end
