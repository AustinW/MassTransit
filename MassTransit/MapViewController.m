//
//  MapViewController.m
//  MassTransit
//
//  Created by Austin White on 3/25/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "MapViewController.h"
#import "PDFScrollView.h"

@implementation MapViewController

@synthesize pdfURL = _pdfURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"PDF: %@", [self.pdfURL absoluteString]);
    
    //Open the PDF document, extract the first page, and pass the page to the PDF scroll view.
    CGPDFDocumentRef PDFDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)self.pdfURL);
    
    CGPDFPageRef PDFPage = CGPDFDocumentGetPage(PDFDocument, 1);
    [(PDFScrollView *)self.view setPDFPage:PDFPage];
    
    CGPDFDocumentRelease(PDFDocument);
}

@end
