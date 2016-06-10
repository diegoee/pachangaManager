//
//  CalendarioTableView.m
//  pm
//
//  Created by Diego Espínola Espigares on 10/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "CalendarioTableView.h"
#import "Pachanga.h"

@interface CalendarioTableView ()

@end

@implementation CalendarioTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (Pachanga *currentObject in self.pachangasArray){
        NSLog(@"Nombre = %@",currentObject.nombre);
    }
    //NSLog(@"CalendarioTableView: viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pachangasArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calendarioCell" forIndexPath:indexPath];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"calendarioCell"];
    }
    Pachanga *pachanga = [self.pachangasArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text  = [NSString stringWithFormat:@"Competición: %@", pachanga.id_competicion];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"dd-MM-yyyy HH:mm"];
    NSString *fecha = [formatter stringFromDate:pachanga.fecha];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", pachanga.nombre, fecha];
    return cell;
}

@end
