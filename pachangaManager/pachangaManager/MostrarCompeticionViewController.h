//
//  ViewControllerMostrarCompeticion.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 8/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MostrarCompeticionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelNombre;
@property (weak, nonatomic) IBOutlet UILabel *labelDeporte;
@property (weak, nonatomic) NSString *datoNombre;
@property (weak, nonatomic) NSString *datoDeporte;

@end
