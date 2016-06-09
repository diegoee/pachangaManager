//
//  JugadorView.m
//  pm
//
//  Created by Diego Espínola Espigares on 9/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "JugadorView.h"
#import "PachangaView.h"

NSString *id_pachanga;

@implementation JugadorView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.labelPachanga.text = [NSString stringWithFormat:self.datoPachanga];
    self.labelFecha.text = [NSString stringWithFormat:self.datoFecha];
    self.labelCompeticion.text = [NSString stringWithFormat:self.datoCompeticion];
    self.labelDeporte.text = [NSString stringWithFormat:self.datoDeporte];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Jugador"];
    
    id_pachanga = [NSString stringWithFormat:@"%@ -- %@ -- %@ -- %@",self.datoCompeticion,self.datoDeporte,self.datoPachanga,self.datoFecha];
    //NSLog(@"%@", id_pachanga);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_pachanga == %@",id_pachanga];
    [fetchRequest setPredicate:predicate];
    
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES]]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager sharedDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    [self.fetchedResultsController setDelegate:self];
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    //NSLog(@"JugadorView: viewDidLoad");
    
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

- (void) configureCell:(JugadorCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Jugador *jug = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.nombre setText:jug.nombre];
    [cell.telefono setText:jug.telefono];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Pachanga *cell = [tableView dequeueReusableCellWithIdentifier:@"jugadorCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(void) saveJugadorWithNombre:(NSString*) nombre telefono:(NSDate*)telefono{
    // Inicializamos el tipo de entidad
    
    //NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pachanga" inManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
    // Inicializamos al jugador con el tipo de entidad
    // Y lo insertamos en el contexto
    //Pachanga *pachanga =[[Pachanga alloc] initWithEntity:entity insertIntoManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
    //pachanga.nombre = nombre;
    //pachanga.fecha = fecha;
    // Guardamos
    //NSError *error = nil;
    
    //if ([[[DataManager sharedDataManager] managedObjectContext] save:&error]) {
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //} else if (error) {
    //    NSLog(@"Unable to save record.\n%@, %@", error, error.localizedDescription);
    //}
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
            [self configureCell:(JugadorCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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
                                 
                                 Jugador *jug = [self getJugadorWithIndexPath:indexPath];
                                 [jug.managedObjectContext deleteObject:jug];
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

-(Pachanga *) getJugadorWithIndexPath:(NSIndexPath*) indexPath {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Jugador" inManagedObjectContext:
                                   [[DataManager sharedDataManager] managedObjectContext]];
    [fetchRequest setEntity:entity];
    Pachanga *pach = (Pachanga *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    return pach;
    
}


-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    //NSLog(@"CompeticionesView: prepareForUnwind");
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}


@end
