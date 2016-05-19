//
//  Jugador.m
//  pruebaWeakStrong
//
//  Created by admin on 12/2/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "Competicion.h"

@implementation Competicion

@synthesize nombre;
@synthesize deporte;

-(Competicion *) initWithName:(NSString*)name andSport:(NSString *)sport {
    nombre = name;
    deporte = sport;
    NSLog(@"Competicion init");
    return self;
}

- (void)dealloc{
    NSLog(@"Free: %@",self.nombre);
}

@end
