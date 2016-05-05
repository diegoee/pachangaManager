//
//  Competicion.m
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 5/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import "Competicion.h"

@implementation Competicion

@synthesize nombre;
@synthesize deporte;

-(Competicion *) initWithName:(NSString*)name andSport:(NSString*)sport {
    nombre = name;
    deporte = sport;
    return self;
}

- (void)dealloc{
    NSLog(@"Free: %@",self.nombre);
}

@end
