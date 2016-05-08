//
//  AddViewController.h
//  pruebaTabla
//
//  Created by notimovil on 20/02/15.
//  Copyright (c) 2015 cursoiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompeticionesTableViewController.h"

@interface AddViewController : UIViewController

- (IBAction)addItem:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBoton;

@property (strong, nonatomic) CompeticionesTableViewController *tableController;

@end
