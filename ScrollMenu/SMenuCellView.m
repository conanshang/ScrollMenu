//
//  SMenuCellView.m
//  ScrollMenu
//
//  Created by conans on 3/2/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import "SMenuCellView.h"

@implementation SMenuCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Background Image View.
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 340, 66)];
        self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.backgroundImageView];
        
        //Icon Image View.
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(19, 19, 27, 27)];
        self.iconImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.iconImageView];
        
        //Title
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(137, 21, 150, 22)];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:20];
        [self addSubview:self.titleLabel];
    }
    return self;
}


//Custom drawing for test.
- (void)drawTheCell:(CGContextRef)context{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //// Color Declarations
    UIColor* gradientColor = [UIColor colorWithRed: 0 green: 0.944 blue: 0.361 alpha: 1];
    UIColor* gradientColor2 = [UIColor colorWithRed: 0.606 green: 0.983 blue: 0.704 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)gradientColor.CGColor,
                               (id)gradientColor2.CGColor, nil];
    CGFloat gradientLocations[] = {0.02, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 340, 65)];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(170, -0), CGPointMake(170, 65), 0);
    CGContextRestoreGState(context);
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


// Only override drawRect: if you perform custom drawing.
//- (void)drawRect:(CGRect)rect
//{
//    [self drawTheCell:UIGraphicsGetCurrentContext()];
//}

@end
