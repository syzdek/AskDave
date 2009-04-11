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
   int              tag;

   tag = [sender tag];
   if (!(tag))
      tag = (random() / 6) + 1;

   self.board           = [[DaveController alloc] init];
   self.board.delegate  = self;
   self.board.defaults  = self.defaults;
   self.board.messages  = [NSMutableArray arrayWithCapacity:20];

   switch(tag)
   {
      case 1:
         NSLog(@"loading classic Dave...");
         self.board.name                 = @"classic Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = 120;
         self.board.bga_fromValue        = 90;
         self.board.bga_toValue          = 270;
         self.board.bga_autoreverses     = NO;
         //self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage imageNamed:@"CR.png"];
         self.board.foreground           = [UIImage imageNamed:@"CB.png"];
         self.board.board                = [UIImage imageNamed:@"CS.png"];
         [self.board.messages addObject:[UIImage imageNamed:@"CA01.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA02.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA03.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA04.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA05.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA06.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA07.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA08.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA09.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA10.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA11.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA12.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA13.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA14.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA15.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA16.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA17.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA18.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA19.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"CA20.png"]];
         break;

      case 2:
         NSLog(@"loading zombie Dave...");
         self.board.name                 = @"zombie Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = 4;
         self.board.bga_fromValue        = 5;
         self.board.bga_toValue          = 15;
         self.board.bga_autoreverses     = YES;
         self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage imageNamed:@"ZR.png"];
         self.board.foreground           = [UIImage imageNamed:@"ZB.png"];
         self.board.board                = [UIImage imageNamed:@"ZS.png"];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA01.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA02.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA03.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA04.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA05.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA06.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA07.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA08.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA09.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA10.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA11.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA12.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA13.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA14.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA15.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA16.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA17.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA18.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA19.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"ZA20.png"]];
         break;

      case 3:
         NSLog(@"loading nirvana Dave...");
         self.board.name                 = @"nirvana Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = .2;
         self.board.bga_fromValue        = 8;
         self.board.bga_toValue          = 52;
         self.board.bga_autoreverses     = YES;
         //self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage imageNamed:@"NR.png"];
         self.board.foreground           = [UIImage imageNamed:@"NB.png"];
         self.board.board                = [UIImage imageNamed:@"NS.png"];
         [self.board.messages addObject:[UIImage imageNamed:@"NA01.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA02.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA03.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA04.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA05.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA06.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA07.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA08.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA09.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA10.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA11.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA12.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA13.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA14.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA15.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA16.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA17.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA18.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA19.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"NA20.png"]];
         break;

      case 4:
         NSLog(@"loading geek Dave...");
         self.board.name                 = @"geek Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = 60;
         self.board.bga_fromValue        = 0;
         self.board.bga_toValue          = 360;
         self.board.bga_autoreverses     = NO;
         //self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage imageNamed:@"GR.png"];
         self.board.foreground           = [UIImage imageNamed:@"GB.png"];
         self.board.board                = [UIImage imageNamed:@"GS.png"];
         [self.board.messages addObject:[UIImage imageNamed:@"GA01.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA02.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA03.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA04.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA05.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA06.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA07.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA08.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA09.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA10.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA11.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA12.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA13.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA14.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA15.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA16.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA17.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA18.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA19.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"GA20.png"]];
         break;

      case 5:
         NSLog(@"loading pirate Dave...");
         self.board.name                 = @"pirate Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = 95;
         self.board.bga_fromValue        = 0;
         self.board.bga_toValue          = 360;
         self.board.bga_autoreverses     = NO;
         //self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage imageNamed:@"PR.png"];
         self.board.foreground           = [UIImage imageNamed:@"PB.png"];
         self.board.board                = [UIImage imageNamed:@"PS.png"];
         [self.board.messages addObject:[UIImage imageNamed:@"PA01.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA02.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA03.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA04.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA05.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA06.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA07.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA08.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA09.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA10.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA11.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA12.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA13.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA14.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA15.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA16.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA17.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA18.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA19.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"PA20.png"]];
         break;

      case 6:
      default:
         NSLog(@"loading devil Dave...");
         self.board.name                 = @"devil Dave";
         self.board.bga                  = YES;
         self.board.bga_duration         = 120;
         self.board.bga_fromValue        = 0;
         self.board.bga_toValue          = 360;
         self.board.bga_autoreverses     = NO;
         //self.board.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
         self.board.background           = [UIImage imageNamed:@"DR.png"];
         self.board.foreground           = [UIImage imageNamed:@"DB.png"];
         self.board.board                = [UIImage imageNamed:@"DS.png"];
         [self.board.messages addObject:[UIImage imageNamed:@"DA01.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA02.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA03.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA04.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA05.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA06.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA07.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA08.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA09.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA10.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA11.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA12.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA13.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA14.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA15.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA16.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA17.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA18.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA19.png"]];
         [self.board.messages addObject:[UIImage imageNamed:@"DA20.png"]];
         break;
   };

   [self.board loadView];
   [self.board release];

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

   return;
}


- (void) showMenuView:(id)sender
{
   if (self.board)
      [self.board unloadView];

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

   return;
}


- (void) showSettingsView:(id)sender
{
   if (self.board)
      [self.board unloadView];

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

   return;
}

@end

/* end of source */