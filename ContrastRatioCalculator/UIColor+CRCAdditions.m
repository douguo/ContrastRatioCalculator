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

- (NSString *)crc_name {
	
	NSString *name = self.description;
	
	NSString *prefix = @"name = ";
	NSUInteger index = [name rangeOfString:prefix].location;
	
	if (index == NSNotFound) {
		return @"unnamedColor";
	}
	
	index += prefix.length;
	if (index < name.length) {
		name = [name substringFromIndex:index];
	}
	
	NSString *suffix = @">";
	index = [name rangeOfString:suffix].location;
	if (index < name.length) {
		name = [name substringToIndex:index];
	}
	
	return name;
}

- (NSString *)crc_rgbaValue {
	
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
	
	[self getRed:&red green:&green blue:&blue alpha:&alpha];
	
	return [NSString stringWithFormat:@"red:%0.2f green:%0.2f blue:%0.2f alpha:%0.2f", red, green, blue, alpha];
}

- (NSString *)crc_hsbaValue {
	
	CGFloat hue;
	CGFloat saturation;
	CGFloat brightness;
	CGFloat alpha;
	
	[self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
	
	return [NSString stringWithFormat:@"hue:%0.2f sat:%0.2f bri:%0.2f alpha:%0.2f", hue, saturation, brightness, alpha];
}

- (NSString *)crc_hexValue {
	
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
