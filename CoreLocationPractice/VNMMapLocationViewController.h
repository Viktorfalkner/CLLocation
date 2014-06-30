//
//  VNMMapLocationViewController.h
//  CoreLocationPractice
//
//  Created by Viktor Falkner on 6/29/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Location.h"

@interface VNMMapLocationViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapOutlet;


@property (strong, nonatomic) Location *locationToBeParsed;
@property (nonatomic) CLLocation *coordinate;


@end
