//
//  CompeticionesViewController.m
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 19/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import "CompeticionesViewController.h"

@interface CompeticionesViewController ()

@end

@implementation CompeticionesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Cargando"
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CompeticionModelo"];
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
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    [alert dismissViewControllerAnimated:YES completion:^{}];
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

- (void) configureCell:(CompeticionesTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath { // Cogemos al jugador situado en un determinado indexPath
    CompeticionModelo *competicion = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Establecemos el texto del label de la celda con el nombre del jugador
    [cell.nombre setText:competicion.nombre];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    CompeticionesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"competicionesTableViewCell"
                                                        forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(void) saveJugadorWithNombre:(NSString*) name deporte:(NSString*)
sport {
    // Inicializamos el tipo de entidad
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Jugador"
                                              inManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
    // Inicializamos al jugador con el tipo de entidad
    // Y lo insertamos en el contexto
    CompeticionModelo *competicion =[[CompeticionModelo alloc] initWithEntity:entity insertIntoManagedObjectContext:
                       [[DataManager sharedDataManager] managedObjectContext]];
    competicion.nombre = name;
    competicion.deporte = sport;
    // Guardamos
    NSError *error = nil;
    // Asignamos el nombre
    // El correo
    // Y el teléfono
    if ([[[DataManager sharedDataManager] managedObjectContext] save:&error]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (error) {
        NSLog(@"Unable to save record.\n%@, %@", error, error.localizedDescription);
    } }

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
            [self configureCell:(CompeticionesTableViewCell *)[self.tableView
                                                cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break; }
    } }

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CompeticionModelo *comp = [self getJugadorWithIndexPath:indexPath];
        [comp.managedObjectContext deleteObject:comp];
        NSError *deleteError = nil;
        if (![[[DataManager sharedDataManager] managedObjectContext] save:&deleteError]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
            return;
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the
    } }

-(CompeticionModelo *) getJugadorWithIndexPath:(NSIndexPath*) indexPath {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CompeticionModelo" inManagedObjectContext:
                                   [[DataManager sharedDataManager] managedObjectContext]];
    [fetchRequest setEntity:entity];
    CompeticionModelo *comp = (CompeticionModelo *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    return comp;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)GuadarCompeticion:(UIStoryboardSegue *)segue {
    //[self.competiciones addObject:addCompeticion];
    //[self.tableView reloadData];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"segueDetalleCompeticion"])
    {
        /*
        UITableViewCell *cell = (UITableViewCell*) sender;
        // Get reference to the destination view controller
        MostrarCompeticionViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.datoNombre = [NSString stringWithString:cell.textLabel.text];
        vc.datoDeporte = [NSString stringWithString:cell.detailTextLabel.text];
        */
        
    }
    
    if ([[segue identifier] isEqualToString:@"segueAddCompeticion"])
    {
        /*
        CompeticionCrearViewController *v2 = [segue destinationViewController];
        v2.competicionNueva = [[Competicion alloc]init];
        NSLog(@"CompeticionesTableViewController: segueAddCompeticion");
         */
    }
    
}


@end
