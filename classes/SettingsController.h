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
 *  @file classes/SettingsController.h controls settings/info display
 */

///////////////
//           //
//  Headers  //
//           //
///////////////

#import <UIKit/UIKit.h>


@interface SettingsController : UIViewController
{
   id               delegate;
   UISwitch       * shakeSwitch;
   UISwitch       * flipSwitch;
   UISwitch       * vibrateSwitch;
   UISwitch       * soundSwitch;
   NSUserDefaults * defaults;
}

@property(nonatomic, retain) id               delegate; 
@property(nonatomic, retain) UISwitch       * shakeSwitch; 
@property(nonatomic, retain) UISwitch       * flipSwitch; 
@property(nonatomic, retain) UISwitch       * vibrateSwitch; 
@property(nonatomic, retain) UISwitch       * soundSwitch; 
@property(nonatomic, retain) NSUserDefaults * defaults;

- (void) openDeveloper:(id)sender;

- (void) updateShakePref:(id)sender;
- (void) updateFlipPref:(id)sender;
- (void) updateVibratePref:(id)sender;
- (void) updateSoundPref:(id)sender;

@end
