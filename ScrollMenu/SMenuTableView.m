//
//  SMenuTableView.m
//  ScrollMenu
//
//  Created by conans on 3/2/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import "SMenuTableView.h"
@interface SMenuTableView()

@end

@implementation SMenuTableView

- (id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        self.contentSize = CGSizeMake(self.frame.size.width, 975);
        self.contentOffset = CGPointMake(0, 325);
    }
    return self;
}

- (void)resetContentOffsetIfNeeded{
    CGPoint contentOffset  = self.contentOffset;
    
    //check the top condition
    //check if the scroll view reached its top.. if so.. move it to center.. remember center is the start of the data repeating for 2nd time.
    if( contentOffset.y<=0.0){
        contentOffset.y = self.contentSize.height/3.0f;
    }
    //scrollview content offset reached bottom minus the height of the tableview
    else if( contentOffset.y >= ( self.contentSize.height - self.bounds.size.height)){
        //this scenario is same as the data repeating for 2nd time minus the height of the table view
        contentOffset.y = self.contentSize.height/3.0f- self.bounds.size.height;
    }
    [self setContentOffset: contentOffset];
}

- (void)recenterIfNecessary{
    if(self.contentOffset.y > 650){
        [self setContentOffset:CGPointMake(0, 325)];
    }
    else if(self.contentOffset.y < 0){
        [self setContentOffset:CGPointMake(0, 325)];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self recenterIfNecessary];

}

@end
