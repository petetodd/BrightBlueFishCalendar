//
//  BBFAppDelegate.h
//  BrightBlueFishCalendar
//
//  Created by Peter Todd on 12/04/2012.
//  Copyright (c) 2012 GREENTOR Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
