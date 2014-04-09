//
//  Trip.h
//  MassTransit
//
//  Created by Austin White on 4/6/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip : NSObject

@property (nonatomic, strong) NSString *tripName;
@property (nonatomic, strong) NSString *tripStartTime;
@property (nonatomic, strong) NSString *tripEndTime;

@property (nonatomic, strong) NSDictionary *attributes;

- (id)initWithDictionary:(NSDictionary *)trip;
- (id)attribute:(NSString *)key;

@end

