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
#import "DaveInfoView.h"


///////////////
//           //
//  Classes  //
//           //
///////////////

@implementation DaveInfoView

@synthesize delegate;
@synthesize about;


- (id)initWithFrame:(CGRect)frame
{
   CGRect newFrame;
   if (self = [super initWithFrame:frame])
   {
      if (aboutView = [[UIImageView alloc] initWithFrame:frame])
         [self addSubview:aboutView];
      if (button = [UIButton buttonWithType:UIButtonTypeCustom])
      {
         newFrame.size.width    = frame.size.width - 40;
         newFrame.size.height   = 60;
         newFrame.origin.x      = 20;
         newFrame.origin.y      = frame.size.height - newFrame.size.height - 25;
         button.frame           = newFrame;
         button.backgroundColor = [UIColor clearColor];
         [self addSubview:button];
      };
   }
   return(self);
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc
{
   delegate   = nil;
   self.about = nil;
   [aboutView removeFromSuperview];
   [button    removeFromSuperview];

   aboutView = nil;
   button    = nil;

   [super dealloc];
}


- (void)setDelegate:(id)aValue
{
   delegate = aValue;
   [button addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   return;
}


- (void) setAbout:(UIImage *)anImage
{
   [about release];
   about = [anImage retain];
   aboutView.image = anImage;
   return;
}

@end
/* end of source */
