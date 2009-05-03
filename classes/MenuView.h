/*
 *  Ask Dave
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
 *  @file classes/MenuView.h displayes the "Menu"
 */

///////////////
//           //
//  Headers  //
//           //
///////////////

#import <UIKit/UIKit.h>


/////////////////////////
//                     //
//  Class Definitions  //
//                     //
/////////////////////////


@interface MenuView : UIView
{
   id delegate;

   UIImage     * background;
   UIImage     * info;
   UIImage     * random;

   UIImageView * backgroundView;
   UIButton    * infoButton;
   UIButton    * randomButton;

   NSMutableArray * buttons;
}

@property(assign) id delegate;

@property(nonatomic, retain) UIImage * background;
@property(nonatomic, retain) UIImage * info;
@property(nonatomic, retain) UIImage * random;

@property(readonly) UIImageView  * backgroundView;
@property(readonly) UIButton     * infoButton;
@property(readonly) UIButton     * randomButton;

@property(readonly) NSMutableArray * buttons;

- (void)addButton:(UIImage *)anImage;

@end
