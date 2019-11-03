//
//  CRCDefaults.m
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/10/12.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import "CRCDefaults.h"

@interface CRCDefaults ()

+ (NSMutableDictionary *)colorsDictionary;

@end

@implementation CRCDefaults

+ (void)setColor:(CRCColor *)color forKey:(NSString *)name {
	
	if (![color isKindOfClass:[CRCColor class]] || name.length <= 0) {
		return;
	}
	
	NSMutableDictionary *dictionary = [self colorsDictionary];
	
	[dictionary setObject:color forKey:name];
	
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionary requiringSecureCoding:NO error:nil];
	[[NSUserDefaults standardUserDefaults] setObject:data forKey:@"COLORS"];
}

+ (void)removeColor:(CRCColor *)color {
	
	if (![color isKindOfClass:[CRCColor class]] || color.name.length <= 0) {
		return;
	}
	
	NSMutableDictionary *dictionary = [self colorsDictionary];
	[dictionary removeObjectForKey:color.name];
	
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionary requiringSecureCoding:NO error:nil];
	[[NSUserDefaults standardUserDefaults] setObject:data forKey:@"COLORS"];
}

+ (NSArray *)allColors {
	
	NSArray *colors = [CRCDefaults colorsDictionary].allValues;
	
	return [colors sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
		
		CRCColor *color1 = (CRCColor *)obj1;
		CRCColor *color2 = (CRCColor *)obj2;
		
		return [color1.date compare:color2.date];
	}];
}

+ (CRCColor *)colorForKey:(NSString *)name {
	
	if (name.length <= 0) {
		return nil;
	}
	
	NSMutableDictionary *dictionary = [self colorsDictionary];
	CRCColor *color = [dictionary objectForKey:name];
	
	return color;
}

+ (NSMutableDictionary *)colorsDictionary {
	
	NSMutableDictionary *dictionary;
	NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"COLORS"];
	
	if (data) {
		NSSet *classes = [NSSet setWithArray:@[[NSMutableDictionary class], [CRCColor class], [UIColor class], [NSDate class]]];
		dictionary = [NSKeyedUnarchiver unarchivedObjectOfClasses:classes fromData:data error:nil];
	}
	
	if (!dictionary) {
		dictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	}
	
	return dictionary;
}

@end
