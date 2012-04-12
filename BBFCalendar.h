//
//  BBFCalendar.h
//  PTCAL
//
//  Created by Peter Todd on 08/04/2012.
//  Copyright (c) 2012 GREENTOR Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBFCalendarMonthSelectView.h"

@interface BBFCalendar : UIView <BBFCalendarMonthDelegate>

@property (strong, nonatomic) NSMutableArray *month35Array; 

@property (strong, nonatomic) UILabel *labelMonth; 
@property (strong, nonatomic) BBFCalendarMonthSelectView *monthSelectView;

@property (strong, nonatomic) NSString *weekStartDay;



@end
