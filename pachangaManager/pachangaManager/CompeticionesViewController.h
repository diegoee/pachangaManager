//
//  CompeticionesViewController.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 19/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompeticionesTableViewCell.h"
#import "DataManager.h"
#import "CompeticionModelo.h"

@interface CompeticionesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

-(IBAction)GuadarCompeticion:(UIStoryboardSegue *)segue;
-(void)saveCompeticionWithNombre:(NSString*) name deporte:(NSString*)sport;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
