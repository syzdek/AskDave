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
 *  @file classes/DaveView.h displayes the "Dave"
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


@interface DaveView : UIView
{
   id delegate;

   UILabel     * forceDataX;
   UILabel     * forceDataY;
   UILabel     * forceDataZ;

   UIImage     * background;
   UIImage     * board;
   UIImage     * foreground;
   UIImage     * info;
   UIImage     * menu;
   UIImage     * message;

   UIImageView * backgroundView;
   UIImageView * boardView;
   UIImageView * foregroundView;
   UIImageView * messageView;

   UIButton    * menuButton;
   UIButton    * infoButton;
}

@property(assign) id delegate;

@property(readonly) UILabel * forceDataX;
@property(readonly) UILabel * forceDataY;
@property(readonly) UILabel * forceDataZ;

@property(nonatomic, retain) UIImage * background;
@property(nonatomic, retain) UIImage * board;
@property(nonatomic, retain) UIImage * foreground;
@property(nonatomic, retain) UIImage * info;
@property(nonatomic, retain) UIImage * menu;
@property(nonatomic, retain) UIImage * message;

@property(readonly) UIImageView * backgroundView;
@property(readonly) UIImageView * boardView;
@property(readonly) UIImageView * messageView;

@end
