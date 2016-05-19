//
//  CompeticionModelo+CoreDataProperties.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 19/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CompeticionModelo.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompeticionModelo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *nombre;
@property (nullable, nonatomic, retain) NSString *deporte;
@property (nullable, nonatomic, retain) NSSet<PachangaModelo *> *pachanga;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *jugador;

@end

@interface CompeticionModelo (CoreDataGeneratedAccessors)

- (void)addPachangaObject:(PachangaModelo *)value;
- (void)removePachangaObject:(PachangaModelo *)value;
- (void)addPachanga:(NSSet<PachangaModelo *> *)values;
- (void)removePachanga:(NSSet<PachangaModelo *> *)values;

- (void)addJugadorObject:(NSManagedObject *)value;
- (void)removeJugadorObject:(NSManagedObject *)value;
- (void)addJugador:(NSSet<NSManagedObject *> *)values;
- (void)removeJugador:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
