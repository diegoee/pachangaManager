
//
//  ViewController.m
//  pm
//
//  Created by Diego Espínola Espigares on 7/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "CompeticionView.h"


@implementation CompeticionView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [super viewDidLoad];
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
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
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
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Competicion *cell = [tableView dequeueReusableCellWithIdentifier:@"competicionCell" forIndexPath:indexPath];
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
    } }

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


- (IBAction)addCompeticion:(UIButton *)sender {
    [self saveCompeticionWithNombre:@"hacendado" deporte:@"tenis"];
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
        Competicion *comp = [self getCompeticionWithIndexPath:indexPath];
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

-(Jugador*) getCompeticionWithIndexPath:(NSIndexPath*) indexPath {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Competicion" inManagedObjectContext:
                                   [[DataManager sharedDataManager] managedObjectContext]];
    [fetchRequest setEntity:entity];
    Competicion *comp = (Competicion *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    return comp;
}


@end


