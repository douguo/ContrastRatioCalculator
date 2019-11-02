//
//  CRCRatioViewController.m
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/9/24.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import "CRCRatioViewController.h"

// Human Interface Guidelines - Accessibility - Color and Contrast
// https://developer.apple.com/design/human-interface-guidelines/accessibility/overview/color-and-contrast/

@interface CRCRatioViewController ()

@end

@implementation CRCRatioViewController

- (void)configureView {
	
	if (!self.color) {
		
		self.colorNameLabel.text = @"";
		self.colorValueLabel.text = @"";
		self.colorDescriptionLabel.text = @"";
		
		return;
	}
	
	UIColor *textColor;
	UIColor *backgroundColor;
	
	if (self.phase == CRCPresentationPhase1) {
		
		textColor = [UIColor labelColor];
		backgroundColor = self.color.color;
		
	} else if (self.phase == CRCPresentationPhase2) {
		
		textColor = [UIColor labelColor].crc_oppositeColor;
		backgroundColor = self.color.color;
		
	} else if (self.phase == CRCPresentationPhase3) {
		
		textColor = self.color.color;
		backgroundColor = [UIColor systemBackgroundColor];
		
	} else if (self.phase == CRCPresentationPhase4) {
		
		textColor = self.color.color;
		backgroundColor = [UIColor systemBackgroundColor].crc_oppositeColor;
	}
	
	self.colorNameLabel.textColor = textColor;
	self.colorValueLabel.textColor = textColor;
	self.colorDescriptionLabel.textColor = textColor;
	
	self.backgroundView.backgroundColor = backgroundColor;
	
	
	
	BOOL isTextColorTranslucent = textColor.crc_alpha < 1.0;
	BOOL isBackgroundColorTranslucent = backgroundColor.crc_alpha < 1.0;
	BOOL isTargetColorTranslucent = self.color.color.crc_alpha < 1.0;
	
	CGFloat ratio;
	UIColor *visualColor;
	
	if (isTextColorTranslucent && isBackgroundColorTranslucent) {
		
		self.colorDescriptionLabel.text = @"serious?";
		ratio = 0;
		
	} else if (isBackgroundColorTranslucent) {
		
		visualColor = [backgroundColor crc_visualOpaqueColorWithBackgroundColor:self.view.backgroundColor];
		ratio = [UIColor crc_contrastRatioBetweenColor1:textColor andColor2:visualColor];
		
		UIColor *visualColorOnBlack = [backgroundColor crc_visualOpaqueColorWithBackgroundColor:[UIColor blackColor]];
		UIColor *visualColorOnWhite = [backgroundColor crc_visualOpaqueColorWithBackgroundColor:[UIColor whiteColor]];
		
		CGFloat ratioOnBlack = [UIColor crc_contrastRatioBetweenColor1:textColor andColor2:visualColorOnBlack];
		CGFloat ratioOnWhite = [UIColor crc_contrastRatioBetweenColor1:textColor andColor2:visualColorOnWhite];
		
		NSString *description = @"it's a translucent background color\n";
		description = [description stringByAppendingString:@"so the contrast ratio cannot be precise\n"];
		description = [description stringByAppendingString:@"it depends on what's underneath\n"];
		description = [description stringByAppendingFormat:@"it will be %0.2f : 1 on black color\n", ratioOnBlack];
		description = [description stringByAppendingFormat:@"and %0.2f : 1 on white color", ratioOnWhite];
		
		self.colorDescriptionLabel.text = description;
		
	} else if (isTextColorTranslucent) {
		
		visualColor = [textColor crc_visualOpaqueColorWithBackgroundColor:backgroundColor];
		ratio = [UIColor crc_contrastRatioBetweenColor1:visualColor andColor2:backgroundColor];
		
		NSString *description = @"it's a translucent text color";
		self.colorDescriptionLabel.text = description;
		
	} else {
		
		ratio = [UIColor crc_contrastRatioBetweenColor1:textColor andColor2:backgroundColor];
		self.colorDescriptionLabel.text = @"";
	}
	
	NSString *format = ratio < 10 ? @"%.3g : 1" : @"%.4g : 1";
	self.colorNameLabel.text = [NSString stringWithFormat:format, ratio];
	
	
	
	NSString *value = [NSString stringWithFormat:@"%@\n", self.color.name];
	
	if (!isTargetColorTranslucent) {
		
		value = [value stringByAppendingFormat:@"%@\n", self.color.hexadecimalRepresentation];
		value = [value stringByAppendingFormat:@"luminance: %.2f\n", self.color.color.crc_luminance];
		
	} else {
		
		value = [value stringByAppendingFormat:@"%@ (visually %@)\n", self.color.hexadecimalRepresentation, visualColor.crc_hexRepr];
		value = [value stringByAppendingFormat:@"luminance: %.2f (ignoring its alpha)\n", self.color.color.crc_luminance];
	}
	
	value = [value stringByAppendingFormat:@"%@\n", self.color.rgbaValue];
	value = [value stringByAppendingFormat:@"%@", self.color.hsbaValue];
	
	self.colorValueLabel.text = value;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self configureView];
}

#pragma mark - Managing the detail item

- (void)setColor:(CRCColor *)color {
	
	if (_color != color) {
	    _color = color;
	    
	    [self configureView];
	}
}

- (void)tapped:(id)sender {
	
	if (self.phase == CRCPresentationPhase1) {
		self.phase = CRCPresentationPhase2;
	} else if (self.phase == CRCPresentationPhase2) {
		self.phase = CRCPresentationPhase3;
	} else if (self.phase == CRCPresentationPhase3) {
		self.phase = CRCPresentationPhase4;
	} else if (self.phase == CRCPresentationPhase4) {
		self.phase = CRCPresentationPhase1;
	}
	
	[self configureView];
}

@end
