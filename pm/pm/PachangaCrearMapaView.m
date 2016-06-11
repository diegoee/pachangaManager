//
//  PachangaCrearMapaView.m
//  pm
//
//  Created by Diego Espínola Espigares on 11/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "PachangaCrearMapaView.h"

@implementation PachangaCrearMapaView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Creamos una coordenada inicial, en nuestro caso perteneciente a Valencia.
    CLLocationCoordinate2D initialLocation;
    initialLocation.latitude = 39.471914;
    initialLocation.longitude= -0.376797;
    
    // Esto situará el centro del mapa en Valencia con la distancia de región que establezcamos.
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(initialLocation, 2000, 2000);
    
    [self.mapView setRegion:region animated:YES];
    
}


@end
