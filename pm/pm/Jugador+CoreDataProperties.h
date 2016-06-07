//
//  Jugador+CoreDataProperties.h
//  pm
//
//  Created by Diego Espínola Espigares on 7/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Jugador.h"

NS_ASSUME_NONNULL_BEGIN

@interface Jugador (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *nombre;
@property (nullable, nonatomic, retain) NSString *telefono;
@property (nullable, nonatomic, retain) NSSet<Pachanga *> *pachanga;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *competicion;

@end

@interface Jugador (CoreDataGeneratedAccessors)

- (void)addPachangaObject:(Pachanga *)value;
- (void)removePachangaObject:(Pachanga *)value;
- (void)addPachanga:(NSSet<Pachanga *> *)values;
- (void)removePachanga:(NSSet<Pachanga *> *)values;

- (void)addCompeticionObject:(NSManagedObject *)value;
- (void)removeCompeticionObject:(NSManagedObject *)value;
- (void)addCompeticion:(NSSet<NSManagedObject *> *)values;
- (void)removeCompeticion:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
