//
//  JugadorView.h
//  pm
//
//  Created by Diego Espínola Espigares on 9/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JugadorCell.h"
#import "DataManager.h"
#import "Jugador.h"

@interface JugadorView: UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelNombre;
@property (strong, nonatomic) IBOutlet UILabel *labelFecha;

@property (strong, nonatomic) NSString *datoNombre;
@property (strong, nonatomic) NSString *datoFecha;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
