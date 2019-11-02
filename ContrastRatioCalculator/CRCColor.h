//
//  CRCColor.h
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/10/11.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+CRCAdditions.h"

NS_ASSUME_NONNULL_BEGIN

@interface CRCColor : NSObject <NSCopying, NSSecureCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *date; // created time
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, readonly) NSString *rgbaValue;
@property (nonatomic, readonly) NSString *hsbaValue;
@property (nonatomic, readonly) NSString *hexadecimalRepresentation;

+ (instancetype)colorWithPaletteName:(NSString *)name;
- (instancetype)initWithUIColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
