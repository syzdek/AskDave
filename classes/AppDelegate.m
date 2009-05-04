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
 *  @file classes/AppDelegate.m Entry point from UIKit framework
 */

///////////////
//           //
//  Headers  //
//           //
///////////////

#import "common.h"
#import "AppDelegate.h"
#import "DaveController.h"
#import "MenuController.h"
#import "SettingsController.h"

#import "UIImageAskDave.h"


///////////////
//           //
//  Classes  //
//           //
///////////////

@implementation AppDelegate

@synthesize window;
@synthesize active;
@synthesize dave;
@synthesize menu;
@synthesize settings;
@synthesize defaults;


- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
   NSDictionary      * appDefaults;
   NSUserDefaults    * localDefaults;
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   NSLog(@"%@ %@ Source Code", [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleName"], [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]);
   NSLog(@"Copyright (C) 2009 David M. Syzdek");
   NSLog(@"http://www.bindlebinaries.net/");
   NSLog(@"%@ %@ Artwork", [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleName"], [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]);
   NSLog(@"Copyright (C) 2009 David Simmer II");
   NSLog(@"http://www.blogography.com/");

   [application setStatusBarHidden:YES animated:NO];

   srandomdev();

   NSLog(@"loading defaults...");
   localDefaults = [[NSUserDefaults alloc] init];
   self.defaults = localDefaults;
   [localDefaults release];
   appDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:@"shake"];
   [self.defaults registerDefaults:appDefaults];
   appDefaults = [NSDictionary dictionaryWithObject:@"NO" forKey:@"flip"];
   [self.defaults registerDefaults:appDefaults];
   appDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:@"vibrate"];
   [self.defaults registerDefaults:appDefaults];
   appDefaults = [NSDictionary dictionaryWithObject:@"NO" forKey:@"sound"];
   [self.defaults registerDefaults:appDefaults];

   NSLog(@"loading menu view...");
   menu = [[MenuController alloc] init];
   [(id)self.menu setDelegate:self];
   [(id)self.menu setDefaults:self.defaults];
   [self.menu loadView];

   NSLog(@"loading settings view...");
   settings = [[SettingsController alloc] init];
   [(id)settings setDelegate:self];
   [(id)settings setDefaults:self.defaults];
   [(id)settings loadView];

	// Override point for customization after app launch
   NSLog(@"displaying views...");
   self.active = menu;
   [window addSubview:menu.view];
   [window makeKeyAndVisible];

   // loads accelerometer
   NSLog(@"activating accelerometer...");
#ifdef ENABLE_ACCELEROMETER
   [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
   [[UIAccelerometer sharedAccelerometer] setDelegate:self];
#endif

   NSLog(@"Enjoy!!!");

   [pool release];

   return;
}


- (void)applicationWillTerminate:(UIApplication *)application
{
   [self.defaults synchronize];  
   return;
}


- (void)dealloc
{
   [dave     release];
   [settings release];
	[window   release];
	[super    dealloc];
   return;
}


// UIAccelerometerDelegate method, called when the device accelerates.
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
   if (dave == nil)
      return;
   if (dave != active)
      return;
   if ([self.defaults boolForKey:@"shake"])
      [dave accelerometerShake:accelerometer didAccelerate:acceleration];
   else
      [dave accelerometerFlip:accelerometer didAccelerate:acceleration];
   return;
}


- (void) showBoardView:(id)sender
{
   int                 tag;
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   tag = [sender tag];
   if (!(tag))
      tag = (random() % 6) + 1;

   [dave release];
   dave           = [[DaveController alloc] init];
   dave.window    = self.window;
   dave.delegate  = self;
   dave.defaults  = self.defaults;
   dave.messages  = [NSMutableArray arrayWithCapacity:20];

   switch(tag)
   {
      case kDaveClassic:
         NSLog(@"init classic Dave...");
         dave.name                 = @"classic Dave";
         dave.bga                  = YES;
         dave.bga_duration         = 240;
         dave.bga_fromValue        = 360;
         dave.bga_toValue          = 0;
         dave.bga_autoreverses     = NO;
         //dave.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         dave.background           = [UIImage uncachedImageNamed:@"CR.png"];
         dave.foreground           = [UIImage uncachedImageNamed:@"CB.png"];
         dave.board                = [UIImage uncachedImageNamed:@"CS.png"];
         dave.menu                 = [UIImage uncachedImageNamed:@"CAM.png"];
         dave.info                 = [UIImage uncachedImageNamed:@"CAI.png"];
         dave.about                = [UIImage uncachedImageNamed:@"C_INFO.png"];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA01.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA02.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA03.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA04.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA05.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA06.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA07.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA08.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA09.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA10.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA11.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA12.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA13.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA14.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA15.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA16.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA17.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA18.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA19.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"CA20.png"]];
         break;

      case kDaveZombie:
         NSLog(@"init zombie Dave...");
         dave.name                 = @"zombie Dave";
         dave.bga                  = YES;
         dave.bga_duration         = 120;
         dave.bga_fromValue        = 0;
         dave.bga_toValue          = 360;
         dave.bga_autoreverses     = YES;
         //dave.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         dave.background           = [UIImage uncachedImageNamed:@"ZR.png"];
         dave.foreground           = [UIImage uncachedImageNamed:@"ZB.png"];
         dave.board                = [UIImage uncachedImageNamed:@"ZS.png"];
         dave.menu                 = [UIImage uncachedImageNamed:@"ZAM.png"];
         dave.info                 = [UIImage uncachedImageNamed:@"ZAI.png"];
         dave.about                = [UIImage uncachedImageNamed:@"Z_INFO.png"];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA01.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA02.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA03.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA04.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA05.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA06.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA07.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA08.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA09.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA10.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA11.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA12.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA13.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA14.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA15.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA16.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA17.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA18.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA19.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"ZA20.png"]];
         break;

      case kDaveNirvana:
         NSLog(@"init nirvana Dave...");
         dave.name                 = @"nirvana Dave";
         dave.bga                  = YES;
         dave.bga_duration         = 60;
         dave.bga_fromValue        = 0;
         dave.bga_toValue          = 360;
         //dave.bga_autoreverses     = YES;
         //dave.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         dave.background           = [UIImage uncachedImageNamed:@"NR.png"];
         dave.foreground           = [UIImage uncachedImageNamed:@"NB.png"];
         dave.board                = [UIImage uncachedImageNamed:@"NS.png"];
         dave.menu                 = [UIImage uncachedImageNamed:@"NAM.png"];
         dave.info                 = [UIImage uncachedImageNamed:@"NAI.png"];
         dave.about                = [UIImage uncachedImageNamed:@"N_INFO.png"];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA01.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA02.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA03.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA04.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA05.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA06.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA07.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA08.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA09.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA10.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA11.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA12.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA13.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA14.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA15.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA16.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA17.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA18.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA19.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"NA20.png"]];
         break;

      case kDaveGeeky:
         NSLog(@"init geek Dave...");
         dave.name                 = @"geek Dave";
         dave.bga                  = YES;
         dave.bga_duration         = 85;
         dave.bga_fromValue        = 0;
         dave.bga_toValue          = 360;
         dave.bga_autoreverses     = NO;
         //dave.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         dave.background           = [UIImage uncachedImageNamed:@"GR.png"];
         dave.foreground           = [UIImage uncachedImageNamed:@"GB.png"];
         dave.board                = [UIImage uncachedImageNamed:@"GS.png"];
         dave.menu                 = [UIImage uncachedImageNamed:@"GAM.png"];
         dave.info                 = [UIImage uncachedImageNamed:@"GAI.png"];
         dave.about                = [UIImage uncachedImageNamed:@"G_INFO.png"];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA01.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA02.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA03.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA04.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA05.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA06.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA07.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA08.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA09.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA10.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA11.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA12.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA13.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA14.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA15.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA16.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA17.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA18.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA19.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"GA20.png"]];
         break;

      case kDavePirate:
         NSLog(@"init pirate Dave...");
         dave.name                 = @"pirate Dave";
         dave.bga                  = YES;
         dave.bga_duration         = 95;
         dave.bga_fromValue        = 0;
         dave.bga_toValue          = 360;
         dave.bga_autoreverses     = NO;
         //dave.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         dave.background           = [UIImage uncachedImageNamed:@"PR.png"];
         dave.foreground           = [UIImage uncachedImageNamed:@"PB.png"];
         dave.board                = [UIImage uncachedImageNamed:@"PS.png"];
         dave.menu                 = [UIImage uncachedImageNamed:@"PAM.png"];
         dave.info                 = [UIImage uncachedImageNamed:@"PAI.png"];
         dave.about                = [UIImage uncachedImageNamed:@"P_INFO.png"];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA01.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA02.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA03.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA04.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA05.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA06.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA07.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA08.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA09.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA10.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA11.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA12.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA13.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA14.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA15.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA16.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA17.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA18.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA19.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"PA20.png"]];
         break;

      case kDaveDevil:
      default:
         NSLog(@"init devil Dave...");
         dave.name                 = @"devil Dave";
         dave.bga                  = YES;
         dave.bga_duration         = 120;
         dave.bga_fromValue        = 0;
         dave.bga_toValue          = 360;
         dave.bga_autoreverses     = NO;
         //dave.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         dave.background           = [UIImage uncachedImageNamed:@"DR.png"];
         dave.foreground           = [UIImage uncachedImageNamed:@"DB.png"];
         dave.board                = [UIImage uncachedImageNamed:@"DS.png"];
         dave.menu                 = [UIImage uncachedImageNamed:@"DAM.png"];
         dave.info                 = [UIImage uncachedImageNamed:@"DAI.png"];
         dave.about                = [UIImage uncachedImageNamed:@"D_INFO.png"];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA01.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA02.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA03.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA04.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA05.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA06.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA07.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA08.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA09.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA10.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA11.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA12.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA13.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA14.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA15.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA16.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA17.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA18.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA19.png"]];
         [dave.messages addObject:[UIImage uncachedImageNamed:@"DA20.png"]];
         break;
   };

   [dave loadView];

   // setup the animation group
   [UIView setAnimationDelegate:self];
	[UIView beginAnimations:nil context:nil];
   [UIView setAnimationDuration:0.75];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];

   [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:window cache:YES];
   [active.view removeFromSuperview];
   [window addSubview:dave.view];

   [UIView commitAnimations];

   self.active = dave;

   [pool release];

   return;
}


- (void) showMenuView:(id)sender
{
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   [dave animationStop];

   // setup the animation group
   [UIView setAnimationDelegate:self];
	[UIView beginAnimations:nil context:nil];
   [UIView setAnimationDuration:0.75];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];
   
   [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
   [active.view removeFromSuperview];
   [window addSubview:menu.view];

   [UIView commitAnimations];

   [pool release];

   self.active = menu;

   return;
}


- (void) showSettingsView:(id)sender
{
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   // setup the animation group
   [UIView setAnimationDelegate:self];
	[UIView beginAnimations:nil context:nil];
   [UIView setAnimationDuration:0.75];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];

   [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:window cache:YES];
   [active.view removeFromSuperview];
   [window addSubview:settings.view];

   [UIView commitAnimations];

   [pool release];

   self.active = settings;

   return;
}


- (void) transitionDidStop:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
   [active viewDidLoad];
   return;
}

@end

/* end of source */