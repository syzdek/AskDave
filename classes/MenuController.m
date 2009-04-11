//
//  MenuController.m
//  AskDave
//
//  Created by David Syzdek on 3/29/09.
//  Copyright 2009 David M. Syzdek. All rights reserved.
//

#import "MenuController.h"


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
   localButton.tag   = 0;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add czombie button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-145, 460-430, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 1;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add classic button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-290, 460-300, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 2;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add czombie button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-145, 460-300, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 3;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add classic button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-290, 460-165, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 4;
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // Add czombie button
   localButton       = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame = CGRectMake(320-145, 460-165, 115, 110);
   //localButton.backgroundColor = [UIColor yellowColor];
   localButton.tag   = 5;
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
   localButton.tag   = -1;
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
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc
{
	[super dealloc];
}


@end

/* end of source */
