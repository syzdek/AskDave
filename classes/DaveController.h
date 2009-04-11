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
 *  @file classes/DaveController.h controls the game board
 */

///////////////
//           //
//  Headers  //
//           //
///////////////

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

/////////////////////////
//                     //
//  Class Definitions  //
//                     //
/////////////////////////

@class AppDelegate;

@interface DaveController : UIViewController <UIAccelerometerDelegate>
{
   UIWindow           * window;
   NSString           * name;
   id                  delegate;
   BOOL                hasFliped;
   float               x;
   float               y;
   float               z;
   float               oldX;
   float               oldY;
   float               oldZ;

   // Background animation settings
   float               bga;
   float               bga_duration;
   float               bga_fromValue;
   float               bga_toValue;
   BOOL                bga_autoreverses;
   NSString          * bga_timing_function;

   UILabel           * forceDataX;
   UILabel           * forceDataY;
   UILabel           * forceDataZ;

   UIImage           * background;
   UIImageView       * backgroundView;
   CABasicAnimation  * backgroundAnimation;
   UIImage           * foreground;
   UIImageView       * foregroundView;
   UIImage           * board;
   UIImageView       * boardView;
   NSMutableArray    * messages;
   UIImageView       * messageView;
   UIImage           * menu;
   UIButton          * menuButton;
   UIImage           * info;
   UIButton          * infoButton;

   UIImage           * about;
   UIView            * aboutView;
   UIImageView       * aboutImageView;
   UIButton          * aboutButton;

   NSUserDefaults    * defaults;
   NSTimer           * timer;
   SystemSoundID       chimes;
}

@property(nonatomic, retain) UIWindow          * window;
@property(nonatomic, retain) NSString          * name;
@property(nonatomic, retain) id                  delegate;
@property(assign, readwrite) BOOL                hasFliped;
@property(assign, readwrite) float               x;
@property(assign, readwrite) float               y;
@property(assign, readwrite) float               z;
@property(assign, readwrite) float               oldX;
@property(assign, readwrite) float               oldY;
@property(assign, readwrite) float               oldZ;

// Background animation settings
@property(assign, readwrite) float               bga;
@property(assign, readwrite) float               bga_duration;
@property(assign, readwrite) float               bga_fromValue;
@property(assign, readwrite) float               bga_toValue;
@property(assign, readwrite) BOOL                bga_autoreverses;
@property(assign) NSString                     * bga_timing_function;

@property(nonatomic, retain) UILabel           * forceDataX;
@property(nonatomic, retain) UILabel           * forceDataY;
@property(nonatomic, retain) UILabel           * forceDataZ;

@property(nonatomic, retain) UIImage           * background;
@property(nonatomic, retain) UIImageView       * backgroundView;
@property(nonatomic, retain) CABasicAnimation  * backgroundAnimation;
@property(nonatomic, retain) UIImage           * foreground;
@property(nonatomic, retain) UIImageView       * foregroundView;
@property(nonatomic, retain) UIImage           * board;
@property(nonatomic, retain) UIImageView       * boardView;
@property(nonatomic, retain) NSMutableArray    * messages;
@property(nonatomic, retain) UIImageView       * messageView;
@property(nonatomic, retain) UIImage           * menu;
@property(nonatomic, retain) UIButton          * menuButton;
@property(nonatomic, retain) UIImage           * info;
@property(nonatomic, retain) UIButton          * infoButton;

@property(nonatomic, retain) UIImage           * about;
@property(nonatomic, retain) UIView            * aboutView;
@property(nonatomic, retain) UIImageView       * aboutImageView;
@property(nonatomic, retain) UIButton          * aboutButton;

@property(nonatomic, retain) NSUserDefaults    * defaults;
@property(nonatomic, retain) NSTimer           * timer;

- (void)unloadView;
- (void)showMessage;

- (void)rollBall:(NSString *)newMessage;
- (void)accelerometerFlip:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
- (void)accelerometerShake:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;


@end

/* end of header */