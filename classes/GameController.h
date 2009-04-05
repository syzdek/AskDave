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
 *  @file classes/GameController.h controls the game board
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

@interface GameController : UIViewController <UIAccelerometerDelegate>
{
   id                  delegate;
   BOOL                hasFliped;
   float               x;
   float               y;
   float               z;
   float               oldX;
   float               oldY;
   float               oldZ;
   UILabel           * message;
   UILabel           * forceDataX;
   UILabel           * forceDataY;
   UILabel           * forceDataZ;

   UIImage           * background;
   UIImageView       * backgroundView;
   UIImage           * foreground;
   UIImageView       * foregroundView;
   UIImage           * board;
   UIImage           * hideImage;
   UIImage           * revealImage;

   UIImageView       * boardView;
   UIImageView       * messageView;
   UIImageView       * centerImageView;
   NSUserDefaults    * defaults;
   SystemSoundID       chimes;
   NSMutableArray    * messages;
}

@property(assign, readwrite) BOOL             hasFliped;
@property(assign, readwrite) float            x;
@property(assign, readwrite) float            y;
@property(assign, readwrite) float            z;
@property(assign, readwrite) float            oldX;
@property(assign, readwrite) float            oldY;
@property(assign, readwrite) float            oldZ;
@property(nonatomic, retain) id               delegate;
@property(nonatomic, retain) UILabel        * message;
@property(nonatomic, retain) UILabel        * forceDataX;
@property(nonatomic, retain) UILabel        * forceDataY;
@property(nonatomic, retain) UILabel        * forceDataZ;

@property(nonatomic, retain) UIImage        * background;
@property(nonatomic, retain) UIImage        * foreground;
@property(nonatomic, retain) UIImageView    * foregroundView;
@property(nonatomic, retain) UIImage        * board;

@property(nonatomic, retain) UIImage        * hideImage;
@property(nonatomic, retain) UIImage        * revealImage;
@property(nonatomic, retain) UIImageView    * boardView;
@property(nonatomic, retain) UIImageView    * backgroundView;

@property(nonatomic, retain) UIImageView    * messageView;
@property(nonatomic, retain) UIImageView    * centerImageView;
@property(nonatomic, retain) NSUserDefaults * defaults;
@property(nonatomic, retain) NSMutableArray * messages;

- (void) rollBall:(NSString *)newMessage;
- (void)accelerometerFlip:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
- (void)accelerometerShake:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;


@end

/* end of header */