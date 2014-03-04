//
//  SViewControllerBase.h
//  ScrollMenu
//
//  Created by conans on 3/3/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SViewControllerBase : UIViewController

- (NSInteger)getTheIndexOfCellInMiddle:(UITableView *)tableView;
- (void)setThePreviewImageWithMiddleCellIndexInTableView:(UITableView *)tableView forImageView:(UIImageView *)imageView;
- (NSArray *)retrieveCellContentArrayAtIndexPath:(NSIndexPath *)indexPath;

//Variables
@property NSInteger currentMiddleCell;
@property (nonatomic, strong) NSArray *previewImageNameArray;
@property (nonatomic, strong) NSArray *scrollMenuContentArray;

@end
