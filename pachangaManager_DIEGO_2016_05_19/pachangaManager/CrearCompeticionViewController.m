//
//  ViewControllerCrearCompeticion.m
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 8/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import "CrearCompeticionViewController.h"
#import "CompeticionesTableViewController.h"

@interface CrearCompeticionViewController ()

@end

@implementation CrearCompeticionViewController


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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CompeticionesTableViewController *vc = [segue destinationViewController];
    self.competicionNueva.nombre=self.nombreEdit.text;
    self.competicionNueva.deporte=_resultPickerData;
    vc.addCompeticion = self.competicionNueva;
    NSLog(@"CrearCompeticionViewController: exit");
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
