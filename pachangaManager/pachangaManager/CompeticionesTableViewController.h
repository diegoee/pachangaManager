//
//  TableViewControllerCompeticion.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 7/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompeticionModelo.h"

@interface CompeticionesTableViewController : UITableViewController

-(IBAction)GuadarCompeticion:(UIStoryboardSegue *)segue;

@property (strong,nonatomic) CompeticionModelo* addCompeticion;
@property NSMutableArray *competiciones;

@end
