//
//  Competicion+CoreDataProperties.h
//  pm
//
//  Created by Diego Espínola Espigares on 12/6/16.
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

@end

NS_ASSUME_NONNULL_END
