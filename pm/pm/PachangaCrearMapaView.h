//
//  PachangaCrearMapaView.h
//  pm
//
//  Created by Diego Espínola Espigares on 11/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "PachangaPin.h"
#import "PachangaView.h"

// Convertimos al controlador en delegado de MapKit
@interface PachangaCrearMapaView : UIViewController <MKMapViewDelegate>

// Creamos un Outlet de tipo MKMapView para controlar el objeto del mapa.
@property(nonatomic, retain) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSDate *fecha;
@property (strong, nonatomic) NSString *nombre;

- (IBAction)addPachanga:(UIButton *)save;

@end
