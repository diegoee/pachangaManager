//
//  CompeticionCrearView.m
//  pm
//
//  Created by Diego Espínola Espigares on 8/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "CompeticionCrearView.h"
#import "CompeticionView.h"

@implementation CompeticionCrearView


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    self.pickerData = @[@"Fútbol7",@"Basket",@"Tenis",@"Futbito",@"Padel"];
    self.resultPickerData=self.pickerData[0];
    self.deporteImage.image=[UIImage imageNamed: @"soccer"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.resultPickerData = self.pickerData[row];
    //NSLog(@"Selected Row %d", row);
    switch(row)
    {
        case 0:
            self.deporteImage.image=[UIImage imageNamed: @"soccer"];
            break;
        case 1:
            self.deporteImage.image=[UIImage imageNamed: @"basket"];
            break;
        case 2:
            self.deporteImage.image=[UIImage imageNamed: @"tennis"];
            break;
        case 3:
            self.deporteImage.image=[UIImage imageNamed: @"soccer"];
            break;
        case 4:
            self.deporteImage.image=[UIImage imageNamed: @"tennis"];
            break;
    }
    
}


- (IBAction)addCompeticion:(UIButton *)save {
    CompeticionView *vc = [[CompeticionView alloc]init];
    NSString * nombre=self.nombreEdit.text;
    NSString * deporte=_resultPickerData;
    [vc saveCompeticionWithNombre:nombre deporte:deporte];
    //NSLog(@"CompeticionesCrearView: addCompeticion");
}



@end
