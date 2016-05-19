//
//  CompeticionesViewController.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 19/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "DataManager.h"
#import "JugadorModelo.h"

@interface CompeticionesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(IBAction)GuadarCompeticion:(UIStoryboardSegue *)segue;

//@property (strong,nonatomic) Competicion* addCompeticion;
//@property NSMutableArray *competiciones;


@end
