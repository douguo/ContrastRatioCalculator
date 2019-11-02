//
//  CRCRatioViewController.h
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/9/24.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRCColor.h"

typedef NS_ENUM(NSInteger, CRCPresentationPhase) {
    CRCPresentationPhase1,	// label-color label + target color background
    CRCPresentationPhase2,	// opposite-label-color label + target color background
    CRCPresentationPhase3,	// target color label + background-color background
	CRCPresentationPhase4	// target color label + opposite-background-color background
};

@interface CRCRatioViewController : UIViewController

@property (strong, nonatomic) CRCColor *color;

@property (nonatomic) CRCPresentationPhase phase;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UILabel *colorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorDescriptionLabel;

- (IBAction)tapped:(id)sender;

@end
