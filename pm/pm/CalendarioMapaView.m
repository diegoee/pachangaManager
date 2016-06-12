//
//  CalendarioMapaView.m
//  pm
//
//  Created by Diego Espínola Espigares on 12/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "CalendarioMapaView.h"

@implementation CalendarioMapaView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLLocationCoordinate2D finalLocation;
    
    finalLocation.latitude = 37.992485;
    finalLocation.longitude= -1.130641;
        
    //finalLocation.latitude = self.lat;
    //finalLocation.longitude= self.lon;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(finalLocation, 5000, 5000);
    [self.mapView setRegion:region animated:YES];
    
    CGFloat newLat = finalLocation.latitude;
    CGFloat newLon = finalLocation.longitude;
    CLLocationCoordinate2D newCoord = {newLat, newLon};
    
    PachangaPin *annotation = [[PachangaPin alloc]initWithTitle: self.tit subtitle:self.subTit andCoordinate:newCoord];
    [self.mapView addAnnotation:annotation];
}

@end
