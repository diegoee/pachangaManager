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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Jugador"];
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
    NSLog(@"CompeticionesTableViewController: viewDidLoad");
    
    
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
    [cell.deporte setText:competicion.deporte];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    CompeticionesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jugadorCell"
                                                        forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(void) saveJugadorWithNombre:(NSString*) name correo:(NSString*)correo telefono:(NSString*)
phone {
    // Inicializamos el tipo de entidad
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Jugador"
                                              inManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
    // Inicializamos al jugador con el tipo de entidad
    // Y lo insertamos en el contexto
    Jugador *jugador =[[Jugador alloc] initWithEntity:entity insertIntoManagedObjectContext:
                       [[DataManager sharedDataManager] managedObjectContext]];
    jugador.nombre = name;
    jugador.correo = correo;
    jugador.telefono = phone;
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
            [self configureCell:(JugadorCell *)[self.tableView
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
        Jugador *person = [self getJugadorWithIndexPath:indexPath];
        [person.managedObjectContext deleteObject:person];
        NSError *deleteError = nil;
        if (![[[DataManager sharedDataManager] managedObjectContext] save:&deleteError]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
            return;
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the
    } }

-(Jugador*) getJugadorWithIndexPath:(NSIndexPath*) indexPath {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Jugador" inManagedObjectContext:
                                   [[DataManager sharedDataManager] managedObjectContext]];
    [fetchRequest setEntity:entity];
    Jugador *person = (Jugador *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    return person;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef) person {
    NSString *name = [self getNombreWithPerson:(ABRecordRef) person];
    NSString *phone = [self getTelefonoWithPerson:(ABRecordRef) person];
    NSString *mail = [self getCorreoWithPerson:(ABRecordRef) person];
    [self saveJugadorWithNombre:name correo:mail telefono:phone];
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

- (IBAction)addJugador:(UIButton *)sender {
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc]
                                                  init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

@end
