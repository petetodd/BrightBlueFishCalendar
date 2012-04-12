//
//  BBFDetailViewController.h
//  BrightBlueFishCalendar
//
//  Created by Peter Todd on 12/04/2012.
//  Copyright (c) 2012 GREENTOR Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBFDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet UIView *calView;
@end
