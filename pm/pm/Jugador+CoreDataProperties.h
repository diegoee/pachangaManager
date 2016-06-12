//
//  Jugador+CoreDataProperties.h
//  pm
//
//  Created by Diego Espínola Espigares on 12/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Jugador.h"

NS_ASSUME_NONNULL_BEGIN

@interface Jugador (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id_pachanga;
@property (nullable, nonatomic, retain) NSString *nombre;
@property (nullable, nonatomic, retain) NSString *telefono;

@end

NS_ASSUME_NONNULL_END
