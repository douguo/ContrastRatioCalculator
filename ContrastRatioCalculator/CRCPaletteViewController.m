//
//  CRCPaletteViewController.m
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/10/9.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import "CRCPaletteViewController.h"

#import "UIColor+CRCAdditions.h"

@interface CRCPaletteViewController ()

@property (nonatomic, weak) UIAlertController *alert;

@end

@implementation CRCPaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (!self.color) {
		self.color = [[CRCColor alloc] initWithUIColor:[UIColor systemBackgroundColor]];
	}
	
	self.rSlider.value = self.color.color.crc_red * 255.0;
	self.gSlider.value = self.color.color.crc_green * 255.0;
	self.bSlider.value = self.color.color.crc_blue * 255.0;
	
	[self updateColorView];
}

- (void)cancelItemTapped:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:^{
		
	}];
}

- (void)doneItemTapped:(id)sender {
	
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Name your color"
																   message:nil
															preferredStyle:UIAlertControllerStyleAlert];
	
	[alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		
		textField.delegate = self;
		textField.text = self.color.name.length > 0 ? self.color.name : self.colorValueLabel.text;
	}];
	
	[alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
											  style:UIAlertActionStyleCancel
											handler:^(UIAlertAction * _Nonnull action) {
		
	}]];
	
	[alert addAction:[UIAlertAction actionWithTitle:@"OK"
											  style:UIAlertActionStyleDefault
											handler:^(UIAlertAction * _Nonnull action) {
		
		UITextField *textField = alert.textFields.firstObject;
		
		BOOL isEditing = self.color.date != nil;
		BOOL isSystemColorName = !isEditing && [self.color.name isEqualToString:textField.text];
		
		if (isEditing) {
			[CRCDefaults removeColor:self.color];
		}
		
		self.color.name = textField.text;
		self.color.date = [NSDate now];
		
		BOOL writed = [CRCDefaults setColor:self.color forKey:self.color.name overwrite:NO];
		
		if (!writed || isSystemColorName) {
			
			UIAlertController *anotherAlert = [UIAlertController alertControllerWithTitle:@"Color already exists"
																				  message:nil
																		   preferredStyle:UIAlertControllerStyleAlert];
			
			[anotherAlert addAction:[UIAlertAction actionWithTitle:@"OK"
															 style:UIAlertActionStyleCancel
														   handler:nil]];
			
			[self presentViewController:anotherAlert animated:YES completion:nil];
			
			return;
		}
		
		[self dismissViewControllerAnimated:YES completion:^{
			
			if (isEditing) {
				[self.delegate paletteViewController:self didEditColor:self.color];
			} else {
				[self.delegate paletteViewController:self didAddColor:self.color];
			}
		}];
	}]];
	
	self.alert = alert;
	
	[self presentViewController:alert animated:YES completion:^{
		
	}];
}

- (void)tapped:(id)sender {
	
	if (self.phase == CRCPalettePhase1) {
		self.phase = CRCPalettePhase2;
	} else if (self.phase == CRCPalettePhase2) {
		self.phase = CRCPalettePhase1;
	}
	
	[self updateColorView];
}

- (void)rSliderChanged:(UISlider *)slider {
	
	[self updateColorView];
}

- (void)gSliderChanged:(UISlider *)slider {
	
	[self updateColorView];
}

- (void)bSliderChanged:(UISlider *)slider {
	
	[self updateColorView];
}

- (void)aSliderChanged:(UISlider *)slider {
	
	[self updateColorView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - private

- (void)updateColorView {
	
	self.rValueLabel.text = [NSString stringWithFormat:@"%.3d", (int)self.rSlider.value];
	self.gValueLabel.text = [NSString stringWithFormat:@"%.3d", (int)self.gSlider.value];
	self.bValueLabel.text = [NSString stringWithFormat:@"%.3d", (int)self.bSlider.value];
	self.aValueLabel.text = [NSString stringWithFormat:@"%.3d", (int)self.aSlider.value];
	
	CGFloat r = self.rValueLabel.text.floatValue / 255.0;
	CGFloat g = self.gValueLabel.text.floatValue / 255.0;
	CGFloat b = self.bValueLabel.text.floatValue / 255.0;
	CGFloat a = self.aValueLabel.text.floatValue / 255.0;
	
	UIColor *targetColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
	UIColor *oppositeColor = targetColor.crc_oppositeColor;
	
	self.colorValueLabel.text = targetColor.crc_hexRepr;
	
	
	
	UIColor *labelColor;
	UIColor *backgroundColor;
	
	if (self.phase == CRCPalettePhase1) {
		
		labelColor = oppositeColor;
		backgroundColor = targetColor;
		
	} else if (self.phase == CRCPalettePhase2) {
		
		labelColor = targetColor;
		backgroundColor = oppositeColor;
		
	} else {
		
		labelColor = [UIColor labelColor];
		backgroundColor = [UIColor systemBackgroundColor];
	}
	
	self.colorView.backgroundColor = backgroundColor;
	
	self.colorValueLabel.textColor = labelColor;
	
	self.rNameLabel.textColor = labelColor;
	self.gNameLabel.textColor = labelColor;
	self.bNameLabel.textColor = labelColor;
	self.aNameLabel.textColor = labelColor;
	
	self.rValueLabel.textColor = labelColor;
	self.gValueLabel.textColor = labelColor;
	self.bValueLabel.textColor = labelColor;
	self.aValueLabel.textColor = labelColor;
	
	
	
//	self.color = [[CRCColor alloc] initWithUIColor:targetColor];
	self.color.color = targetColor;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	UIAlertAction *action = self.alert.actions.lastObject;
	NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
	
	action.enabled = text.length > 0;
	
	return YES;
}

@end
