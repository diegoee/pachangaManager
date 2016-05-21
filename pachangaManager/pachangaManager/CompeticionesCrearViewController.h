//
//  CompeticionesCrearViewController.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 20/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompeticionModelo.h"

@interface CompeticionesCrearViewController : UIViewController

@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) NSString *resultPickerData;
@property (weak, nonatomic) IBOutlet UITextField *nombreEdit;
@property (weak, nonatomic) IBOutlet UIPickerView *deporteSel;

@end
