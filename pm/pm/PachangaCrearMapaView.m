//
//  PachangaCrearMapaView.m
//  pm
//
//  Created by Diego Espínola Espigares on 11/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "PachangaCrearMapaView.h"

@implementation PachangaCrearMapaView

CLLocationCoordinate2D finalLocation;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    finalLocation.latitude = 37.992485;
    finalLocation.longitude= -1.130641;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(finalLocation, 2000, 2000);
    [self.mapView setRegion:region animated:YES];
    
    CGFloat newLat = finalLocation.latitude;
    CGFloat newLon = finalLocation.longitude;
    CLLocationCoordinate2D newCoord = {newLat, newLon};
    CLLocation *tapLocation = [[CLLocation alloc] initWithLatitude:finalLocation.latitude longitude:finalLocation.longitude];
    
    PachangaPin *annotation = [[PachangaPin alloc]initWithTitle: @"Punto de inicio" subtitle:[NSString stringWithFormat:@"%f,%f",tapLocation.coordinate.latitude,tapLocation.coordinate.longitude] andCoordinate:newCoord];
    [self.mapView addAnnotation:annotation];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCoordinatesFromTap:)];
    [self.mapView addGestureRecognizer:tapRecognizer];    
}


- (void)getCoordinatesFromTap:(UITapGestureRecognizer *)recognizer{
    
    //Obtenemos el punto de toque y lo convertimos a una coordenada de mapa
    CGPoint point = [recognizer locationInView:self.mapView];
    CLLocationCoordinate2D tapCoordinate = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    
    //Inicializamos una CLLocation con las coordenadas obtenidas y actualizamos el pin del mapa
    CLLocation *tapLocation = [[CLLocation alloc] initWithLatitude:tapCoordinate.latitude longitude:tapCoordinate.longitude];
    
    //Cargamos un pin con las coordenadas obtenidas e inicializamos los textos del callout
    PachangaPin *annotation = [[PachangaPin alloc] initWithTitle:@"Tu posición seleccionada" subtitle:[NSString stringWithFormat:@"%f,%f",tapLocation.coordinate.latitude,tapLocation.coordinate.longitude] andCoordinate:tapLocation.coordinate];
    
    //Eliminamos el pin existente y lo añadimos con la misma posición
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:annotation];
    
    //Centramos el mapa en la localización proporcionada
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(tapLocation.coordinate, 5000, 5000);
    
    finalLocation.latitude  = tapLocation.coordinate.latitude;
    finalLocation.longitude = tapLocation.coordinate.longitude;
    
    [self.mapView setRegion:region animated:YES];
    
}

- (IBAction)addPachanga:(UIButton *)save {
    //NSLog(@"%@",_fechaSel.date);
    PachangaView *vc = [[PachangaView alloc]init];
    [vc savePachangaWithNombre:self.nombre fecha:self.fecha lat:[NSNumber numberWithFloat: finalLocation.latitude] lon:[NSNumber numberWithFloat: finalLocation.longitude]];    
    //NSLog(@"PachangaCrearMapaView: %@ - %@ - %@ - %@", self.nombre, self.fecha,[NSNumber numberWithFloat: finalLocation.latitude],[NSNumber numberWithFloat: finalLocation.longitude]);
}



@end
