//
//  BBFCalendarMonthSelectView.m
//  PTCAL
//
//  Created by Peter Todd on 10/04/2012.
//  Copyright (c) 2012 GREENTOR Ltd. All rights reserved.
//

#import "BBFCalendarMonthSelectView.h"

@implementation BBFCalendarMonthSelectView
@synthesize labelMonth;
@synthesize leftButton;
@synthesize rightButton;
@synthesize selectedDate;
@synthesize selectedDateNbr;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // NSLog(@"HEADER BEING BUILD");
        // Default month to todays month 
        // TODO Check if month has already been set in the view controller - if so use that value otherwise default to today
        // (Necessary as the rotate refesh from the controller would otherwise reset the month)
        
        
        // Initialization code
        //NSLog(@"DEBUG creating day view");
        self.backgroundColor=[UIColor clearColor];
        
        
        // Build the rectangle in the center of the frame to hold the month name
        // 80% as high as frame and 50% as wide centered
        CGRect labelFrame = CGRectMake((self.frame.size.width / 4),(self.frame.size.height / 10),(self.frame.size.width / 2), (self.frame.size.height * .8));
        self.labelMonth = [[UILabel alloc] initWithFrame:labelFrame];
        self.labelMonth.backgroundColor = [UIColor lightGrayColor];
        //Default month to todays month 
        // TODO Check if month has already been set in the view controller - if so use that value otherwise default to today
        // (Necessary as the rotate refesh would otherwise reset the month)
       
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

        
        [dateFormatter setDateFormat:@"MM"];
        selectedDateNbr = [[dateFormatter stringFromDate:[NSDate date]] intValue];
        selectedDate = [NSDate date];
                
        
        [dateFormatter setDateFormat:@"MMMM"];
        NSString *thisMonth  = [dateFormatter stringFromDate:[NSDate date]];
        self.labelMonth.text = thisMonth;
        
        self.labelMonth.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.labelMonth];
        [self bringSubviewToFront:self.labelMonth];
        
        // Build the left Previous Month button
        CGRect leftButtonFrame = CGRectMake(5,(self.frame.size.height / 10),(self.frame.size.width / 10), (self.frame.size.height * .8));
        leftButton = [[UIButton alloc] initWithFrame:leftButtonFrame];
        [leftButton addTarget:self action:@selector(prevMonth) forControlEvents:UIControlEventTouchDown];
        self.leftButton.backgroundColor = [UIColor lightGrayColor];
        [self.leftButton setTitle:@"PREV" forState:UIControlStateNormal];
        [self addSubview:self.leftButton];
        [self bringSubviewToFront:self.leftButton];
        
        // Build the right Next Month button
        CGRect rightButtonFrame = CGRectMake((self.frame.size.width - 5 - (self.frame.size.width / 10)) ,(self.frame.size.height / 10),(self.frame.size.width / 10), (self.frame.size.height * .8));
        rightButton = [[UIButton alloc] initWithFrame:rightButtonFrame];
        [self.rightButton setTitle:@"NEXT" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchDown];
        self.rightButton.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.rightButton];
        [self bringSubviewToFront:self.rightButton];


    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)prevMonth{
    // Want to calculate the previous month - we do this as a date so we can do calculations around date
    // and year
    // NSLog(@"Previous Month");
    NSDate *prevDateMonth = [NSDate date];
	NSDateComponents *dc = [[NSDateComponents alloc] init];
	[dc setMonth:-1];
	prevDateMonth = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:selectedDate options:0];
    selectedDate = prevDateMonth; //
    selectedDateNbr = (selectedDateNbr - 1);
    // Update the displayed month
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM"];
    NSString *thisMonth  = [dateFormatter stringFromDate:selectedDate];
    self.labelMonth.text = thisMonth;
    
    // Notify delegate of Month change
    [self.delegate monthHasBeenChanged:selectedDate ];
    
}

-(void)nextMonth{    
    // Want to calculate the next month - we do this as a date so we can do calculations around date
    // and year
    // NSLog(@"Next Month");
    NSDate *prevDateMonth = [NSDate date];
	NSDateComponents *dc = [[NSDateComponents alloc] init];
	[dc setMonth:+1];
	prevDateMonth = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:selectedDate options:0];
    selectedDate = prevDateMonth; //
    selectedDateNbr = (selectedDateNbr + 1);
    // Update the displayed month
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM"];
    NSString *thisMonth  = [dateFormatter stringFromDate:selectedDate];
    self.labelMonth.text = thisMonth;
    
    // Notify delegate of Month change
    [self.delegate monthHasBeenChanged:selectedDate ];

}


@end
