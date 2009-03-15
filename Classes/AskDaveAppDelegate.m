//
//  AskDaveAppDelegate.m
//  AskDave
//
//  Created by David Syzdek on 3/14/09.
//  Copyright David M. Syzdek 2009. All rights reserved.
//

#import "AskDaveAppDelegate.h"
#import "AskDaveViewController.h"

@implementation AskDaveAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
