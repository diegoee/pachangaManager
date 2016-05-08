//
//  AddViewController.m
//  pruebaTabla
//
//  Created by notimovil on 20/02/15.
//  Copyright (c) 2015 cursoiOS. All rights reserved.
//

#import "AddViewController.h"
/*
@interface AddViewController ()

@end
*/
@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"AddViewController: viewDidLoad");
    
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

- (IBAction)addItem:(id)sender {
    [self.tableController.array addObject:@"Nuevo Elemento"];
    NSLog(@"AddViewController: addItem");
    
}

@end
