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
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_pachanga == %@",id_pachanga];
    //[fetchRequest setPredicate:predicate];
    
    
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES]]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[DataManager sharedDataManager] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    [self.fetchedResultsController setDelegate:self];
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    NSLog(@"JugadorView: viewDidLoad");
    
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

-(void) saveJugadorWithNombre:(NSString*) nombre telefono:(NSString*)telefono{
    // Inicializamos el tipo de entidad
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Jugador" inManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
    Jugador *jug =[[Pachanga alloc] initWithEntity:entity insertIntoManagedObjectContext: [[DataManager sharedDataManager] managedObjectContext]];
    jug.nombre = nombre;
    jug.telefono = telefono;
    jug.id_pachanga = id_pachanga;
    // Guardamos
    NSError *error = nil;
    
    if ([[[DataManager sharedDataManager] managedObjectContext] save:&error]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (error) {
        NSLog(@"Unable to save record.\n%@, %@", error, error.localizedDescription);
    }
    //NSLog(@"JugadorView: saveJugadorWithNombre");
    
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
                                     message:@"¿Borrar Jugador?"
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

// Save jugador y adressbook
- (IBAction)addJugador:(UIButton *)sender {
    [self saveJugadorWithNombre:@"Rodolfo" telefono:@"606505404"];
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc]
                                                  init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef) person {
    NSString *name = [self getNombreWithPerson:(ABRecordRef) person];
    NSString *phone = [self getTelefonoWithPerson:(ABRecordRef) person];
    NSString *mail = [self getCorreoWithPerson:(ABRecordRef) person];
    [self saveJugadorWithNombre:name telefono:phone];
    return NO;
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
                         didSelectPerson:(ABRecordRef)person {
    [self peoplePickerNavigationController:peoplePicker
        shouldContinueAfterSelectingPerson:person];
}

-(NSString*) getCorreoWithPerson:(ABRecordRef) person {
    NSString *correo = @"[None]";
    ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
    if (ABMultiValueGetCount(email) > 0) {
        CFStringRef emailField = ABMultiValueCopyValueAtIndex(email, 0);
        correo = (__bridge_transfer NSString *)emailField;
    }
    CFRelease(email);
    return correo;
}

- (NSString*) getTelefonoWithPerson:(ABRecordRef) person {
    NSString* phone = @"[None]";
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0)
        phone = (__bridge_transfer NSString*) ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    CFRelease(phoneNumbers);
    return phone;
}

- (NSString*) getNombreWithPerson:(ABRecordRef) person {
    NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(person,
                                                                          kABPersonFirstNameProperty);
    NSString *middleName = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                          kABPersonMiddleNameProperty);
    NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(person,
                                                                         kABPersonLastNameProperty);
    return [NSString stringWithFormat:@"%@%@%@",(firstName?firstName:@""),(middleName?[NSString
                                                                                       stringWithFormat:@" %@", middleName]:@""),(lastName?[NSString stringWithFormat:@" %@",
                                                                                                                                            lastName]:@"")];
}


@end
