//
//  CalendarioMapaView.h
//  pm
//
//  Created by Diego Espínola Espigares on 12/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "PachangaPin.h"
#import "CalendarioTableView.h"

// Convertimos al controlador en delegado de MapKit
@interface CalendarioMapaView : UIViewController <MKMapViewDelegate>

// Creamos un Outlet de tipo MKMapView para controlar el objeto del mapa.
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSNumber *lat;
@property (strong, nonatomic) NSNumber *lon;
@property (strong, nonatomic) NSString *tit;
@property (strong, nonatomic) NSString *subTit;


@end
