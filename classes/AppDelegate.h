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
#import "GameController.h"


/////////////////////////
//                     //
//  Class Definitions  //
//                     //
/////////////////////////

@class AskDaveViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
   IBOutlet UIWindow  * window;
   GameController     * board;
   UIViewController   * active;
   UIViewController   * menu;
   UIViewController   * settings;
   NSUserDefaults     * defaults;
   NSMutableArray     * boards;
}

@property (nonatomic, retain) UIWindow           * window;
@property (nonatomic, retain) GameController     * board;
@property (nonatomic, retain) UIViewController   * active;
@property (nonatomic, retain) UIViewController   * menu;
@property (nonatomic, retain) UIViewController   * settings;
@property (nonatomic, retain) NSUserDefaults     * defaults;
@property (nonatomic, retain) NSMutableArray     * boards;

- (void) showBoardView:(id)sender;
- (void) showMenuView:(id)sender;
- (void) showSettingsView:(id)sender;

@end

