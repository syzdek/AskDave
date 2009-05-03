/*
 *  AskDave
 *  Copyright (C) 2009 David M. Syzdek <syzdek@bindlebinaries.net>.
 *
 *  @BINDLEBINARIES_FOSS_LICENSE_HEADER_START@
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License Version 2 as
 *  published by the Free Software Foundation.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 *
 *  @BINDLEBINARIES_FOSS_LICENSE_HEADER_END@
 */
/**
 *  @file classes/AppDelegate.h Entry point from UIKit framework
 */

///////////////
//           //
//  Headers  //
//           //
///////////////

#import <UIKit/UIKit.h>
#import "DaveController.h"


/////////////////////////
//                     //
//  Class Definitions  //
//                     //
/////////////////////////

@class AskDaveViewController;
@class DaveController;
@class SettingsController;

@interface AppDelegate : NSObject <UIApplicationDelegate, UIAccelerometerDelegate>
{
   IBOutlet UIWindow  * window;
   DaveController     * board;
   BOOL                 boardActive;
   UIView             * active;
   UIViewController   * menu;
   SettingsController * settings;
   NSUserDefaults     * defaults;
}

@property (nonatomic, retain) UIWindow           * window;
@property (nonatomic, retain) DaveController     * board;
@property (nonatomic, retain) UIView             * active;
@property (nonatomic, retain) UIViewController   * menu;
@property (nonatomic, retain) SettingsController * settings;
@property (nonatomic, retain) NSUserDefaults     * defaults;

- (void) applicationDidFinishLaunching:(UIApplication *)application;
- (void) applicationWillTerminate:(UIApplication *)application;
- (void) dealloc;
- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
- (void) showBoardView:(id)sender;
- (void) showMenuView:(id)sender;
- (void) showSettingsView:(id)sender;

@end

