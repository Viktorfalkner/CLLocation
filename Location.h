//
//  Location.h
//  CoreLocationPractice
//
//  Created by Troy Barrett on 6/29/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *meetingName;

-(instancetype)initWithMeetingName:(NSString *)meetingName withLatidue:(NSNumber *)latitude withLongitude:(NSNumber *)longitude;


+(void)sendLocationToParse:(Location *)newLocation;



@end
