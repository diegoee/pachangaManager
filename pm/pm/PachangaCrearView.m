//
//  PachangaCrearView.m
//  pm
//
//  Created by Diego Espínola Espigares on 9/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "PachangaCrearView.h"

@implementation PachangaCrearView


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"segueDetallePachangaMapa"])
    {
        PachangaCrearMapaView *vc = [segue destinationViewController];
        vc.nombre = self.nombreEdit.text;
        vc.fecha = self.fechaSel.date;
        //NSLog(@"PachangaCrearView: %@ - %@", vc.nombre, vc.fecha);
    }
}

@end
