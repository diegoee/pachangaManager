//
//  JugadoresViewController.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 12/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JugadoresTableViewCell.h"
#import <AddressBookUI/AddressBookUI.h>
#import "DataManager.h"
#import "Jugador.h"

@interface JugadoresViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

- (IBAction)addJugador:(UIButton *)sender;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
