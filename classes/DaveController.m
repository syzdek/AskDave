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
 *  @file classes/DaveController.m controls the game board
 */

///////////////
//           //
//  Headers  //
//           //
///////////////

#import "common.h"
#import "DaveController.h"
#import "DaveInfoView.h"
#import "DaveView.h"
#import <AudioToolbox/AudioToolbox.h>


///////////////////
//               //
//  Definitions  //
//               //
///////////////////

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};


///////////////
//           //
//  Classes  //
//           //
///////////////

@implementation DaveController

@synthesize delegate;
@synthesize window;
@synthesize name;

@synthesize bga;
@synthesize bga_duration;
@synthesize bga_fromValue;
@synthesize bga_toValue;
@synthesize bga_autoreverses;
@synthesize bga_timing_function;

@synthesize about;
@synthesize background;
@synthesize board;
@synthesize foreground;
@synthesize info;
@synthesize menu;

@synthesize messages;
@synthesize backgroundAnimation;
@synthesize defaults;
@synthesize timer;

-(id) init
{
   if (self = [super init])
   {
      daveInfo  = [[DaveInfoView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
      dave      = [[DaveView alloc]     initWithFrame:[[UIScreen mainScreen] applicationFrame]];
      self.view = dave;
   }
   return(self);
}


// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView
{
   //NSString          * path;
   NSAutoreleasePool * pool;
   
   pool = [[NSAutoreleasePool alloc] init];

   NSLog(@"loading %@", self.name);

   //path = [[NSBundle mainBundle] pathForResource:@"chimes" ofType:@"wav"];
   //AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &chimes);

   dave.delegate   = self;
   dave.background = self.background;
   dave.foreground = self.foreground;
   dave.board      = self.board;
   dave.message    = nil;
   dave.menu       = self.menu;
   dave.info       = self.info;

   daveInfo.delegate = self;
   daveInfo.about    = self.about;

   oldX = 4;
   oldY = 4;
   oldZ = 4;
   
   [pool release];
   
   return;
}


- (void) showMenuView:(id)sender
{
   [delegate showMenuView:sender];
   return;
}


- (void)unloadView
{
   NSLog(@"unloading view of %@", self.name);
   [[UIAccelerometer sharedAccelerometer] setUpdateInterval:90.0];
   [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
   if (self.timer)
      [self.timer invalidate];
   if (dave)
      [dave.boardView.layer removeAllAnimations];
   if (dave)
      [dave.backgroundView.layer removeAllAnimations];
   if (self.backgroundAnimation)
      self.backgroundAnimation.delegate = nil;
   self.backgroundAnimation = nil;
   return;
}


// UIAccelerometerDelegate method, called when the device accelerates.
- (void)accelerometerFlip:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
   NSAutoreleasePool * pool;
   
   pool = [[NSAutoreleasePool alloc] init];

   x = acceleration.x;
   y = acceleration.y;
   z = acceleration.z;
   
#ifdef DEBUG
   dave.forceDataX.text = [NSString stringWithFormat:@"X: %+1.30f", x];
   dave.forceDataY.text = [NSString stringWithFormat:@"Y: %+1.30f", y];
   dave.forceDataZ.text = [NSString stringWithFormat:@"Z: %+1.30f", z];
#endif

   if (z > 0.7)
   {
      hasFliped = YES;
      dave.message = Nil;
   };
   if ((z < 0.0) && (hasFliped))
   {
      hasFliped                  = NO;
      [self rollBall:nil];
   };
   
   [pool release];
   return;
}


// UIAccelerometerDelegate method, called when the device accelerates.
- (void)accelerometerShake:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
   float               diffX;
   float               diffY;
   float               diffZ;
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   // grabs current readings
   x = acceleration.x;
   y = acceleration.y;
   z = acceleration.z;
   
   // if this is the first reading, save state and exit
   if ((oldX > 3) || (oldY > 3) || (oldZ > 3))
   {
      oldX = x;
      oldY = y;
      oldZ = z;
      return;
   }
   
   diffX = fabsf(x - oldX);
   diffY = fabsf(y - oldY);
   diffZ = fabsf(z - oldZ);
   
#ifdef DEBUG
   dave.forceDataX.text = [NSString stringWithFormat:@"X: %+1.30f", diffX];
   dave.forceDataY.text = [NSString stringWithFormat:@"Y: %+1.30f", diffY];
   dave.forceDataZ.text = [NSString stringWithFormat:@"Z: %+1.30f", diffZ];
#endif

   //if (z > 0.3)
   //   [message setText:@""];
   if ((diffX > 1.0) || (diffY > 1.0) || (diffZ > 1.0))
   {
      hasFliped    = YES;
      dave.message = Nil;
      if (self.timer)
      {
         [self.timer invalidate];
         self.timer = Nil;
      };
   }
   else if (((diffX < 0.1) || (diffY < 0.1) || (diffZ < 0.1)) && (hasFliped))
   {
      hasFliped                  = NO;
      [self rollBall:nil];
   };
   
   oldX = x;
   oldY = y;
   oldZ = z;
   
   [pool release];
   
   return;
}

-(void) bounceBoard
{
   CGMutablePathRef      thePath;
	CAKeyframeAnimation * bounceAnimation;

   [dave.boardView.layer removeAllAnimations];

   thePath = CGPathCreateMutable();
   CGPathMoveToPoint(thePath, NULL, dave.boardView.center.x, dave.boardView.center.y);
   CGPathAddLineToPoint(thePath, NULL, dave.boardView.center.x, dave.boardView.center.y-15);
   CGPathAddLineToPoint(thePath, NULL, dave.boardView.center.x, dave.boardView.center.y);
   CGPathAddLineToPoint(thePath, NULL, dave.boardView.center.x, dave.boardView.center.y+15);
   CGPathAddLineToPoint(thePath, NULL, dave.boardView.center.x, dave.boardView.center.y);

   bounceAnimation                     = [CAKeyframeAnimation animationWithKeyPath:@"position"];
   bounceAnimation.removedOnCompletion = YES;
	bounceAnimation.duration            = .25;
   bounceAnimation.repeatCount         = 5;
   bounceAnimation.path                = thePath;
   //bounceAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

   [dave.boardView.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];

   if (self.timer)
   {
      [self.timer invalidate];
      self.timer = Nil;
   };
   self.timer = [[NSTimer alloc]  initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:(bounceAnimation.duration*bounceAnimation.repeatCount)+.15]
                              interval:1
                              target:self
                              selector:@selector(showMessage)
                              userInfo:nil
                              repeats:NO];
   [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
   [self.timer release];

   return;
}

- (void)hideMessage
{
   if (self.timer)
   {
      [self.timer invalidate];
      self.timer = Nil;
   };
   dave.messageView.hidden = YES;
   return;
}


- (void)showMessage
{
   dave.messageView.hidden = NO;
   if (self.timer)
   {
      [self.timer invalidate];
      self.timer = Nil;
   };
   self.timer = [[NSTimer alloc]  initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:10]
                              interval:1
                              target:self
                              selector:@selector(hideMessage)
                              userInfo:nil
                              repeats:NO];
   [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
   [self.timer release];

   return;
}


- (IBAction) rollBall:(NSString *)newMessage
{
   NSUInteger   msg_count = [self.messages count];
   NSUInteger   msg_index = random() % msg_count;
   dave.message           = [self.messages objectAtIndex:msg_index];

   if ([self.defaults boolForKey:@"vibrate"])
      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
   if ([self.defaults boolForKey:@"sound"])
      AudioServicesPlaySystemSound(chimes);

   [self bounceBoard];

   dave.messageView.hidden = YES;
      
  return;
};


// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad
{
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   NSLog(@"loading view of %@", self.name);

   [self animationDidStop:Nil finished:YES];

   // creates background animation
   if (self.bga)
   {
      self.backgroundAnimation                = [CABasicAnimation animation];
      backgroundAnimation.delegate            = self;
      backgroundAnimation.keyPath             = @"transform.rotation.z";
      backgroundAnimation.fromValue           = [NSNumber numberWithFloat:DegreesToRadians(self.bga_fromValue)];
      backgroundAnimation.toValue             = [NSNumber numberWithFloat:DegreesToRadians(self.bga_toValue)];
      backgroundAnimation.duration            = self.bga_duration;
      backgroundAnimation.removedOnCompletion = YES;
      // leaves presentation layer in final state; preventing snap-back to original state
      backgroundAnimation.fillMode            = kCAFillModeBoth;
      backgroundAnimation.autoreverses        = self.bga_autoreverses; 
      backgroundAnimation.repeatCount         = 5;
      if (self.bga_timing_function)
         backgroundAnimation.timingFunction   = [CAMediaTimingFunction functionWithName:self.bga_timing_function];

      [dave.backgroundView.layer addAnimation:backgroundAnimation forKey:@"rotateAnimation"];
   };

   [pool release];

   return;
}


- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
   NSAutoreleasePool * pool;

   if (!(flag))
      return;

   pool = [[NSAutoreleasePool alloc] init];

   [dave.backgroundView.layer removeAllAnimations];

   [dave.backgroundView.layer addAnimation:backgroundAnimation forKey:@"rotateAnimation"];

   [pool release];

   return;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   switch(interfaceOrientation)
   {
      case UIInterfaceOrientationPortrait:
      case UIInterfaceOrientationPortraitUpsideDown:
         return(YES);
      default:
         return(NO);
   };
	return (NO);
}


- (void)didReceiveMemoryWarning {
   NSLog(@"DaveController received memory warning.");
   [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
   // Release any cached data, images, etc that aren't in use.
}


- (void)dealloc
{
   //[self unloadView];

   NSLog(@"deallocing %@", self.name);

   if (self.backgroundAnimation)
      self.backgroundAnimation.delegate = nil;
   self.backgroundAnimation          = nil;

   self.view            = nil;

   self.window          = nil;
   self.name            = nil;
   self.delegate        = nil;

   self.bga_timing_function = nil;

   self.about           = nil;
   self.background      = nil;
   self.board           = nil;
   self.foreground      = nil;
   self.info            = nil;
   self.menu            = nil;

   self.messages        = nil;
   self.defaults        = nil;
   self.timer           = nil;
   //AudioServicesDisposeSystemSoundID(chimes);

   [dave release];
   [daveInfo release];

	[super dealloc];

   return;
}


- (void) showAboutView:(id)sender
{
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   // setup the animation group
	[UIView beginAnimations:nil context:nil];
   [UIView setAnimationDuration:0.75];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];

   [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:window cache:YES];
   [dave removeFromSuperview];
   [window addSubview:daveInfo];

   [UIView commitAnimations];

   self.view = daveInfo;

   [pool release];

   return;
}


- (void) showBoardView:(id)sender
{
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   // setup the animation group
	[UIView beginAnimations:nil context:nil];
   [UIView setAnimationDuration:0.75];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];

   [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
   [daveInfo removeFromSuperview];
   [window addSubview:dave];

   [UIView commitAnimations];

   self.view = dave;

   [pool release];

   return;
}


@end

/* end of source */