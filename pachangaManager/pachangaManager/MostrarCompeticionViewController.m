//
//  ViewControllerMostrarCompeticion.m
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 8/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import "MostrarCompeticionViewController.h"
/*
@interface ViewControllerMostrarCompeticion ()

@end
*/

@implementation MostrarCompeticionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.labelNombre.text = [NSString stringWithFormat:(@"Nombre: %@"),self.datoNombre];
    self.labelDeporte.text = [NSString stringWithFormat:(@"Deporte: %@"),self.datoDeporte];
    NSLog(@"MostrarCompeticionViewController: viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
