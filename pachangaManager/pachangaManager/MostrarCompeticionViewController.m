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
    self.labelNombre.text = self.datoNombre;
    self.labelDeporte.text = self.datoDeporte;
    NSLog(@"MostrarCompeticionViewController: viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
