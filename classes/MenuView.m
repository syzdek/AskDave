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
 *  @file classes/MenuView.m displayes the "Menu"
 */

///////////////
//           //
//  Headers  //
//           //
///////////////

#import "common.h"
#import "MenuView.h"
#import "MenuButtonView.h"


///////////////
//           //
//  Classes  //
//           //
///////////////

@implementation MenuView

@synthesize delegate;

@synthesize background;
@synthesize info;
@synthesize random;

@synthesize backgroundView;
@synthesize infoButton;
@synthesize randomButton;

@synthesize buttons;


- (id)initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame])
   {
      if (backgroundView = [[UIImageView alloc] initWithFrame:frame])
         [self addSubview:backgroundView];
      if (randomButton = [UIButton buttonWithType:UIButtonTypeCustom])
      {
         frame.size.width               = 219;
         frame.size.height              = 52;
         frame.origin.x                 = kMenuLeftMargin;
         frame.origin.y                 = self.frame.size.height - 52 - kMenuBottonMargin;
         randomButton.frame             = frame;
         randomButton.backgroundColor   = [UIColor clearColor];
         [self addSubview:randomButton];
      };
      if (infoButton = [UIButton buttonWithType:UIButtonTypeCustom])
      {
         frame.size.width             = 67;
         frame.size.height            = 52;
         frame.origin.x               = self.frame.size.width - 67 - kMenuRightMargin;
         frame.origin.y               = self.frame.size.height - 52 - kMenuBottonMargin;
         infoButton.frame             = frame;
         infoButton.backgroundColor   = [UIColor clearColor];
         [self addSubview:infoButton];
      };
      buttons = [[NSMutableArray alloc] initWithCapacity:6];
   };
   return(self);
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc
{
   int i;

   delegate = nil;

   self.background  = nil;
   self.info        = nil;
   self.random      = nil;

   [backgroundView removeFromSuperview];
   [infoButton     removeFromSuperview];
   [randomButton   removeFromSuperview];

   backgroundView = nil;
   infoButton     = nil;
   randomButton   = nil;

   for(i = 0; i < [buttons count]; i++)
      [[buttons objectAtIndex:i] removeFromSuperview];
   buttons = nil;

   [super dealloc];
}


- (void)addButton:(UIImage *)anImage tag:(NSInteger)aTag
{
   //CGRect           frame;
   MenuButtonView * button;

   if (button = [MenuButtonView buttonWithType:UIButtonTypeCustom])
   {
         button.backgroundColor   = [UIColor clearColor];
         button.tag               = aTag;
         button.image             = anImage;
         button.delegate          = delegate;
         [buttons addObject:button];
         [self    addSubview:button];
   };

   return;
}


- (void)setDelegate:(id)aValue
{
   int i;
   delegate = aValue;
   for(i = 0; i < [buttons count]; i++)
      [[buttons objectAtIndex:i] setDelegate:delegate];
   [infoButton   addTarget:delegate action:@selector(showSettingsView:) forControlEvents:UIControlEventTouchUpInside];
   [randomButton addTarget:delegate action:@selector(showBoardView:)    forControlEvents:UIControlEventTouchUpInside];
   return;
}


- (void)setBackground:(UIImage *)anImage
{
   [background release];
   background = [anImage retain];
   backgroundView.image = anImage;
   return;
}

- (void)setInfo:(UIImage *)anImage
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
   frame.origin.x  = self.frame.size.width  - frame.size.width - 17;
   frame.origin.y  = self.frame.size.height - frame.size.height;
   infoButton.frame = frame;
   
   [infoButton setBackgroundImage:anImage forState:UIControlStateNormal];

   return;
}

- (void) setRandom:(UIImage *)anImage
{
   CGRect frame;

   [random release];
   random = [anImage retain];

   if (anImage)
   {
      frame.size.width  = anImage.size.width;
      frame.size.height = anImage.size.height;
   } else {
      frame.size.width  = 1;
      frame.size.height = 1;
   };
   frame.origin.x  = 17;
   frame.origin.y  = self.frame.size.height - frame.size.height;
   randomButton.frame = frame;

   [randomButton setBackgroundImage:anImage forState:UIControlStateNormal];

   return;
}

@end
