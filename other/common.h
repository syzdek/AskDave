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
 *  @file other/common.h common directives
 */

///////////////////
//               //
//  Definitions  //
//               //
///////////////////

// Constant for the number of times per second (Hertz) to sample acceleration.
#define ENABLE_ACCELEROMETER        1
#define kAccelerometerFrequency     10
#define kTimerFrequency             10.0
#define kAccelerometerForce         .75
#define kAccelerometerToDegrees     15
#define kSpeedMagnitude             100
#define kDurationMagnitude          0.2
#define kMaxDuration                10.0

// defines menu margins
#define kMenuLeftMargin             17
#define kMenuRightMargin            17
#define kMenuTopMargin              15
#define kMenuBottonMargin           0

#define kDaveAny                     0
#define kDaveClassic                 1
#define kDaveZombie                  2
#define kDaveNirvana                 3
#define kDaveGeeky                   4
#define kDavePirate                  5
#define kDaveDevil                   6

/* end of header */
