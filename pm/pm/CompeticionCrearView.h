//
//  CompeticionCrearView.h
//  pm
//
//  Created by Diego Espínola Espigares on 8/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CompeticionCrearView : UIViewController


@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) NSString *resultPickerData;

@property (weak, nonatomic) IBOutlet UITextField *nombreEdit;
@property (weak, nonatomic) IBOutlet UIPickerView *deporteSel;

@end
