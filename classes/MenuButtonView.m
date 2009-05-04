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
 *  @file classes/MenuButtonView.m displayes the "Menu"
 */

///////////////
//           //
//  Headers  //
//           //
///////////////

#import "common.h"
#import "MenuButtonView.h"


///////////////
//           //
//  Classes  //
//           //
///////////////

@implementation MenuButtonView

@synthesize delegate;

@synthesize inCenter;
@synthesize outCenter;

@synthesize image;

- (void)dealloc
{
   self.delegate = nil;
   self.image    = nil;
   [super dealloc];
}

- (void)setDelegate:(id)aValue
{
   delegate = aValue;
   [self addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   return;
}


- (void)setImage:(UIImage *)anImage
{
   [image release];
   image = [anImage retain];

   [self setBackgroundImage:anImage forState:UIControlStateNormal];

   self.tag = self.tag;

   return;
}


- (void)setTag:(NSInteger)aTag
{
   CGRect frame;

   [super setTag:aTag];

   if ( (!(self.tag)) || (!(image)) )
      return;

   switch(self.tag)
   {
      case kDaveClassic:
         // * - - -
         // - * O -
         // - O O -
         // - O O -
         // - - - -
         inCenter.x  = 0                     + (image.size.width/2)  + kMenuRightMargin;
         inCenter.y  = (image.size.height*0) + (image.size.height/2) + kMenuTopMargin;
         outCenter.x = 0                     - (image.size.width);
         outCenter.y = 0                     - (image.size.height);
         break;
      case kDaveNirvana:
         // - - - -
         // - O O -
         // * * O -
         // - O O -
         // - - - -
         inCenter.x  = 0                     + (image.size.width/2)  + kMenuRightMargin;
         inCenter.y  = (image.size.height*1) + (image.size.height/2) + kMenuTopMargin;
         outCenter.x = 0                     - (image.size.width);
         outCenter.y = (image.size.height*1) + (image.size.height/2) + kMenuTopMargin;
         break;
      case kDavePirate:
         // - - - -
         // - O O -
         // - O O -
         // - * O -
         // * - - -
         inCenter.x  = 0                     + (image.size.width/2)  + kMenuRightMargin;
         inCenter.y  = (image.size.height*2) + (image.size.height/2) + kMenuTopMargin;
         outCenter.x = 0                     - (image.size.width);
         outCenter.y = (image.size.height*3) + (image.size.height/2) + kMenuTopMargin;
         break;

      case kDaveZombie:
         // - - - *
         // - O * -
         // - O O -
         // - O O -
         // - - - -
         inCenter.x  = 320                   - (image.size.width/2)  - kMenuRightMargin;
         inCenter.y  = (image.size.height*0) + (image.size.height/2) + kMenuTopMargin;
         outCenter.x = 320                   + (image.size.width/2);
         outCenter.y = 0                     - (image.size.height);
         break;
      case kDaveGeeky:
         // - - - -
         // - O O -
         // - O * *
         // - O O -
         // - - - -
         inCenter.x  = 320                   - (image.size.width/2)  - kMenuRightMargin;
         inCenter.y  = (image.size.height*1) + (image.size.height/2) + kMenuTopMargin;
         outCenter.x = 320                   + (image.size.width/2);
         outCenter.y = (image.size.height*1) + (image.size.height/2) + kMenuTopMargin;
         break;
      case kDaveDevil:
         // - - - -
         // - O O -
         // - O O -
         // - O * -
         // - - - *
         inCenter.x  = 320                   - (image.size.width/2)  - kMenuRightMargin;
         inCenter.y  = (image.size.height*2) + (image.size.height/2) + kMenuTopMargin;
         outCenter.x = 320                   + (image.size.width/2);
         outCenter.y = (image.size.height*3) + (image.size.height/2) + kMenuTopMargin;
         break;

      default:
         break;
   };

   frame.size = image.size;
   frame.origin.x = inCenter.x - (image.size.width/2);
   frame.origin.y = inCenter.y - (image.size.height/2);
   self.frame = frame;

   return;
}

@end
