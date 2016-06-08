//
//  CompeticionCrearView.m
//  pm
//
//  Created by Diego Espínola Espigares on 8/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "CompeticionCrearView.h"

@implementation CompeticionCrearView


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pickerData = @[@"Fútbol", @"Basket", @"Tenis", @"Padel"];
    _resultPickerData=_pickerData[0];
    self.deporteSel.dataSource = self;
    self.deporteSel.delegate = self;
    NSLog(@"CrearCompeticionViewController: viewDidLoad");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _resultPickerData = _pickerData[row];
}

/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CompeticionesTableViewController *vc = [segue destinationViewController];
    self.competicionNueva.nombre=self.nombreEdit.text;
    self.competicionNueva.deporte=_resultPickerData;
    vc.addCompeticion = self.competicionNueva;
    NSLog(@"CrearCompeticionViewController: exit");
}
*/

@end
