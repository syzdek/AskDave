//
//  AskDaveAppDelegate.h
//  AskDave
//
//  Created by David Syzdek on 3/14/09.
//  Copyright David M. Syzdek 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AskDaveViewController;

@interface AskDaveAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AskDaveViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AskDaveViewController *viewController;

@end

