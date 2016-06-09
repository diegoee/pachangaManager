//
//  PachangaCrearView.h
//  pm
//
//  Created by Diego Espínola Espigares on 9/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PachangaCrearView : UIViewController

@property (strong, nonatomic) NSDate *fecha;
@property (strong, nonatomic) NSString *nombre;

@property (weak, nonatomic) IBOutlet UITextField *nombreEdit;
@property (weak, nonatomic) IBOutlet UIDatePicker *fechaSel;

- (IBAction)addPachanga:(UIButton *)save;

@end