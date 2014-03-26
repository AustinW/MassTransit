//
//  MassTransitMTAMapViewController.m
//  MassTransit
//
//  Created by Austin White on 3/25/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "MassTransitMTAMapViewController.h"

@interface MassTransitMTAMapViewController ()
@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;
@property (strong, nonatomic) IBOutlet UIView *pdfView;

@end

@implementation MassTransitMTAMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *pdfUrl = [[NSBundle mainBundle] URLForResource:@"mta_system_map" withExtension:@"pdf"];
    
    if (pdfUrl) {
        // Initialize Document Interaction Controller
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:pdfUrl];
        
        // Configure Document Interaction Controller
        [self.documentInteractionController setDelegate:self];
        
    }
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (UIView *) documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.pdfView;
}

- (CGRect) documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return self.pdfView.frame;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
