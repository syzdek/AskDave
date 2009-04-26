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
   CGRect              frame;
   UIView            * localView;
   //UILabel           * localLabel;
   UIButton          * localButton;
   UIImageView       * localImageView;
   //NSString          * path;
   NSAutoreleasePool * pool;
   
   pool = [[NSAutoreleasePool alloc] init];

   // load view
   localView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
   self.view = localView;
   [localView release];

   // loads background image view
   frame                      = CGRectMake(0.0, 0.0, 320, 480);
   localImageView             = [[UIImageView alloc] initWithFrame:frame];
   localImageView.image       = [UIImage imageNamed:@"menu.png"];;
   [self.view addSubview:localImageView];
   [localImageView release];

   // Add classic button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-290, 460-430, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 1;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add czombie button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-145, 460-430, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 2;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add classic button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-290, 460-300, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 3;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add czombie button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-145, 460-300, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 4;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add classic button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-290, 460-165, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 5;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add czombie button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-145, 460-165, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 6;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add 'i' button
   //localButton       = [UIButton buttonWithType:UIButtonTypeInfoLight];
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-76, 460-28, 45, 45);
   //localButton.backgroundColor = [UIColor yellowColor];
   [localButton addTarget:delegate action:@selector(showSettingsView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add 'random Dave' button
   //localButton       = [UIButton buttonWithType:UIButtonTypeInfoLight];
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(30, 480-50, 200, 50);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 0;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

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
	[super dealloc];
}


@end

/* end of source */
