//
//  CRCRatioViewController.h
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/9/24.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRCColor.h"

#import "CRCDefaults.h"

#import "CRCRatioViewController.h"
#import "CRCPaletteViewController.h"

@class CRCRatioViewController;

@interface CRCColorsViewController : UITableViewController <CRCPaletteViewControllerDelegate>

@property (strong, nonatomic) CRCRatioViewController *detailViewController;

@end
