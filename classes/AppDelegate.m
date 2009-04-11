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
@synthesize board;
@synthesize active;
@synthesize menu;
@synthesize settings;
@synthesize defaults;


- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
   NSDictionary     * appDefaults;
   NSUserDefaults   * localDefaults;
	UIViewController * localController;

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
   localController     = [[MenuController alloc] init];
   self.menu           = localController;
   [(id)self.menu setDelegate:self];
   [(id)self.menu setDefaults:self.defaults];
   [self.menu loadView];
   [localController release];

   NSLog(@"loading settings view...");
   localController         = [[SettingsController alloc] init];
   self.settings           = localController;
   [(id)self.settings setDelegate:self];
   [(id)self.settings setDefaults:self.defaults];
   [self.settings loadView];
   [localController release];

	// Override point for customization after app launch
   NSLog(@"let there be light...");
   self.active = self.menu;
   [self.window addSubview:self.active.view];
   [window makeKeyAndVisible];

   NSLog(@"Enjoy!!!");

   return;
}


- (void)applicationWillTerminate:(UIApplication *)application
{
   [self.defaults synchronize];  
   return;
}


- (void)dealloc
{
   [board    release];
   [settings release];
	[window   release];
	[super    dealloc];
   return;
}


- (void) showBoardView:(id)sender
{
   int                 tag;
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   tag = [sender tag];
   if (!(tag))
      tag = (random() / 6) + 1;

   self.board           = [[DaveController alloc] init];
   self.board.window    = self.window;
   self.board.delegate  = self;
   self.board.defaults  = self.defaults;
   self.board.messages  = [NSMutableArray arrayWithCapacity:20];
   [self.board release];

   switch(tag)
   {
      case 1:
         NSLog(@"init classic Dave...");
         self.board.name                 = @"classic Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = 120;
         self.board.bga_fromValue        = 90;
         self.board.bga_toValue          = 270;
         self.board.bga_autoreverses     = NO;
         //self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage uncachedImageNamed:@"CR.png"];
         self.board.foreground           = [UIImage uncachedImageNamed:@"CB.png"];
         self.board.board                = [UIImage uncachedImageNamed:@"CS.png"];
         self.board.menu                 = [UIImage uncachedImageNamed:@"CAM.png"];
         self.board.info                 = [UIImage uncachedImageNamed:@"CAI.png"];
         self.board.about                = [UIImage uncachedImageNamed:@"C_INFO.png"];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA01.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA02.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA03.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA04.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA05.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA06.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA07.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA08.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA09.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA10.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA11.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA12.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA13.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA14.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA15.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA16.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA17.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA18.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA19.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"CA20.png"]];
         break;

      case 2:
         NSLog(@"init zombie Dave...");
         self.board.name                 = @"zombie Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = 4;
         self.board.bga_fromValue        = 5;
         self.board.bga_toValue          = 15;
         self.board.bga_autoreverses     = YES;
         self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage uncachedImageNamed:@"ZR.png"];
         self.board.foreground           = [UIImage uncachedImageNamed:@"ZB.png"];
         self.board.board                = [UIImage uncachedImageNamed:@"ZS.png"];
         self.board.menu                 = [UIImage uncachedImageNamed:@"ZAM.png"];
         self.board.info                 = [UIImage uncachedImageNamed:@"ZAI.png"];
         self.board.about                = [UIImage uncachedImageNamed:@"Z_INFO.png"];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA01.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA02.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA03.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA04.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA05.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA06.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA07.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA08.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA09.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA10.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA11.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA12.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA13.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA14.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA15.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA16.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA17.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA18.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA19.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"ZA20.png"]];
         break;

      case 3:
         NSLog(@"init nirvana Dave...");
         self.board.name                 = @"nirvana Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = .2;
         self.board.bga_fromValue        = 8;
         self.board.bga_toValue          = 52;
         self.board.bga_autoreverses     = YES;
         //self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage uncachedImageNamed:@"NR.png"];
         self.board.foreground           = [UIImage uncachedImageNamed:@"NB.png"];
         self.board.board                = [UIImage uncachedImageNamed:@"NS.png"];
         self.board.menu                 = [UIImage uncachedImageNamed:@"NAM.png"];
         self.board.info                 = [UIImage uncachedImageNamed:@"NAI.png"];
         self.board.about                = [UIImage uncachedImageNamed:@"N_INFO.png"];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA01.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA02.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA03.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA04.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA05.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA06.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA07.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA08.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA09.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA10.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA11.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA12.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA13.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA14.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA15.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA16.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA17.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA18.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA19.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"NA20.png"]];
         break;

      case 4:
         NSLog(@"init geek Dave...");
         self.board.name                 = @"geek Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = 60;
         self.board.bga_fromValue        = 0;
         self.board.bga_toValue          = 360;
         self.board.bga_autoreverses     = NO;
         //self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage uncachedImageNamed:@"GR.png"];
         self.board.foreground           = [UIImage uncachedImageNamed:@"GB.png"];
         self.board.board                = [UIImage uncachedImageNamed:@"GS.png"];
         self.board.menu                 = [UIImage uncachedImageNamed:@"GAM.png"];
         self.board.info                 = [UIImage uncachedImageNamed:@"GAI.png"];
         self.board.about                = [UIImage uncachedImageNamed:@"G_INFO.png"];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA01.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA02.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA03.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA04.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA05.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA06.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA07.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA08.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA09.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA10.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA11.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA12.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA13.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA14.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA15.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA16.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA17.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA18.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA19.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"GA20.png"]];
         break;

      case 5:
         NSLog(@"init pirate Dave...");
         self.board.name                 = @"pirate Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = 95;
         self.board.bga_fromValue        = 0;
         self.board.bga_toValue          = 360;
         self.board.bga_autoreverses     = NO;
         //self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage uncachedImageNamed:@"PR.png"];
         self.board.foreground           = [UIImage uncachedImageNamed:@"PB.png"];
         self.board.board                = [UIImage uncachedImageNamed:@"PS.png"];
         self.board.menu                 = [UIImage uncachedImageNamed:@"PAM.png"];
         self.board.info                 = [UIImage uncachedImageNamed:@"PAI.png"];
         self.board.about                = [UIImage uncachedImageNamed:@"P_INFO.png"];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA01.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA02.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA03.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA04.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA05.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA06.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA07.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA08.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA09.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA10.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA11.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA12.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA13.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA14.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA15.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA16.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA17.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA18.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA19.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"PA20.png"]];
         break;

      case 6:
      default:
         NSLog(@"init devil Dave...");
         self.board.name                 = @"devil Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = 120;
         self.board.bga_fromValue        = 0;
         self.board.bga_toValue          = 360;
         self.board.bga_autoreverses     = NO;
         //self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage uncachedImageNamed:@"DR.png"];
         self.board.foreground           = [UIImage uncachedImageNamed:@"DB.png"];
         self.board.board                = [UIImage uncachedImageNamed:@"DS.png"];
         self.board.menu                 = [UIImage uncachedImageNamed:@"DAM.png"];
         self.board.info                 = [UIImage uncachedImageNamed:@"DAI.png"];
         self.board.about                = [UIImage uncachedImageNamed:@"D_INFO.png"];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA01.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA02.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA03.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA04.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA05.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA06.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA07.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA08.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA09.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA10.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA11.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA12.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA13.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA14.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA15.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA16.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA17.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA18.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA19.png"]];
         [self.board.messages addObject:[UIImage uncachedImageNamed:@"DA20.png"]];
         break;
   };

   [self.board loadView];

   // setup the animation group
	[UIView beginAnimations:nil context:nil];
   [UIView setAnimationDuration:0.75];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];

   [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:window cache:YES];
   [self.active.view removeFromSuperview];
   [window addSubview:self.board.view];

   [UIView commitAnimations];

   self.active = self.board;

   [self.board viewDidLoad];

   [pool release];

   return;
}


- (void) showMenuView:(id)sender
{
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   // setup the animation group
	[UIView beginAnimations:nil context:nil];
   [UIView setAnimationDuration:0.75];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];
   
   [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
   [self.active.view removeFromSuperview];
   [window addSubview:self.menu.view];

   [UIView commitAnimations];

   self.active = self.menu;

   [pool release];

   return;
}


- (void) showSettingsView:(id)sender
{
   NSAutoreleasePool * pool;

   pool = [[NSAutoreleasePool alloc] init];

   // setup the animation group
	[UIView beginAnimations:nil context:nil];
   [UIView setAnimationDuration:0.75];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];

   [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:window cache:YES];
   [self.active.view removeFromSuperview];
   [window addSubview:self.settings.view];

   [UIView commitAnimations];

   self.active = self.settings;

   [pool release];

   return;
}

@end

/* end of source */