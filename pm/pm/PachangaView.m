//
//  PachangaView.m
//  pm
//
//  Created by Diego Espínola Espigares on 9/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "PachangaView.h"

@implementation PachangaView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Cargando"
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    //[self presentViewController:alert animated:YES completion:nil];
        
    self.labelNombre.text = [NSString stringWithFormat:self.datoNombre];
    self.labelDeporte.text = [NSString stringWithFormat:self.datoDeporte];
    
    
    
    [alert dismissViewControllerAnimated:YES completion:^{}];
    NSLog(@"PachangaView: viewDidLoad");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
