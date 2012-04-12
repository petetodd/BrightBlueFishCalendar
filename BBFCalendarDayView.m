//
//  BBFCalendarDayView.m
//  PTCAL
//
//  Created by Peter Todd on 09/04/2012.
//  Copyright (c) 2012 GREENTOR Ltd. All rights reserved.
//

#import "BBFCalendarDayView.h"

@implementation BBFCalendarDayView

@synthesize dateLabel;
@synthesize cellDate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //NSLog(@"DEBUG creating day view");
        self.backgroundColor=[UIColor clearColor];
        

        // Build the rectangle

        CGRect labelFrame = CGRectMake(0,0,  (self.frame.size.width / 5), (self.frame.size.width / 5));
        
        dateLabel = [[UILabel alloc] initWithFrame:labelFrame];
        //text.transform = CGAffineTransformMakeRotation(M_PI_2);
        dateLabel.backgroundColor = [UIColor lightGrayColor];
        dateLabel.text = @"0";
        [self addSubview:dateLabel];
        [self bringSubviewToFront:dateLabel];
                           
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    
}
*/
 // If click on rectangle do something
 -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event
 {
 NSLog(@"DEBUG Touched a view");
 
 //We will display details of the day when the cell is clicked.
 // Also will link to calendars on device to update availability etc.
 
 }





@end
