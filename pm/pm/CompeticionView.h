//
//  CompeticionView.h
//  pm
//
//  Created by Diego Espínola Espigares on 7/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompeticionCell.h"
#import "DataManager.h"
#import "Competicion.h"
#import "Pachanga.h"
#import "Jugador.h"

@interface CompeticionView : UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void) saveCompeticionWithNombre:(NSString*) nombre deporte:(NSString*)deporte;
-(void) clearPachangaAndJugador:(NSString*) nombre deporte:(NSString*)deporte;

@end
