//
//  PachangaModelo+CoreDataProperties.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 19/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PachangaModelo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PachangaModelo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *fecha;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *jugador;
@property (nullable, nonatomic, retain) NSManagedObject *competcion;

@end

@interface PachangaModelo (CoreDataGeneratedAccessors)

- (void)addJugadorObject:(NSManagedObject *)value;
- (void)removeJugadorObject:(NSManagedObject *)value;
- (void)addJugador:(NSSet<NSManagedObject *> *)values;
- (void)removeJugador:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
