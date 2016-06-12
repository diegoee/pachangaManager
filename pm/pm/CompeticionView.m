
//
//  ViewController.m
//  pm
//
//  Created by Diego Espínola Espigares on 7/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "CompeticionView.h"
#import "PachangaView.h"


@implementation CompeticionView

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    UIAlertController * view;
    view=   [UIAlertController alertControllerWithTitle:@"Pachanga Manager:" message:@"¡Bienvenido a la App!" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {
                             [view dismissViewControllerAnimated:YES completion:nil];
                         }];
    [view addAction:ok];
    [self presentViewController:view animated:YES completion:nil];
    */
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Competicion"];
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES]]];
    // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[[DataManager sharedDataManager] managedObjectContext] sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"CompeticionesView: Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }    
    
    //NSLog(@"CompeticionesView: viewDidLoad");
    
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
    
- (void) configureCell:(CompeticionCell *)cell atIndexPath:(NSIndexPath *)indexPath { // Cogemos al jugador situado en un determinado indexPath
    Competicion *competicion = [self.fetchedResultsController objectAtIndexPath:indexPath];
     // Establecemos el texto del label de la celda con el nombre del jugador
    [cell.nombre setText:competicion.nombre];
    [cell.deporte setText:competicion.deporte];
    
    if ([competicion.deporte isEqualToString:@"Fútbol7"]||[competicion.deporte isEqualToString:@"Futbito"]){
        cell.imageView.image=[UIImage imageNamed: @"soccer"];
    }
    if ([competicion.deporte isEqualToString:@"Tenis"]||[competicion.deporte isEqualToString:@"Padel"]){
        cell.imageView.image=[UIImage imageNamed: @"tennis"];
    }
    if ([competicion.deporte isEqualToString:@"Basket"]){
        cell.imageView.image=[UIImage imageNamed: @"basket"];
    }
    
    
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompeticionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"competicionCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
    
-(void) saveCompeticionWithNombre:(NSString*) nombre deporte:(NSString*)deporte {
    // Inicializamos el tipo de entidad
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Competicion"
                                              inManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
    // Inicializamos al jugador con el tipo de entidad
    // Y lo insertamos en el contexto
    Competicion *competicion =[[Competicion alloc] initWithEntity:entity insertIntoManagedObjectContext:
                       [[DataManager sharedDataManager] managedObjectContext]];
    competicion.nombre = nombre;
    competicion.deporte = deporte;
    // Guardamos
    NSError *error = nil;
    
    if ([[[DataManager sharedDataManager] managedObjectContext] save:&error]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (error) {
        NSLog(@"Unable to save record.\n%@, %@", error, error.localizedDescription);
    }
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
            [self configureCell:(CompeticionCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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
                                     message:@"¿Borrar Competición?"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 Competicion *comp = [self getCompeticionWithIndexPath:indexPath];
                                 [comp.managedObjectContext deleteObject:comp];
                                 [self clearPachangaAndJugador:comp.nombre deporte:comp.deporte ];
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

-(Competicion *) getCompeticionWithIndexPath:(NSIndexPath*) indexPath {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Competicion" inManagedObjectContext:
                                   [[DataManager sharedDataManager] managedObjectContext]];
    [fetchRequest setEntity:entity];
    Competicion *comp = (Competicion *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    return comp;
}


-(IBAction)unwindCompeticion:(UIStoryboardSegue *)segue {
    //NSLog(@"CompeticionesView: Unwind");
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"segueDetalleCompeticion"])
    {
        UITableViewCell *cell = (UITableViewCell*) sender;
        PachangaView *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.datoNombre = [NSString stringWithString:cell.textLabel.text];
        vc.datoDeporte = [NSString stringWithString:cell.detailTextLabel.text];
        
    }
}

- (void) clearPachangaAndJugador:(NSString*) nombre deporte:(NSString*)deporte {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pachanga" inManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSString *id_competicion = [NSString stringWithFormat:@"%@ -- %@", nombre , deporte];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_competicion == %@",id_competicion];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[[DataManager sharedDataManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Could not delete Entity Objects");
    }
    
    for (Pachanga *currentObject in fetchedObjects) {
        [[[DataManager sharedDataManager] managedObjectContext] deleteObject:currentObject];
    }
    
    entity = nil;
    entity = [NSEntityDescription entityForName:@"Jugador" inManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    predicate = nil;
    predicate = [NSPredicate predicateWithFormat:@"id_pachanga LIKE '*%1$@*'",id_competicion];
    [fetchRequest setPredicate:predicate];
    
    error = nil;
    fetchedObjects =nil;
    fetchedObjects = [[[DataManager sharedDataManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Could not delete Entity Objects");
    }
    
    for (Jugador *currentObject in fetchedObjects) {
        [[[DataManager sharedDataManager] managedObjectContext] deleteObject:currentObject];
    }
    
}



@end


