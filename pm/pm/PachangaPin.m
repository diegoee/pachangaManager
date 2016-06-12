//
//  PachangaPin.m
//  pm
//
//  Created by Diego Espínola Espigares on 11/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "PachangaPin.h"

@implementation PachangaPin

// Hacemos synthesize
@synthesize title, subtitle, coordinate;

// Implementamos el método de inicialización del objeto.
- (id)initWithTitle:(NSString *)aTitle subtitle:(NSString*)aSubtitle andCoordinate:(CLLocationCoordinate2D)coord
{
    self = [super init];
    title = aTitle;
    subtitle = aSubtitle;
    coordinate = coord;
    return self;
}


@end
