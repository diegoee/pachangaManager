//
//  Competicion+CoreDataProperties.h
//  pm
//
//  Created by Diego Espínola Espigares on 7/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Competicion.h"

NS_ASSUME_NONNULL_BEGIN

@interface Competicion (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *deporte;
@property (nullable, nonatomic, retain) NSString *nombre;
@property (nullable, nonatomic, retain) Pachanga *pachanga;
@property (nullable, nonatomic, retain) NSSet<Jugador *> *jugador;

@end

@interface Competicion (CoreDataGeneratedAccessors)

- (void)addJugadorObject:(Jugador *)value;
- (void)removeJugadorObject:(Jugador *)value;
- (void)addJugador:(NSSet<Jugador *> *)values;
- (void)removeJugador:(NSSet<Jugador *> *)values;

@end

NS_ASSUME_NONNULL_END
