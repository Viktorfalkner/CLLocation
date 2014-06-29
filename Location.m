//
//  Location.m
//  CoreLocationPractice
//
//  Created by Troy Barrett on 6/29/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)init
{
    return [self initWithMeetingName:@"" withLatidue:@0 withLongitude:@0];
}

-(instancetype)initWithMeetingName:(NSString *)meetingName withLatidue:(NSNumber *)latitude withLongitude:(NSNumber *)longitude {
    self = [super init];
    if (self) {
        _meetingName = meetingName;
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;

}

@end
