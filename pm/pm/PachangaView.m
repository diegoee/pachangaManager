//
//  PachangaView.m
//  pm
//
//  Created by Diego Espínola Espigares on 9/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "PachangaView.h"
#import "CompeticionView.h"
#import "JugadorView.h"

@implementation PachangaView

NSString *id_competicion;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.labelNombre.text = [NSString stringWithFormat:self.datoNombre];
    self.labelDeporte.text = [NSString stringWithFormat:self.datoDeporte];    
    
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Pachanga"];
    id_competicion = [NSString stringWithFormat:@"%@ -- %@", self.datoNombre , self.datoDeporte];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_competicion == %@",id_competicion];
    
    //[fetchRequest setPredicate:predicate];
    
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES]]];
    // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager sharedDataManager]managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    //NSLog(@"PachangaView: viewDidLoad");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void) configureCell:(PachangaCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Pachanga *pachanga = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.nombre setText:pachanga.nombre];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"dd-MM-yyyy HH:mm"];
     NSString *fecha = [formatter stringFromDate:pachanga.fecha];
    
    [cell.fecha setText:fecha];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Pachanga *cell = [tableView dequeueReusableCellWithIdentifier:@"pachangaCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(void) savePachangaWithNombre:(NSString*) nombre fecha:(NSDate*)fecha {
    // Inicializamos el tipo de entidad
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pachanga"
                                              inManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
    // Inicializamos al jugador con el tipo de entidad
    // Y lo insertamos en el contexto
    Pachanga *pachanga =[[Pachanga alloc] initWithEntity:entity insertIntoManagedObjectContext:
                               [[DataManager sharedDataManager] managedObjectContext]];
    pachanga.nombre = nombre;
    pachanga.fecha = fecha;
    pachanga.id_competicion = id_competicion;
    //NSLog(@"ID_COMPETICION = %@",pachanga.id_competicion);
    
    // Guardamos
    NSError *error = nil;
    
    if ([[[DataManager sharedDataManager] managedObjectContext] save:&error]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (error) {
        NSLog(@"Unable to save record.\n%@, %@", error, error.localizedDescription);
    }
    //NSLog(@"PachangaView: savePachangaWithNombre");
     
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}



- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:(PachangaCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break; }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Confirmar:"
                                     message:@"¿Borrar Pachanga?"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 Pachanga *pac = [self getPachangaWithIndexPath:indexPath];
                                 [pac.managedObjectContext deleteObject:pac];
                                 
                                 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                 [formatter setDateFormat: @"dd-MM-yyyy HH:mm"];
                                 NSString *fechaString = [formatter stringFromDate:pac.fecha];
                                 
                                 [self clearJugador:pac.nombre fecha:fechaString ];
                                                                  
                                 NSError *deleteError = nil;
                                 if (![[[DataManager sharedDataManager] managedObjectContext] save:&deleteError]) {
                                     NSLog(@"Unable to save managed object context.");
                                     NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
                                     return;
                                 }
                                 
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        [view addAction:ok];
        [view addAction:cancel];
        [self presentViewController:view animated:YES completion:nil];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the
    }
    
}

-(Pachanga *) getPachangaWithIndexPath:(NSIndexPath*) indexPath {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pachanga" inManagedObjectContext:
                                   [[DataManager sharedDataManager] managedObjectContext]];
    [fetchRequest setEntity:entity];
    Pachanga *pach = (Pachanga *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    return pach;
    
}


-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    //NSLog(@"CompeticionesView: prepareForUnwind");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"segueDetallePachanga"])
    {
        UITableViewCell *cell = (UITableViewCell*) sender;
        JugadorView *vc = [segue destinationViewController];
        vc.datoPachanga = [NSString stringWithString:cell.textLabel.text];
        vc.datoFecha  = [NSString stringWithString:cell.detailTextLabel.text];        
        vc.datoCompeticion = self.labelNombre.text;
        vc.datoDeporte  = self.labelDeporte.text;
        //NSLog(@"PachangaView: segueDetallePachanga");
    }
}

- (void)clearJugador:(NSString*)nombre fecha:(NSString*)fecha {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Jugador" inManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    
    NSString *id_pachanga = [NSString stringWithFormat:@"%@ -- %@ -- %@",id_competicion,nombre,fecha];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_pachanga == %@",id_pachanga];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[[DataManager sharedDataManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Could not delete Entity Objects");
    }
    
    for (Pachanga *currentObject in fetchedObjects) {
        [[[DataManager sharedDataManager] managedObjectContext] deleteObject:currentObject];
    }
    
}


@end
