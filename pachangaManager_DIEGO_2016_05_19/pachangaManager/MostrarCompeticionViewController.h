//
//  ViewControllerMostrarCompeticion.h
//  pachangaManager
//
//  Created by Diego Espínola Espigares on 8/5/16.
//  Copyright © 2016 Juan Angel y Diego Espínola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MostrarCompeticionViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelNombre;
@property (strong, nonatomic) IBOutlet UILabel *labelDeporte;
@property (strong, nonatomic) NSString *datoNombre;
@property (strong, nonatomic) NSString *datoDeporte;

@end
