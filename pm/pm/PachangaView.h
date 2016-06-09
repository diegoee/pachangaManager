//
//  PachangaView.h
//  pm
//
//  Created by Diego Espínola Espigares on 9/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PachangaCell.h"
#import "DataManager.h"
#import "Competicion.h"
#import "Pachanga.h"
#import "Jugador.h"

@interface PachangaView: UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelNombre;
@property (strong, nonatomic) IBOutlet UILabel *labelDeporte;

@property (strong, nonatomic) NSString *datoNombre;
@property (strong, nonatomic) NSString *datoDeporte;


@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void) savePachangaWithNombre:(NSString*) nombre fecha:(NSDate*)fecha;



@end
