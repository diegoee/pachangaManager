//
//  Jugador+CoreDataProperties.h
//  pm
//
//  Created by Diego Espínola Espigares on 9/6/16.
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
@property (nullable, nonatomic, retain) NSSet<Competicion *> *competicion;
@property (nullable, nonatomic, retain) NSSet<Pachanga *> *pachanga;

@end

@interface Jugador (CoreDataGeneratedAccessors)

- (void)addCompeticionObject:(Competicion *)value;
- (void)removeCompeticionObject:(Competicion *)value;
- (void)addCompeticion:(NSSet<Competicion *> *)values;
- (void)removeCompeticion:(NSSet<Competicion *> *)values;

- (void)addPachangaObject:(Pachanga *)value;
- (void)removePachangaObject:(Pachanga *)value;
- (void)addPachanga:(NSSet<Pachanga *> *)values;
- (void)removePachanga:(NSSet<Pachanga *> *)values;

@end

NS_ASSUME_NONNULL_END
