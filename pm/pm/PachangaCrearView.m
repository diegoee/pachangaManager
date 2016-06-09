//
//  PachangaCrearView.m
//  pm
//
//  Created by Diego Espínola Espigares on 9/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "PachangaCrearView.h"
#import "PachangaView.h"

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

- (IBAction)addPachanga:(UIButton *)save {
    NSLog(@"%@",_fechaSel.date);
    PachangaView *vc = [[PachangaView alloc]init];
    [vc savePachangaWithNombre:self.nombreEdit.text fecha:_fechaSel.date];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
