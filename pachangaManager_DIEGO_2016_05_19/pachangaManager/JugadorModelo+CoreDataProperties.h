//
//  JugadorModelo+CoreDataProperties.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 19/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "JugadorModelo.h"

NS_ASSUME_NONNULL_BEGIN

@interface JugadorModelo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *nombre;
@property (nullable, nonatomic, retain) NSString *telefono;
@property (nullable, nonatomic, retain) NSSet<PachangaModelo *> *pachanga;
@property (nullable, nonatomic, retain) NSSet<CompeticionModelo *> *competicion;

@end

@interface JugadorModelo (CoreDataGeneratedAccessors)

- (void)addPachangaObject:(PachangaModelo *)value;
- (void)removePachangaObject:(PachangaModelo *)value;
- (void)addPachanga:(NSSet<PachangaModelo *> *)values;
- (void)removePachanga:(NSSet<PachangaModelo *> *)values;

- (void)addCompeticionObject:(CompeticionModelo *)value;
- (void)removeCompeticionObject:(CompeticionModelo *)value;
- (void)addCompeticion:(NSSet<CompeticionModelo *> *)values;
- (void)removeCompeticion:(NSSet<CompeticionModelo *> *)values;

@end

NS_ASSUME_NONNULL_END
