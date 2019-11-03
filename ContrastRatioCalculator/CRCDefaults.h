//
//  CRCDefaults.h
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/10/12.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CRCColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface CRCDefaults : NSObject

+ (void)setColor:(CRCColor *)color forKey:(NSString *)name;

+ (void)removeColor:(CRCColor *)color;

+ (NSArray *)allColors;
+ (CRCColor *)colorForKey:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
