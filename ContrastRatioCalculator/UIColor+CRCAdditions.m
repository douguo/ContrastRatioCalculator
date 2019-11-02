//
//  UIColor+CRCAdditions.m
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/9/24.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import "UIColor+CRCAdditions.h"

//static CGFloat kDarkColorThreshold = 0;

@implementation UIColor (CRCAdditions)

- (NSString *)crc_hexRepr {

	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
	
	[self getRed:&red green:&green blue:&blue alpha:&alpha];

	NSInteger integerRed = red * 255;
	NSInteger integerGreen = green * 255;
	NSInteger integerBlue = blue * 255;
	NSInteger integerAlpha = alpha * 255;

	return [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX", integerRed, integerGreen, integerBlue, integerAlpha];
}

- (CGFloat)crc_luminance {
	
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
	
	[self getRed:&red green:&green blue:&blue alpha:&alpha];
	
	// relative luminance : https://www.w3.org/TR/WCAG20/#relativeluminancedef
	
	red = red < 0.03928 ? red / 12.92 : powf((red + 0.055) / 1.055, 2.4);
	green = green < 0.03928 ? green / 12.92 : powf((green + 0.055) / 1.055, 2.4);
	blue = blue < 0.03928 ? blue / 12.92 : powf((blue + 0.055) / 1.055, 2.4);
	
	return 0.2126 * red + 0.7152 * green + 0.0722 * blue;
}

//- (BOOL)isDark {
//
//	if (kDarkColorThreshold <= 0) {
//		kDarkColorThreshold = sqrtf(1.05 * 0.05) - 0.05;
//	}
//
//	return self.crc_luminance < kDarkColorThreshold;
//}
- (CGFloat)crc_red {
	
	CGFloat red;
	
	[self getRed:&red green:nil blue:nil alpha:nil];
	
	return red;
}

- (CGFloat)crc_green {
	
	CGFloat green;
	
	[self getRed:nil green:&green blue:nil alpha:nil];
	
	return green;
}

- (CGFloat)crc_blue {
	
	CGFloat blue;
	
	[self getRed:nil green:nil blue:&blue alpha:nil];
	
	return blue;
}

- (CGFloat)crc_alpha {
	
	CGFloat alpha;
	
	[self getRed:nil green:nil blue:nil alpha:&alpha];
	
	return alpha;
}


- (UIColor *)crc_oppositeColor {
	
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
	
	[self getRed:&red green:&green blue:&blue alpha:&alpha];
	
	red = 1.0 - red;
	green = 1.0 - green;
	blue = 1.0 - blue;
	
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)crc_contrastRatioBetweenColor1:(UIColor *)color1 andColor2:(UIColor *)color2 {
	
	CGFloat luminance1 = color1.crc_luminance;
	CGFloat luminance2 = color2.crc_luminance;
	
	// contrast ratio : https://www.w3.org/TR/WCAG20/#contrast-ratiodef
	
	if (luminance1 > luminance2) { // color1 is brighter than color2
		
		return (luminance1 + 0.05) / (luminance2 + 0.05);
		
	} else {
		
		return (luminance2 + 0.05) / (luminance1 + 0.05);
	}
}

- (UIColor *)crc_visualOpaqueColorWithBackgroundColor:(UIColor *)color {
	
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
	
	[self getRed:&red green:&green blue:&blue alpha:&alpha];
	
	if (alpha >= 1.0) {
		return self;
	}
	
	CGFloat backgroundRed;
	CGFloat backgroundGreen;
	CGFloat backgroundBlue;
	CGFloat backgroundAlpha;
	
	[color getRed:&backgroundRed green:&backgroundGreen blue:&backgroundBlue alpha:&backgroundAlpha];
	
	if (backgroundAlpha < 1.0) {
		return nil;
	}
	
	red = red * alpha + backgroundRed * (1.0 - alpha);
	green = green * alpha + backgroundGreen * (1.0 - alpha);
	blue = blue * alpha + backgroundBlue * (1.0 - alpha);
	
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
