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
 *  @file classes/SettingsController.m controls settings/info display
 */

///////////////
//           //
//  Headers  //
//           //
///////////////

#import "common.h"
#import "SettingsController.h"

///////////////
//           //
//  Classes  //
//           //
///////////////

@implementation SettingsController

@synthesize delegate;
@synthesize shakeSwitch;
@synthesize flipSwitch;
@synthesize vibrateSwitch;
@synthesize soundSwitch;
@synthesize defaults;


// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView
{
   CGRect              frame;
   UIView            * localView;
   UIImageView       * localImageView;
   UIButton          * localButton;
   NSAutoreleasePool * pool;
   
   pool = [[NSAutoreleasePool alloc] init];
   
   // load view
   localView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
   //localView.backgroundColor = [UIColor grayColor];
   self.view                 = localView;
   [localView release];

   // loads background image view
   frame                      = CGRectMake(0.0, 0.0, 320, 480);
   localImageView             = [[UIImageView alloc] initWithFrame:frame];
   localImageView.image       = [UIImage imageNamed:@"settings.png"];;
   [self.view addSubview:localImageView];
   [localImageView release];


   // add BindleBinary logo and link
   localButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame           = CGRectMake(0, 480 - (480/2), 320, (480/2));
   localButton.backgroundColor = [UIColor clearColor];
   [localButton addTarget:self action:@selector(openBlogger:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   localButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame           = CGRectMake(0, 480 - (480/4), 320, (480/4));
   localButton.backgroundColor = [UIColor clearColor];
   [localButton addTarget:self action:@selector(openDeveloper:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];
   // add done button
   localButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame           = CGRectMake(0, 0, 320, 480/2);
   localButton.backgroundColor = [UIColor clearColor];
   [localButton addTarget:delegate action:@selector(showMenuView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];
   
   [pool release];
   
   return;
}


/*
 If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
}
 */


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
   NSLog(@"SettingsController received memory warning.");
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}


- (void)dealloc {
	[super dealloc];
}


- (void) openBlogger:(id)sender
{
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.blogography.com/"]];
   return;
}


- (void) openDeveloper:(id)sender
{
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://support.bindlebinaries.net/projects/show/askdave"]];
   return;
}


- (void) updateShakePref:(id)sender
{
   if (self.shakeSwitch.on)
   {
      self.flipSwitch.on = NO;
      [self.defaults setObject:@"YES" forKey:@"shake"];
      [self.defaults setObject:@"NO"  forKey:@"flip"];
   } else {
      self.flipSwitch.on = YES;
      [self.defaults setObject:@"NO"  forKey:@"shake"];
      [self.defaults setObject:@"YES" forKey:@"flip"];
   };
   [self.defaults synchronize];
   return;
}


- (void) updateFlipPref:(id)sender
{
   if (self.flipSwitch.on)
   {
      self.shakeSwitch.on = NO;
      [self.defaults setObject:@"NO"  forKey:@"shake"];
      [self.defaults setObject:@"YES" forKey:@"flip"];
   } else {
      self.shakeSwitch.on = YES;
      [self.defaults setObject:@"YES" forKey:@"shake"];
      [self.defaults setObject:@"NO"  forKey:@"flip"];
   };
   [self.defaults synchronize];
   return;
}


- (void) updateVibratePref:(id)sender
{
   if (self.vibrateSwitch.on)
      [self.defaults setObject:@"YES" forKey:@"vibrate"];
   else
      [self.defaults setObject:@"NO"  forKey:@"vibrate"];
   [self.defaults synchronize];
   return;
}


- (void) updateSoundPref:(id)sender
{
   if (self.soundSwitch.on)
      [self.defaults setObject:@"YES" forKey:@"sound"];
   else
      [self.defaults setObject:@"NO"  forKey:@"sound"];
   [self.defaults synchronize];
printf("got here\n");
   return;
}


@end
