//
//  CRCColor.m
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/10/11.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import "CRCColor.h"

#import "CRCDefaults.h"

@interface CRCColor ()

@end

@implementation CRCColor

+ (BOOL)supportsSecureCoding {
	return YES;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super init];
	if (self) {
		self.name = [coder decodeObjectForKey:@"name"];
		self.date = [coder decodeObjectForKey:@"date"];
		self.color = [coder decodeObjectForKey:@"color"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.name forKey:@"name"];
	[coder encodeObject:self.date forKey:@"date"];
	[coder encodeObject:self.color forKey:@"color"];
}

+ (instancetype)colorWithPaletteName:(NSString *)name {
	
	CRCColor *color;
	SEL selector = NSSelectorFromString(name);
	
	if ([UIColor respondsToSelector:selector]) {
		
		color = [CRCColor new];
		
		color.name = name;
		color.color = [UIColor performSelector:selector];
		
	} else {
		
		color = [CRCDefaults colorForKey:name];
	}
	
	return color;
}

- (instancetype)initWithUIColor:(UIColor *)color {
	
	self = [super init];
	
	if (self) {
		self.color = color;
	}
	
	return self;
}

- (NSString *)name {
	
	if (_name) {
		return _name;
	}
	
	NSString *name = self.description;
	
	NSString *prefix = @"name = ";
	NSUInteger index = [name rangeOfString:prefix].location;
	
	if (index == NSNotFound) {
		return nil;
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
	
	_name = name;
	
	return _name;
}

- (NSString *)rgbaValue {
	
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
	
	[self.color getRed:&red green:&green blue:&blue alpha:&alpha];
	
	return [NSString stringWithFormat:@"red:%0.2f green:%0.2f blue:%0.2f alpha:%0.2f", red, green, blue, alpha];
}

- (NSString *)hsbaValue {
	
	CGFloat hue;
	CGFloat saturation;
	CGFloat brightness;
	CGFloat alpha;
	
	[self.color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
	
	return [NSString stringWithFormat:@"hue:%0.2f sat:%0.2f bri:%0.2f alpha:%0.2f", hue, saturation, brightness, alpha];
}

- (NSString *)hexadecimalRepresentation {
	
	return self.color.crc_hexRepr;
}

- (id)copyWithZone:(NSZone *)zone {
	
	CRCColor *color = [[CRCColor alloc] init];
	
	color.name = [self.name copy];
	color.date = [self.date copy];
	color.color = [self.color copy];
	
	return color;
}

@end
