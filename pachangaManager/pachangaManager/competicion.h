//
//  Competicion.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 5/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Competicion : NSObject

@property (strong,nonatomic) NSString * nombre;
@property (strong,nonatomic) NSString * deporte;

-(Competicion *) initWithName:(NSString*)name andSport:(NSString*)sport;

@end
