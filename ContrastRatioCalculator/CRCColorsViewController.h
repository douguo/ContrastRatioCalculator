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

@property (weak, nonatomic) CRCColor *color;
@property (weak, nonatomic) CRCColor *secondaryColor;

@property (nonatomic) BOOL allowsMultipleSelection;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *multiSelectionItem;

- (IBAction)multiSelectionItemTapped:(UIBarButtonItem *)item;

@end
