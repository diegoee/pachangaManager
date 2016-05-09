//
//  TableViewControllerCompeticion.m
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 7/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import "CompeticionesTableViewController.h"
#import "MostrarCompeticionViewController.h"
#import "CrearCompeticionViewController.h"
#import "Competicion.h"
/*
@interface TableViewControllerCompeticion ()

@end
*/

@implementation CompeticionesTableViewController

@synthesize addCompeticion;

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.alert = [[UIAlertView alloc] initWithTitle:@"Cargando..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Cargando"
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    //[self presentViewController:alert animated:YES completion:nil];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    self.competiciones = [[NSMutableArray alloc] init];
    //[self.alert dismissWithClickedButtonIndex:0 animated:NO];
    //[self presentViewController:alert animated:NO completion:nil];
    [alert dismissViewControllerAnimated:YES completion:^{}];
    NSLog(@"CompeticionesTableViewController: viewDidLoad");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.competiciones count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaSubtitulo" forIndexPath:indexPath];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"celdaSubtitulo"];
    }
    Competicion *competicion = [self.competiciones objectAtIndex:indexPath.row];
    cell.textLabel.text = competicion.nombre;
    cell.detailTextLabel.text = competicion.deporte;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
                                 [self.competiciones removeObjectAtIndex:indexPath.row];
                                 [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
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
    }
}

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



-(IBAction)GuadarCompeticion:(UIStoryboardSegue *)segue {
    [self.competiciones addObject:addCompeticion];
    [self.tableView reloadData];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"segueDetalleCompeticion"])
    {
        UITableViewCell *cell = (UITableViewCell*) sender;
        // Get reference to the destination view controller
        MostrarCompeticionViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.datoNombre = [NSString stringWithString:cell.textLabel.text];
        vc.datoDeporte = [NSString stringWithString:cell.detailTextLabel.text];
        
    }
    
    if ([[segue identifier] isEqualToString:@"segueAddCompeticion"])
    {
        CrearCompeticionViewController *v2 = [segue destinationViewController];
        v2.competicionNueva = [[Competicion alloc]init];
        NSLog(@"CompeticionesTableViewController: segueAddCompeticion");
    }
 
}







@end
