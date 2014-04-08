//
//  Route.m
//  MassTransit
//
//  Created by Austin White on 3/24/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "Route.h"

@implementation Route

@synthesize route_id    = _route_id;
@synthesize short_name  = _short_name;
@synthesize long_name   = _long_name;
@synthesize description = _description;
@synthesize type        = _type;
@synthesize color       = _color;
@synthesize text_color  = _text_color;
@synthesize url         = _url;

- (id) initWithUniqueId:(NSString *)route_id shortName:(NSString *)short_name longName:(NSString *)long_name description:(NSString *)description type:(NSString *)type color:(NSString *)color textColor:(NSString *)text_color url:(NSString *)url
{
    self = [super init];
    
    if (self) {
        self.route_id    = route_id;
        self.short_name  = short_name;
        self.long_name   = long_name;
        self.description = description;
        self.type        = type;
        self.color       = color;
        self.text_color  = text_color;
        self.url         = url;
    }
    
    return self;
}

- (NSString *)name
{
    if ([self.short_name isEqualToString:@""]) {
        return self.long_name;
    } else if ([self.long_name isEqualToString:@""]) {
        return self.short_name;
    } else {
        return [NSString stringWithFormat:@"%@ - %@", self.long_name, self.short_name];
    }
}

@end
