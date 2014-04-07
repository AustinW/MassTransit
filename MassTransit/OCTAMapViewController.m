//
//  OCTAMapViewController.m
//  MassTransit
//
//  Created by Austin White on 4/6/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "OCTAMapViewController.h"

@implementation OCTAMapViewController

- (void)viewDidLoad
{
    self.pdfURL = [[NSBundle mainBundle] URLForResource:@"OCTA" withExtension:@"pdf"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
