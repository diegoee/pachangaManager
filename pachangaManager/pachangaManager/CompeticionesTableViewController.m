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
    self.alert = [[UIAlertView alloc] initWithTitle:@"Cargando..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    self.competiciones = [[NSMutableArray alloc] init];
    [self.alert dismissWithClickedButtonIndex:0 animated:NO];
    self.tempIndexTable= [[NSIndexPath alloc] init];;
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmar:" message:@"¿Borrar Competición?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [alert show];
        self.tempIndexTable=indexPath;
        //NSLog([NSString stringWithFormat:@"Table Competicion Index:%d", self.tempIndexTable]);
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    
    NSLog([NSString stringWithFormat:@"buttonIndex:%d", buttonIndex]);

    if (buttonIndex == 0) {
        if ([self.competiciones count] == 0) {
        }else{
            //NSLog(@"IN");
            [self.competiciones removeObjectAtIndex:self.tempIndexTable.row];
            [self.tableView deleteRowsAtIndexPaths:@[self.tempIndexTable] withRowAnimation:UITableViewRowAnimationFade];
        }
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
