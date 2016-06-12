//
//  Calendario.m
//  pm
//
//  Created by Diego Espínola Espigares on 10/6/16.
//  Copyright © 2016 Diego Espínola. All rights reserved.
//

#import "Calendario.h"
#import "CalendarioTableView.h"

@implementation Calendario

NSDate * fechaSel;
NSMutableArray *fechasCalendarioPachangas;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    fechasCalendarioPachangas = [NSMutableArray array];
    
    self.calendar = [JTCalendar new];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    fechaSel = [NSDate date];
    
    [self reloadEvent];
    
    //NSLog(@"Calendario: viewDidLoad");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.calendar reloadData]; // Must be call in viewDidAppear
    
    [self reloadEvent];
    
    //NSLog(@"Calendario: viewDidAppear");
    
}

#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch
{
    [self.calendar setCurrentDate:[NSDate date]];
}

- (IBAction)didChangeModeTouch
{
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    //[self transitionExample];
}

#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"dd-MM-yyyy"];
    
    NSString *fechaCalendar = [formatter stringFromDate:date];
    NSString *fechaArray;
    for (NSDate *currentObject in fechasCalendarioPachangas) {
        fechaArray = [formatter stringFromDate:currentObject];
        if([fechaArray caseInsensitiveCompare:fechaCalendar] == NSOrderedSame){
            return true;
        }
    }
    //NSLog(@"calendarHaveEvent: %@", date);
    return false;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    fechaSel=date;
    //NSLog(@"Date: %@", fechaSel);
}

/*
#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 75.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}
*/

- (void)reloadEvent {
    //NSLog(@"reloadEvent");
    fechasCalendarioPachangas = [NSMutableArray array];
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Pachanga"];

    NSError *error = nil;
    NSArray *fetchedObjects = [[[DataManager sharedDataManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Calendario: Could not Load Entity Objects");
    }

    for (Pachanga *currentObject in fetchedObjects) {
        [fechasCalendarioPachangas addObject:currentObject.fecha];
    }
    /*
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"dd-MM-yyyy HH:mm"];
    for (NSDate *currentObject in fechasCalendarioPachangas) {
        NSString *fecha = [formatter stringFromDate:currentObject];
        NSLog(fecha);
    }*/
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"segueDetalleCalendario"])
    {
        NSMutableArray *pachangasDetalle = [NSMutableArray array];;
        //NSLog(@"Date: %@", fechaSel);
        CalendarioTableView *vc = [segue destinationViewController];
        
        //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //[formatter setDateFormat: @"dd-MM-yyyy HH:mm"];
        //NSString *fecha = [formatter stringFromDate:fechaSel];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pachanga" inManagedObjectContext:[[DataManager sharedDataManager] managedObjectContext]];
        [fetchRequest setEntity:entity];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [[[DataManager sharedDataManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat: @"dd-MM-yyyy"];
        
        NSString *fechaCalendar = [formatter stringFromDate:fechaSel];
        NSString *fechaArray;
                
        for (Pachanga *currentObject in fetchedObjects){
            fechaArray = [formatter stringFromDate:currentObject.fecha];
            if([fechaArray caseInsensitiveCompare:fechaCalendar] == NSOrderedSame){
                [pachangasDetalle addObject:currentObject];
            }
        }
        
        vc.pachangasArray = pachangasDetalle;
        //NSLog(@"Calendario: segueDetalleCalendario");
    }
}


@end
