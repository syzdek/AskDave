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
#import "GameController.h"
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
@synthesize boards;


- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
   NSDictionary     * appDefaults;
   NSUserDefaults   * localDefaults;
	UIViewController * localController;
   GameController   * gamer;

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

   // creates array for holding board controllers
   NSLog(@"loading Dave views...");
   self.boards = [NSMutableArray arrayWithCapacity:6];

   NSLog(@"loading classic Dave...");
   gamer = [[GameController alloc] init];
   gamer.delegate             = self;
   gamer.defaults             = self.defaults;
   gamer.name                 = @"classic Dave";
   gamer.bga                  = YES;
   gamer.bga_duration         = 120;
   gamer.bga_fromValue        = 90;
   gamer.bga_toValue          = 270;
   gamer.bga_autoreverses     = NO;
   //gamer.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
   gamer.background           = [UIImage imageNamed:@"CR.png"];
   gamer.foreground           = [UIImage imageNamed:@"CB.png"];
   gamer.board                = [UIImage imageNamed:@"CS.png"];
   gamer.messages             = [NSMutableArray arrayWithCapacity:20];
   [gamer.messages addObject:[UIImage imageNamed:@"CA01.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA02.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA03.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA04.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA05.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA06.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA07.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA08.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA09.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA10.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA11.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA12.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA13.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA14.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA15.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA16.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA17.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA18.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA19.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"CA20.png"]];
   [self.boards addObject:gamer];
   [gamer loadView];
   [gamer release];
 

   NSLog(@"loading zombie Dave...");
   gamer = [[GameController alloc] init];
   gamer.delegate             = self;
   gamer.defaults             = self.defaults;
   gamer.name                 = @"zombie Dave";
   gamer.bga                  = YES;
   gamer.bga_duration         = 4;
   gamer.bga_fromValue        = 5;
   gamer.bga_toValue          = 15;
   gamer.bga_autoreverses     = YES;
   gamer.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
   gamer.background           = [UIImage imageNamed:@"ZR.png"];
   gamer.foreground           = [UIImage imageNamed:@"ZB.png"];
   gamer.board                = [UIImage imageNamed:@"ZS.png"];
   gamer.messages             = [NSMutableArray arrayWithCapacity:20];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA01.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA02.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA03.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA04.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA05.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA06.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA07.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA08.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA09.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA10.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA11.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA12.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA13.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA14.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA15.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA16.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA17.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA18.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA19.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"ZA20.png"]];
   [self.boards addObject:gamer];
   [gamer loadView];
   [gamer release];

   NSLog(@"loading nirvana Dave...");
   gamer = [[GameController alloc] init];
   gamer.delegate             = self;
   gamer.defaults             = self.defaults;
   gamer.name                 = @"nirvana Dave";
   gamer.bga                  = YES;
   gamer.bga_duration         = .2;
   gamer.bga_fromValue        = 8;
   gamer.bga_toValue          = 52;
   gamer.bga_autoreverses     = YES;
   //gamer.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
   gamer.background           = [UIImage imageNamed:@"NR.png"];
   gamer.foreground           = [UIImage imageNamed:@"NB.png"];
   gamer.board                = [UIImage imageNamed:@"NS.png"];
   gamer.messages             = [NSMutableArray arrayWithCapacity:20];
   [gamer.messages addObject:[UIImage imageNamed:@"NA01.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA02.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA03.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA04.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA05.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA06.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA07.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA08.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA09.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA10.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA11.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA12.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA13.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA14.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA15.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA16.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA17.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA18.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA19.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"NA20.png"]];
   [self.boards addObject:gamer];
   [gamer loadView];
   [gamer release];

   NSLog(@"loading geek Dave...");
   gamer = [[GameController alloc] init];
   gamer.delegate             = self;
   gamer.defaults             = self.defaults;
   gamer.name                 = @"geek Dave";
   gamer.bga                  = YES;
   gamer.bga_duration         = 60;
   gamer.bga_fromValue        = 0;
   gamer.bga_toValue          = 360;
   gamer.bga_autoreverses     = NO;
   //gamer.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
   gamer.background           = [UIImage imageNamed:@"GR.png"];
   gamer.foreground           = [UIImage imageNamed:@"GB.png"];
   gamer.board                = [UIImage imageNamed:@"GS.png"];
   gamer.messages             = [NSMutableArray arrayWithCapacity:20];
   [gamer.messages addObject:[UIImage imageNamed:@"GA01.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA02.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA03.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA04.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA05.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA06.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA07.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA08.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA09.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA10.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA11.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA12.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA13.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA14.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA15.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA16.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA17.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA18.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA19.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"GA20.png"]];
   [self.boards addObject:gamer];
   [gamer loadView];
   [gamer release];

   NSLog(@"loading pirate Dave...");
   gamer = [[GameController alloc] init];
   gamer.delegate             = self;
   gamer.defaults             = self.defaults;
   gamer.name                 = @"pirate Dave";
   gamer.bga                  = YES;
   gamer.bga_duration         = 95;
   gamer.bga_fromValue        = 0;
   gamer.bga_toValue          = 360;
   gamer.bga_autoreverses     = NO;
   //gamer.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
   gamer.background           = [UIImage imageNamed:@"PR.png"];
   gamer.foreground           = [UIImage imageNamed:@"PB.png"];
   gamer.board                = [UIImage imageNamed:@"PS.png"];
   gamer.messages             = [NSMutableArray arrayWithCapacity:20];
   [gamer.messages addObject:[UIImage imageNamed:@"PA01.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA02.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA03.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA04.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA05.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA06.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA07.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA08.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA09.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA10.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA11.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA12.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA13.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA14.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA15.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA16.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA17.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA18.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA19.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"PA20.png"]];
   [self.boards addObject:gamer];
   [gamer loadView];
   [gamer release];

   NSLog(@"loading devil Dave...");
   gamer = [[GameController alloc] init];
   gamer.delegate             = self;
   gamer.defaults             = self.defaults;
   gamer.name                 = @"devil Dave";
   gamer.bga                  = YES;
   gamer.bga_duration         = 120;
   gamer.bga_fromValue        = 0;
   gamer.bga_toValue          = 360;
   gamer.bga_autoreverses     = NO;
   //gamer.bga_timing_function  = kCAMediaTimingFunctionEaseInEaseOut;
   gamer.background           = [UIImage imageNamed:@"DR.png"];
   gamer.foreground           = [UIImage imageNamed:@"DB.png"];
   gamer.board                = [UIImage imageNamed:@"DS.png"];
   gamer.messages             = [NSMutableArray arrayWithCapacity:20];
   [gamer.messages addObject:[UIImage imageNamed:@"DA01.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA02.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA03.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA04.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA05.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA06.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA07.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA08.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA09.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA10.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA11.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA12.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA13.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA14.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA15.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA16.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA17.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA18.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA19.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"DA20.png"]];
   [self.boards addObject:gamer];
   [gamer loadView];
   [gamer release];

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
   if (self.board)
   {
      [self.board unloadView];
      self.board = Nil;
   };
   if ([sender tag] >= 0)
      self.board = [self.boards objectAtIndex:[sender tag]];
   else
      self.board = [self.boards objectAtIndex:(random()%[self.boards count])];
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
   {
      [self.board unloadView];
      self.board = Nil;
   };
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
   {
      [self.board unloadView];
      self.board = Nil;
   };
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