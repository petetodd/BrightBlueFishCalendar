//
//  BBFCalendarMonthSelectView.h
//  PTCAL
//
//  Created by Peter Todd on 10/04/2012.
//  Copyright (c) 2012 GREENTOR Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


// Define the protocol for the delegate
@protocol BBFCalendarMonthDelegate <NSObject>

- (void)monthHasBeenChanged:(NSDate *)newMonthDate;

@end 

@interface BBFCalendarMonthSelectView : UIView{
    int selectedDateNbr;
}
@property (strong,nonatomic) UILabel *labelMonth;
@property (strong,nonatomic) UIButton *leftButton;
@property (strong,nonatomic) UIButton *rightButton;
@property (strong,nonatomic) NSDate *selectedDate;
@property (assign, nonatomic)  int selectedDateNbr;

//Delegate 
@property (strong, nonatomic) id <BBFCalendarMonthDelegate> delegate;



@end
