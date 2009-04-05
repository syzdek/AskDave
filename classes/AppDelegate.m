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
   [(id)gamer setDelegate:self];
   [(id)gamer setDefaults:self.defaults];
   gamer.background  = Nil;
   gamer.foreground  = Nil;
   gamer.board       = Nil;
   gamer.messages    = [NSMutableArray arrayWithCapacity:10];
   [self.boards addObject:self.settings];
   [gamer loadView];
   [gamer release];

   NSLog(@"loading zombie Dave...");
   gamer = [[GameController alloc] init];
   [(id)gamer setDelegate:self];
   [(id)gamer setDefaults:self.defaults];
   gamer.background  = Nil;
   gamer.foreground  = Nil;
   gamer.board       = Nil;
   gamer.messages    = [NSMutableArray arrayWithCapacity:10];
   [self.boards addObject:self.settings];
   [gamer loadView];
   [gamer release];

   NSLog(@"loading nirvana Dave...");
   gamer = [[GameController alloc] init];
   [(id)gamer setDelegate:self];
   [(id)gamer setDefaults:self.defaults];
   gamer.background  = Nil;
   gamer.foreground  = Nil;
   gamer.board       = Nil;
   gamer.messages    = [NSMutableArray arrayWithCapacity:10];
   [self.boards addObject:self.settings];
   [gamer loadView];
   [gamer release];

   NSLog(@"loading geek Dave...");
   gamer = [[GameController alloc] init];
   [(id)gamer setDelegate:self];
   [(id)gamer setDefaults:self.defaults];
   gamer.background  = [UIImage imageNamed:@"geek-bg.png"];
   gamer.foreground  = [UIImage imageNamed:@"geek-fg.png"];
   gamer.board       = [UIImage imageNamed:@"geek-bd.png"];
   gamer.messages    = [NSMutableArray arrayWithCapacity:10];
   [gamer.messages addObject:[UIImage imageNamed:@"geek-msg01.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"geek-msg02.png"]];
   [gamer.messages addObject:[UIImage imageNamed:@"geek-msg03.png"]];
   [self.boards addObject:gamer];
   [gamer loadView];
   [gamer release];

   NSLog(@"loading pirate Dave...");
   gamer = [[GameController alloc] init];
   [(id)gamer setDelegate:self];
   [(id)gamer setDefaults:self.defaults];
   gamer.background  = Nil;
   gamer.foreground  = Nil;
   gamer.board       = Nil;
   gamer.messages    = [NSMutableArray arrayWithCapacity:10];
   [self.boards addObject:self.settings];
   [gamer loadView];
   [gamer release];

   NSLog(@"loading devil Dave...");
   gamer = [[GameController alloc] init];
   [(id)gamer setDelegate:self];
   [(id)gamer setDefaults:self.defaults];
   gamer.background  = Nil;
   gamer.foreground  = Nil;
   gamer.board       = Nil;
   gamer.messages    = [NSMutableArray arrayWithCapacity:10];
   [self.boards addObject:self.settings];
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
   self.board = [self.boards objectAtIndex:[sender tag]];
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
	//self.settings.view.userInteractionEnabled   = NO;
	//self.board.view.userInteractionEnabled      = NO;
   
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