//
//  TableViewControllerCompeticion.m
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 7/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import "TableViewControllerCompeticion.h"

@interface TableViewControllerCompeticion ()

@end

@implementation TableViewControllerCompeticion

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.alert = [[UIAlertView alloc] initWithTitle:@"Cargando..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [self.alert show];
    self.array = [NSMutableArray arrayWithObjects:@"array1",@"array2", nil];
    [self.alert dismissWithClickedButtonIndex:0 animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaSubtitulo" forIndexPath:indexPath];
 
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"celdaSubtitulo"];
    }
    
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:(@"Detalle de la celda: %@"),[self.array objectAtIndex:indexPath.row] ];
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
            // Delete the row from the data source
        [self.array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    /*
    
    if ([[segue identifier] isEqualToString:@"segueDetalle"])
    {
        UITableViewCell *cell = (UITableViewCell*) sender;
        // Get reference to the destination view controller
        DetalleViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.datos = [NSString stringWithString:cell.textLabel.text];
    }
    
    if ([[segue identifier] isEqualToString:@"segueAdd"])
    {
        
        AddViewController *vc = [segue destinationViewController];
        // Pass any objects to the view controller here, like...
        vc.tableController = self;
    }
     */
    
}


@end