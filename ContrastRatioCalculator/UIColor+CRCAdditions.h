//
//  UIColor+CRCAdditions.h
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/9/24.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CRCAdditions)

@property (nonatomic, readonly) NSString *crc_hexRepr;

@property (nonatomic, readonly) CGFloat crc_red;
@property (nonatomic, readonly) CGFloat crc_green;
@property (nonatomic, readonly) CGFloat crc_blue;
@property (nonatomic, readonly) CGFloat crc_alpha;
@property (nonatomic, readonly) CGFloat crc_luminance;

@property (nonatomic, readonly) UIColor *crc_oppositeColor;

+ (CGFloat)crc_contrastRatioBetweenColor1:(UIColor *)color1 andColor2:(UIColor *)color2;

- (UIColor *)crc_visualOpaqueColorWithBackgroundColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
