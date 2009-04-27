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
#import "DaveView.h"


///////////////
//           //
//  Classes  //
//           //
///////////////

@implementation DaveView

@synthesize delegate;

@synthesize forceDataX;
@synthesize forceDataY;
@synthesize forceDataZ;

@synthesize background;
@synthesize board;
@synthesize foreground;
@synthesize info;
@synthesize menu;
@synthesize message;

@synthesize backgroundView;
@synthesize boardView;
@synthesize messageView;


- (id)initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame])
   {
      // create image views
      if (backgroundView  = [[UIImageView alloc] initWithFrame:frame]) [self addSubview:backgroundView];
      if (foregroundView  = [[UIImageView alloc] initWithFrame:frame]) [self addSubview:foregroundView];
      if (boardView       = [[UIImageView alloc] initWithFrame:frame]) [self addSubview:boardView];
      if (messageView     = [[UIImageView alloc] initWithFrame:frame]) [self addSubview:messageView];

      // create buttons
      if (infoButton = [UIButton buttonWithType:UIButtonTypeCustom])
      {
         infoButton.backgroundColor   = [UIColor clearColor];
         [self addSubview:infoButton];
      };
      if (menuButton = [UIButton buttonWithType:UIButtonTypeCustom])
      {
         menuButton.backgroundColor   = [UIColor clearColor];
         [self addSubview:menuButton];
      };

      // create debugging labels
      if (forceDataX = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 22.0)])
      {
         forceDataX.font            = [UIFont systemFontOfSize:17];
         forceDataX.backgroundColor = [UIColor clearColor];
         [self addSubview:forceDataX];
      };
      if (forceDataY = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 39.0, 280.0, 22.0)])
      {
         forceDataY.font            = [UIFont systemFontOfSize:17];
         forceDataY.backgroundColor = [UIColor clearColor];
         [self addSubview:forceDataY];
      };
      if (forceDataZ = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 60.0, 280.0, 22.0)])
      {
         forceDataZ.font            = [UIFont systemFontOfSize:17];
         forceDataZ.backgroundColor = [UIColor clearColor];
         [self addSubview:forceDataZ];
      };
   };

   return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc
{
   delegate = nil;

   forceDataX.text = nil;
   forceDataY.text = nil;
   forceDataZ.text = nil;

   [forceDataX release];
   [forceDataY release];
   [forceDataZ release];

   self.background  = nil;
   self.board       = nil;
   self.foreground  = nil;
   self.info        = nil;
   self.menu        = nil;
   self.message     = nil;

   [backgroundView   removeFromSuperview];
   [boardView        removeFromSuperview];
   [foregroundView   removeFromSuperview];
   [messageView      removeFromSuperview];

   backgroundView  = nil;
   boardView       = nil;
   foregroundView  = nil;
   messageView     = nil;

   [infoButton  removeFromSuperview];
   [menuButton  removeFromSuperview];

   infoButton  = nil;
   menuButton  = nil;

   [super dealloc];

   return;
}


- (void)setDelegate:(id)aValue
{
   delegate = aValue;
   [infoButton addTarget:delegate action:@selector(showAboutView:) forControlEvents:UIControlEventTouchUpInside];
   [menuButton addTarget:delegate action:@selector(showMenuView:)  forControlEvents:UIControlEventTouchUpInside];
   return;
}


- (void) setBackground:(UIImage *)anImage
{
   CGRect frame;

   [background release];
   background = [anImage retain];

   if (anImage)
   {
      frame.size.width  = anImage.size.width;
      frame.size.height = anImage.size.height;
   } else {
      frame.size.width  = 1;
      frame.size.height = 1;
   };
   frame.origin.x       = 0 - ((frame.size.width  - self.frame.size.width)/2);
   frame.origin.y       = 0 - ((frame.size.height - self.frame.size.height)/2);
   backgroundView.frame = frame;

   backgroundView.image = anImage;

   return;
}


- (void) setBoard:(UIImage *)anImage
{
   [board release];
   board = [anImage retain];
   boardView.image = anImage;
   return;
}


- (void) setForeground:(UIImage *)anImage
{
   [foreground release];
   foreground = [anImage retain];
   foregroundView.image = anImage;
   return;
}


- (void) setInfo:(UIImage *)anImage
{
   CGRect frame;

   [info release];
   info = [anImage retain];

   if (anImage)
   {
      frame.size.width  = anImage.size.width;
      frame.size.height = anImage.size.height;
   } else {
      frame.size.width  = 1;
      frame.size.height = 1;
   };
   frame.origin.x  = self.frame.size.width  - frame.size.width;
   frame.origin.y  = self.frame.size.height - frame.size.height;
   infoButton.frame = frame;
   
   [infoButton setBackgroundImage:anImage forState:UIControlStateNormal];

   return;
}


- (void) setMenu:(UIImage *)anImage
{
   CGRect frame;

   [menu release];
   menu = [anImage retain];

   if (anImage)
   {
      frame.size.width  = anImage.size.width;
      frame.size.height = anImage.size.height;
   } else {
      frame.size.width  = 1;
      frame.size.height = 1;
   };
   frame.origin.x  = 0;
   frame.origin.y  = self.frame.size.height - frame.size.height;
   menuButton.frame = frame;

   [menuButton setBackgroundImage:anImage forState:UIControlStateNormal];

   return;
}


- (void) setMessage:(UIImage *)anImage
{
   [message release];
   message = [anImage retain];
   messageView.image = anImage;
   return;
}

@end
/* end of source */

