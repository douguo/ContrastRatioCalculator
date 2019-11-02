//
//  CRCPaletteViewController.h
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/10/9.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRCColor.h"

#import "CRCDefaults.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CRCPaletteViewControllerDelegate;



typedef NS_ENUM(NSInteger, CRCPalettePhase) {
    CRCPalettePhase1,	// opposite color label + target color background
    CRCPalettePhase2,	// target color label + opposite color background
};

@interface CRCPaletteViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id<CRCPaletteViewControllerDelegate> delegate;

@property (nonatomic) CRCPalettePhase phase;

@property (nonatomic, strong) CRCColor *color;

@property (nonatomic, weak) IBOutlet UIView *colorView;

@property (nonatomic, weak) IBOutlet UILabel *colorValueLabel;

@property (nonatomic, weak) IBOutlet UILabel *rNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *gNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *bNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *aNameLabel;

@property (nonatomic, weak) IBOutlet UISlider *rSlider;
@property (nonatomic, weak) IBOutlet UISlider *gSlider;
@property (nonatomic, weak) IBOutlet UISlider *bSlider;
@property (nonatomic, weak) IBOutlet UISlider *aSlider;

@property (nonatomic, weak) IBOutlet UILabel *rValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *gValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *bValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *aValueLabel;

- (IBAction)cancelItemTapped:(id)sender;
- (IBAction)doneItemTapped:(id)sender;

- (IBAction)tapped:(id)sender;

- (IBAction)rSliderChanged:(UISlider *)slider;
- (IBAction)gSliderChanged:(UISlider *)slider;
- (IBAction)bSliderChanged:(UISlider *)slider;
- (IBAction)aSliderChanged:(UISlider *)slider;

@end



@protocol CRCPaletteViewControllerDelegate <NSObject>

- (void)paletteViewController:(CRCPaletteViewController *)controller didAddColor:(CRCColor *)color;
- (void)paletteViewController:(CRCPaletteViewController *)controller didEditColor:(CRCColor *)color;

@end

NS_ASSUME_NONNULL_END
