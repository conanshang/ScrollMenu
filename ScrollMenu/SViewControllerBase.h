//
//  SViewControllerBase.h
//  ScrollMenu
//
//  Created by conans on 3/3/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMenuCellView.h"

@interface SViewControllerBase : UIViewController <UIViewControllerTransitioningDelegate>

- (NSInteger)getTheIndexOfCellInMiddle:(UITableView *)tableView;
- (void)setThePreviewImageWithMiddleCellIndexInTableView:(UITableView *)tableView forImageView:(UIImageView *)imageView;
- (NSArray *)retrieveCellContentArrayAtIndexPath:(NSIndexPath *)indexPath;
- (void)setTheAlphaOfNonSelectedRowsInTableView:(UITableView *)tableView forSelectedRow:(NSIndexPath *)indexPath;
- (void)SetTheAlphaBackForTableView:(UITableView *)tableView;

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source;
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;

//Variables
@property NSInteger currentMiddleCell;
@property (nonatomic, strong) NSArray *previewImageNameArray;
@property (nonatomic, strong) NSArray *scrollMenuContentArray;

@end
