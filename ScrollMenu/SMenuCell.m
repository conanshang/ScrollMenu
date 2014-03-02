//
//  SMenuCell.m
//  ScrollMenu
//
//  Created by conans on 3/2/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import "SMenuCell.h"

@implementation SMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)addSubview:(UIView *)view
{
    [super addSubview:view];
    
    // The separator has a height of 0.5pt on a retina display and 1pt on non-retina.
    // Prevent subviews with this height from being added.
    if (CGRectGetHeight(view.frame)*[UIScreen mainScreen].scale == 1)
    {
        return;
    }  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
