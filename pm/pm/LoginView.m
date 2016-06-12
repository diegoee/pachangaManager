//
//  LoginView.m
//  pm
//
//  Created by Diego Espínola Espigares on 11/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"LoginView: viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([self.login.text isEqualToString:@"admin"]&&[self.pass.text isEqualToString:@"pass"])
    {
        return true;
    }
    else{
        UIAlertController * view;
        view=   [UIAlertController alertControllerWithTitle:@"Pachanga Manager:" message:@"Error de Usuario o Contraseña" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
        return false;
    }
    return true;
}


@end
