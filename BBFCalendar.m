//
//  BBFCalendar.m
//  PTCAL
//
//  Created by Peter Todd on 08/04/2012.
//  Copyright (c) 2012 GREENTOR Ltd. All rights reserved.
//

#import "BBFCalendar.h"
#import "BBFCalendarDayView.h"
#import "BBFCalendarMonthSelectView.h"

@implementation BBFCalendar

@synthesize month35Array;
@synthesize labelMonth;
@synthesize monthSelectView;
@synthesize weekStartDay; // Should be defined as Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
                          // This is the day the Calendar will start on (defaults to Sunday)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
   // NSLog(@"Frame width : %f",self.frame.size.width);
   // NSLog(@"Frame height : %f",self.frame.size.height);
   // NSLog(@"DEBUG drawRect BBFCalendar");
    
    // Add the day labels
    // Default start day of week to Monday if not already set
    if (weekStartDay == nil){
        weekStartDay = @"Sunday";
    }


    
    // Build a dynamic calendar from - ideally for a UIVIEW frame of 700 * 550 but should resize to any frame size
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    // Build the rectangle making space for a 2 pixel outline
    // Width is width of frame - 2 pixels
    // Heigth height of frame - 2 pixels
    
    CGRect outlineRectangle = CGRectMake(1,1,(self.frame.size.width - 2),(self.frame.size.height - 2));
    CGContextAddRect(context, outlineRectangle);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, outlineRectangle);
    
    // Create a header 10% of total height.  This will show the month and Back and Forward options
    CGRect headRectangle = CGRectMake(1,1,outlineRectangle.size.width,(outlineRectangle.size.height/10));
    CGContextAddRect(context, headRectangle);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, headRectangle);
    
    
    // Create a Day header line 5% total height
    CGRect dayRectangle = CGRectMake(1,headRectangle.size.height,outlineRectangle.size.width,(outlineRectangle.size.height/20));
    CGContextAddRect(context, dayRectangle);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextFillRect(context, dayRectangle);
  
    // Create a calendar content 85% total height
    CGRect calRectangle = CGRectMake(1,(headRectangle.size.height + dayRectangle.size.height),outlineRectangle.size.width,(outlineRectangle.size.height - headRectangle.size.height - dayRectangle.size.height));
    CGContextAddRect(context, calRectangle);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, calRectangle);
    
    // Create the day rectangles
    // Frame outlines built now we need to build the day grid - 7 * 5 grid
    
    // Cell size
    // Width = calRectangle width /  7
    // Height = calRectangle height / 5
    float dayCellWidth = calRectangle.size.width / 7;
    float dayCellHeight = calRectangle.size.height / 5;
    float gridTopLeft = (headRectangle.size.height);
    float gridStartLeft = 2;
      

    // Init the array of day title rectangles
   // day7Array = [[NSMutableArray alloc] init];  
    
    NSString *calendarDayString = weekStartDay;
    

    for(int i = 1;i<= 7;i++){
        CGRect dayNameRectangle = CGRectMake(gridStartLeft,gridTopLeft,dayCellWidth,dayRectangle.size.height);
        CGContextAddRect(context, dayNameRectangle);
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextFillRect(context, dayNameRectangle);
        gridStartLeft = gridStartLeft + dayCellWidth;
        // Add a reference to the most recent day subview to the day view array
        // We'll use this reference when setting the day number 
        // [day7Array addObject:dayNameRectangle];
        
        [self drawLabel:calendarDayString withFont:[UIFont fontWithName: @"MarkerFelt-Wide" size:14] inRect:dayNameRectangle];
        
        // Need to move to next day as move through the loop.  If first day is Thursday do get name of day 2.
        // Probably call code that draw day.
        calendarDayString = [self nextDay:calendarDayString];
           
    }
    
    // Reset the sizing
    gridTopLeft = (headRectangle.size.height + dayRectangle.size.height);
    gridStartLeft = 2;
    
    // Init the array of day views
    month35Array = [[NSMutableArray alloc] init];  
    
    // Add the day grid    
    for(int i = 1;i<= 35;i++){
        CGContextSetLineWidth(context, 0.5);
        CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGRect dayGridRectangle = CGRectMake(gridStartLeft,gridTopLeft,dayCellWidth,dayCellHeight);
        CGContextAddRect(context, dayGridRectangle);
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, dayGridRectangle);
        
        // Now adding the subview
        [self addSubview:[[BBFCalendarDayView alloc] initWithFrame:dayGridRectangle]];
        
        // Add a reference to the most recent day subview to the day view array
        // We'll use this reference when setting the day number 
        [month35Array addObject:(self.subviews.lastObject)];
        
        //Increment the corner of the next day cell and drop to next line if this is the 7th cell in the week line

         gridStartLeft = gridStartLeft + dayCellWidth;
  //      NSLog(@"Modulus %d", (i%7));
        if ((i%7) == 0){
            gridTopLeft = gridTopLeft + dayCellHeight;
            gridStartLeft = 2;
        }
    }
    
    // Add the header Month Select view and set its delegate
    monthSelectView =[[BBFCalendarMonthSelectView alloc] initWithFrame:headRectangle];
    [monthSelectView setDelegate:self];
    
    [self addSubview:monthSelectView];
    
    // Populate the calendar grid with todays data by default
    // TODO - set selected date as a property of BBFCalender and only use todays date as a default if this property is not populated
    // Dealing with the rotation issue?
    [self monthHasBeenChanged:[NSDate date] ];
    

  /*  
    //Set the month label
    labelMonth = [[UILabel alloc] initWithFrame: headRectangle];
   // [labelMonth setText: @"My Label"];
    [labelMonth setTextColor: [UIColor orangeColor]];
    [self addSubview: labelMonth];
   */
}

-(void) updateDayNbrs{
    BBFCalendarDayView *dayView =  (BBFCalendarDayView*) [month35Array objectAtIndex:2];
    dayView.dateLabel.text = @"99";
}


/*
- (CGRect) dayRectangle{
    // Create a header 10% of total height.  This will show the month and Back and Forward options
    CGRect dayRectangle = CGRectMake(1,1,(self.frame.size.width - 2),(self.frame.size.height - 2));
  
    return dayRectangle;
}

- (CGRect) rectForCellAtIndex:(int)index{
	
	int row = index / 7;
	int col = index % 7;
	
	return CGRectMake(col*46, row*44+6, 47, 45);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
*/
#pragma mark - Impliment the month changed delegate


- (void)monthHasBeenChanged:(NSDate *)newMonthDate{
    //Start at Monday
    //TODO - add an individual week start preference Sat/Sun/Mon
    /*
     If today is not Monday find the date of the previous Monday.
     Use this as the start date and update the date appropriately
     */
    
    //NOTES - This calendar is designed for a multi use application with individual user setting defined in Core Data.
    //The production app using the calendar will check week start preference Sat/Sun/Mon and update appropriately.
    //This functionality is not included in the version uploaded to GitHub - should be easy enough to implement if anyone 
    //needs this functionality.
    
    //NSLog(@"DEBUG - THE MONTH HAS CHANGED");
    // Get the NSDate for the first day of the month
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    int month = [[dateFormatter stringFromDate:newMonthDate] intValue];
    [dateFormatter setDateFormat:@"YYYY"];
    int year = [[dateFormatter stringFromDate:newMonthDate] intValue];
    NSDateComponents *dc = [[NSDateComponents alloc] init];
	[dc setDay:1];
    [dc setMonth:month];
    [dc setYear:year];
    [dc setHour:01];
    NSDate *firstDayOfMonthDate = [[NSCalendar currentCalendar]  dateFromComponents:dc];
    // Is this day same as defined start month day - if yes then start the calendar on that date.  Otherwise find first start day 
    // before month start. (i.e. working week might start on a Saturday and we want the first column in calendar to be Sat)
 
    [dateFormatter setDateFormat:@"cccc"];
    NSString *firstDayString = [dateFormatter stringFromDate:firstDayOfMonthDate];
    NSDate *startCalanderNbrDate = firstDayOfMonthDate;
    
     
    if ([firstDayString isEqualToString:weekStartDay]){
        // Month starts on a Monday so set start calendar date to start of Month - no processing required
        // NSLog(@"First date of Calendar:%@",startCalanderNbrDate);
    } else{
        //Find the first week start day prior to the month start and start from there
        /* See Apple notes on doing this if you just need either Sun or Mon
         I'm manually coding this to capture the crazy weeks worked by some people (working week could start on any day)
         */
        NSDateComponents *dc2 = [[NSDateComponents alloc] init];
        
        for(int i =1;i<=7;i++){
            [dc2 setDay:-i];
            startCalanderNbrDate = [[NSCalendar currentCalendar] dateByAddingComponents:dc2 toDate:firstDayOfMonthDate options:0];
           // NSLog(@"DEBUG 1 = %@",[dateFormatter stringFromDate:startCalanderNbrDate]);
           // NSLog(@"DEBUG 1a = %@",startCalanderNbrDate);
            if ([[dateFormatter stringFromDate:startCalanderNbrDate] isEqualToString:weekStartDay]){
                break;
            }
        }
    }
    
    

    
    
    // For each day view in the month35Array set the date based on the selected month
   
    
    [dateFormatter setDateFormat:@"dd"];
    NSDateComponents *dc3 = [[NSDateComponents alloc] init];

    for(int i = 0;i< month35Array.count;i++){
        [dc3 setDay:+1];
       // NSLog(@"Updating array view:%@",startCalanderNbrDate);
        BBFCalendarDayView *dayView =  (BBFCalendarDayView*) [month35Array objectAtIndex:i];            
        dayView.dateLabel.text =[NSString stringWithFormat:@"%d", [[dateFormatter stringFromDate:startCalanderNbrDate] intValue]];
        startCalanderNbrDate = [[NSCalendar currentCalendar] dateByAddingComponents:dc3 toDate:startCalanderNbrDate options:0];
    }
}

// Draw a UILABEL centered in a rectangle

- (void) drawLabel: (NSString*) myString withFont: (UIFont*) myFont inRect: (CGRect) contextRect {
    UILabel *theLabel = [[UILabel alloc] initWithFrame:contextRect];
    [theLabel setText:myString];
    [theLabel setFont:myFont];
    [theLabel sizeToFit];
    [theLabel setCenter:CGPointMake(CGRectGetMidX(contextRect),CGRectGetMidY(contextRect))];
    [self addSubview:theLabel];
}

- (NSString *)nextDay: (NSString*) currentDay{
    if ([currentDay isEqualToString:@"Monday"]){
        return @"Tuesday";
    }
    if ([currentDay isEqualToString:@"Tuesday"]){
        return @"Wednesday";
    }
    if ([currentDay isEqualToString:@"Wednesday"]){
        return @"Thursday";
    }
    if ([currentDay isEqualToString:@"Thursday"]){
        return @"Friday";
    }
    if ([currentDay isEqualToString:@"Friday"]){
        return @"Saturday";
    }
    if ([currentDay isEqualToString:@"Saturday"]){
        return @"Sunday";
    }
    if ([currentDay isEqualToString:@"Sunday"]){
        return @"Monday";
    }
    return @"UNDEFINED";
}



@end
