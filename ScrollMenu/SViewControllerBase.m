//
//  SViewControllerBase.m
//  ScrollMenu
//
//  Created by conans on 3/3/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import "SViewControllerBase.h"
#import <QuartzCore/QuartzCore.h>

#define CUSTOM_CELL_TAG 101

@interface SViewControllerBase ()

@end

@implementation SViewControllerBase

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (NSInteger)getTheIndexOfCellInMiddle:(UITableView *)tableView{
    CGFloat tableViewOffSetY = tableView.contentOffset.y;
    NSInteger currentCellOffset = (tableViewOffSetY + 32.5) / 65;
    NSInteger currentMiddleCell = (currentCellOffset + 2) % 5;
    
    return currentMiddleCell;
}

- (void)setThePreviewImageWithMiddleCellIndexInTableView:(UITableView *)tableView forImageView:(UIImageView *)imageView{
    if(self.currentMiddleCell != [self getTheIndexOfCellInMiddle:tableView]){
        NSInteger cellInTheMiddle = [self getTheIndexOfCellInMiddle:tableView];
        NSArray *contentArray = self.previewImageNameArray;
        
        NSString *imageName;
        switch (cellInTheMiddle) {
            case 0:
                imageName = [contentArray objectAtIndex:0];
                break;
                
            case 1:
                imageName = [contentArray objectAtIndex:1];
                break;
                
            case 2:
                imageName = [contentArray objectAtIndex:2];
                break;
                
            case 3:
                imageName = [contentArray objectAtIndex:3];
                break;
                
            case 4:
                imageName = [contentArray objectAtIndex:4];
                break;
                
            default:
                break;
        }
        
        //Transition.
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [imageView.layer addAnimation:transition forKey:nil];
        
        imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
        
        self.currentMiddleCell = cellInTheMiddle;
    }
}

- (NSArray *)retrieveCellContentArrayAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *contentArray = self.scrollMenuContentArray;
    NSArray *itemArray;
    
    NSString *backgroundImageName;
    NSString *iconImageName;
    NSString *titleName;
    
    switch (indexPath.row % 5) {
        case 0:
            itemArray = [contentArray objectAtIndex:0];
            
            backgroundImageName = [itemArray objectAtIndex:0];
            iconImageName = [itemArray objectAtIndex:1];
            titleName = [itemArray objectAtIndex:2];
            
            break;
            
        case 1:
            itemArray = [contentArray objectAtIndex:1];
            
            backgroundImageName = [itemArray objectAtIndex:0];
            iconImageName = [itemArray objectAtIndex:1];
            titleName = [itemArray objectAtIndex:2];
            
            break;
            
        case 2:
            itemArray = [contentArray objectAtIndex:2];
            
            backgroundImageName = [itemArray objectAtIndex:0];
            iconImageName = [itemArray objectAtIndex:1];
            titleName = [itemArray objectAtIndex:2];
            
            break;
            
        case 3:
            itemArray = [contentArray objectAtIndex:3];
            
            backgroundImageName = [itemArray objectAtIndex:0];
            iconImageName = [itemArray objectAtIndex:1];
            titleName = [itemArray objectAtIndex:2];
            
            break;
            
        case 4:
            itemArray = [contentArray objectAtIndex:4];
            
            backgroundImageName = [itemArray objectAtIndex:0];
            iconImageName = [itemArray objectAtIndex:1];
            titleName = [itemArray objectAtIndex:2];
            
            break;
            
        default:
            break;
    }
    
    UIImage *cellBackgroundImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:backgroundImageName ofType:@"png"]];
    UIImage *cellIconImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:iconImageName ofType:@"png"]];
    
    return [NSArray arrayWithObjects:cellBackgroundImage, cellIconImage, titleName, nil];
}

//For transition to next level.
- (void)setTheAlphaOfNonSelectedRowsInTableView:(UITableView *)tableView forSelectedRow:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    SMenuCellView *customSelectedCell = (SMenuCellView *)[selectedCell.contentView viewWithTag:CUSTOM_CELL_TAG];

    NSArray *visibleCells = [tableView visibleCells];
    for(int i = 0; i < [visibleCells count]; i++){
        UITableViewCell *cell = [visibleCells objectAtIndex:i];
        SMenuCellView *customCell = (SMenuCellView *)[cell.contentView viewWithTag:CUSTOM_CELL_TAG];
        
        customCell.iconImageView.alpha = 0.3;
    }
    
    customSelectedCell.iconImageView.alpha = 1.0;
}

- (void)SetTheAlphaBackForTableView:(UITableView *)tableView{
    NSArray *visibleCells = [tableView visibleCells];
    for(int i = 0; i < [visibleCells count]; i++){
        UITableViewCell *cell = [visibleCells objectAtIndex:i];
        SMenuCellView *customCell = (SMenuCellView *)[cell.contentView viewWithTag:CUSTOM_CELL_TAG];
        
        customCell.iconImageView.alpha = 1.0;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
