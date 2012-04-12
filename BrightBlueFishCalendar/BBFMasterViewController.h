//
//  BBFMasterViewController.h
//  BrightBlueFishCalendar
//
//  Created by Peter Todd on 12/04/2012.
//  Copyright (c) 2012 GREENTOR Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBFDetailViewController;

#import <CoreData/CoreData.h>

@interface BBFMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) BBFDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
