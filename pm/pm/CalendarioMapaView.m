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
    
    //NSLog(@"CalendarioMapaView: %@ - %@",self.lat,self.lon);
    finalLocation.latitude = [self.lat doubleValue];
    finalLocation.longitude= [self.lon doubleValue];
        
    //finalLocation.latitude = self.lat;
    //finalLocation.longitude= self.lon;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(finalLocation, 2000, 2000);
    [self.mapView setRegion:region animated:YES];
    
    CGFloat newLat = finalLocation.latitude;
    CGFloat newLon = finalLocation.longitude;
    CLLocationCoordinate2D newCoord = {newLat, newLon};
    
    PachangaPin *annotation = [[PachangaPin alloc]initWithTitle: self.tit subtitle:self.subTit andCoordinate:newCoord];
    [self.mapView addAnnotation:annotation];
}

@end
