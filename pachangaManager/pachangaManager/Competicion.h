//
//  Jugador.h
//  pruebaWeakStrong
//
//  Created by admin on 12/2/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Competicion : NSObject

@property (strong,nonatomic) NSString * nombre;
@property (strong,nonatomic) NSString * deporte;

-(Competicion *) initWithName:(NSString*)name andSport:(NSString*)sport;

@end
