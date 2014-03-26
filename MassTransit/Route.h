//
//  Route.h
//  MassTransit
//
//  Created by Austin White on 3/24/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Route : NSObject

@property (nonatomic, strong) NSString *route_id;
@property (nonatomic, strong) NSString *short_name;
@property (nonatomic, strong) NSString *long_name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *text_color;
@property (nonatomic, strong) NSString *url;

- (id) initWithUniqueId:(NSString *)route_id shortName:(NSString *)short_name longName:(NSString *)long_name description:(NSString *)description type:(NSString *)type color:(NSString *)color textColor:(NSString *)text_color url:(NSString *)url;
- (NSString *)name;

@end
