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
 *  @file classes/MenuController.m controls menu display
 */

///////////////
//           //
//  Headers  //
//           //
///////////////

#import "common.h"
#import "MenuView.h"
#import "MenuButtonView.h"
#import "MenuController.h"


///////////////
//           //
//  Classes  //
//           //
///////////////

@implementation MenuController

@synthesize defaults;
@synthesize delegate;

// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView
{
   NSAutoreleasePool * pool;
   
   pool = [[NSAutoreleasePool alloc] init];

   // load view
   menu            = [[MenuView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
   menu.delegate   = delegate;
   menu.background = [UIImage imageNamed:@"Default.png"];
   menu.info       = [UIImage imageNamed:@"Button_Info.png"];
   menu.random     = [UIImage imageNamed:@"Button_AskDave.png"];
   [menu addButton:[UIImage imageNamed:@"Dave_Classic.png"] tag:kDaveClassic];
   [menu addButton:[UIImage imageNamed:@"Dave_Zombie.png"]  tag:kDaveZombie];
   [menu addButton:[UIImage imageNamed:@"Dave_Nirvana.png"] tag:kDaveNirvana];
   [menu addButton:[UIImage imageNamed:@"Dave_Geeky.png"]   tag:kDaveGeeky];
   [menu addButton:[UIImage imageNamed:@"Dave_Pirate.png"]  tag:kDavePirate];
   [menu addButton:[UIImage imageNamed:@"Dave_Devil.png"]   tag:kDaveDevil];

   self.view = menu;

   [pool release];
   
   return;
}


// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad
{
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
	 NSLog(@"MenuController received memory warning.");
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}


- (void)dealloc
{
   self.delegate = nil;
   self.defaults = nil;
   [menu release];
	[super dealloc];
}


@end

/* end of source */
