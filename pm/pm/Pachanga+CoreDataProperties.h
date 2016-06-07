//
//  Pachanga+CoreDataProperties.h
//  pm
//
//  Created by Diego Espínola Espigares on 7/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Pachanga.h"

NS_ASSUME_NONNULL_BEGIN

@interface Pachanga (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *fecha;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *jugador;
@property (nullable, nonatomic, retain) NSManagedObject *competicion;

@end

@interface Pachanga (CoreDataGeneratedAccessors)

- (void)addJugadorObject:(NSManagedObject *)value;
- (void)removeJugadorObject:(NSManagedObject *)value;
- (void)addJugador:(NSSet<NSManagedObject *> *)values;
- (void)removeJugador:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
