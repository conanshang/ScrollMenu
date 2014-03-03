//
//  SViewController.m
//  ScrollMenu
//
//  Created by conans on 2/28/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import "SViewController.h"
#import "SMenuCellView.h"
#import <QuartzCore/QuartzCore.h>

#define CUSTOM_CELL_TAG 101

@interface SViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *levelOneTableView;
@property (weak, nonatomic) IBOutlet UIImageView *sliderIndicatorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

//Variables
@property NSInteger currentMiddleCell;

@end

@implementation SViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Initialize
    self.levelOneTableView.delegate = self;
    self.levelOneTableView.dataSource = self;
    
    //The slide indicator.
    self.sliderIndicatorImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"panel_slider" ofType:@"png"]];
    
    //Variables
}

- (NSInteger)getTheIndexOfCellInMiddle{
    CGFloat tableViewOffSetY = self.levelOneTableView.contentOffset.y;
    NSInteger currentCellOffset = (tableViewOffSetY + 32.5) / 65;
    NSInteger currentMiddleCell = (currentCellOffset + 2) % 5;
    
    return currentMiddleCell;
}

- (void)setThePreviewImageWithMiddleCellIndex{
    if(self.currentMiddleCell != [self getTheIndexOfCellInMiddle]){
        NSString *imagePath;
        switch ([self getTheIndexOfCellInMiddle]) {
            case 0:
                imagePath = [[NSBundle mainBundle] pathForResource:@"panel_slider_beagle" ofType:@"png"];
                break;
                
            case 1:
                imagePath = [[NSBundle mainBundle] pathForResource:@"panel_slider_dino" ofType:@"png"];
                break;
                
            case 2:
                imagePath = [[NSBundle mainBundle] pathForResource:@"panel_slider_beagle" ofType:@"png"];
                break;
                
            case 3:
                imagePath = [[NSBundle mainBundle] pathForResource:@"panel_slider_dino" ofType:@"png"];
                break;
                
            case 4:
                imagePath = [[NSBundle mainBundle] pathForResource:@"panel_slider_beagle" ofType:@"png"];
                break;
                
            default:
                break;
        }

        //Transition.
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [self.previewImageView.layer addAnimation:transition forKey:nil];
        
        self.previewImageView.image = [UIImage imageWithContentsOfFile:imagePath];
        
        self.currentMiddleCell = [self getTheIndexOfCellInMiddle];
    }
}

- (NSArray *)retrieveCellImagesAtIndexPath:(NSIndexPath *)indexPath{
    NSString *backgroundImagePath;
    NSString *iconImagePath;
    NSString *titleName;
    
    switch (indexPath.row % 5) {
        case 0:
            backgroundImagePath = [[NSBundle mainBundle] pathForResource:@"panel_yellow_a0" ofType:@"png"];
            iconImagePath = [[NSBundle mainBundle] pathForResource:@"icon_oops_100" ofType:@"png"];
            titleName = @"OPPS!";
            break;
            
        case 1:
            backgroundImagePath = [[NSBundle mainBundle] pathForResource:@"panel_yellow_a1" ofType:@"png"];
            iconImagePath = [[NSBundle mainBundle] pathForResource:@"icon_screamie_100" ofType:@"png"];
            titleName = @"Screamies";
            break;
            
        case 2:
            backgroundImagePath = [[NSBundle mainBundle] pathForResource:@"panel_orange_a2" ofType:@"png"];
            iconImagePath = [[NSBundle mainBundle] pathForResource:@"icon_misc_100" ofType:@"png"];
            titleName = @"Misc";
            break;
            
        case 3:
            backgroundImagePath = [[NSBundle mainBundle] pathForResource:@"panel_orange_a1" ofType:@"png"];
            iconImagePath = [[NSBundle mainBundle] pathForResource:@"icon_product_100" ofType:@"png"];
            titleName = @"Products";
            break;
            
        case 4:
            backgroundImagePath = [[NSBundle mainBundle] pathForResource:@"panel_orange_a0" ofType:@"png"];
            iconImagePath = [[NSBundle mainBundle] pathForResource:@"icon_info_100" ofType:@"png"];
            titleName = @"Information";
            break;
            
        default:
            break;
    }
    
    UIImage *cellBackgroundImage = [UIImage imageWithContentsOfFile:backgroundImagePath];
    UIImage *cellIconImage = [UIImage imageWithContentsOfFile:iconImagePath];
    
    return [NSArray arrayWithObjects:cellBackgroundImage, cellIconImage, titleName, nil];
}

//Table View Scroll View delegate.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setThePreviewImageWithMiddleCellIndex];

}


//Table View data source.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *cellContentArray = [self retrieveCellImagesAtIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        //Setup the custom cell view.
        SMenuCellView *customCell = [[SMenuCellView alloc] initWithFrame:CGRectMake(0, 0, 340, 65)];
        customCell.tag = CUSTOM_CELL_TAG;
        customCell.backgroundImageView.image = [cellContentArray objectAtIndex:0];
        customCell.iconImageView.image = [cellContentArray objectAtIndex:1];
        customCell.titleLabel.text = [cellContentArray objectAtIndex:2];
        
        [cell.contentView addSubview:customCell];
        
        //NSLog([NSString stringWithFormat:@"Create for index : %ld", (long)indexPath.row]);
    }
    else{
        SMenuCellView *customCell = (SMenuCellView *)[cell.contentView viewWithTag:CUSTOM_CELL_TAG];
        customCell.backgroundImageView.image = [cellContentArray objectAtIndex:0];
        customCell.iconImageView.image = [cellContentArray objectAtIndex:1];
        customCell.titleLabel.text = [cellContentArray objectAtIndex:2];
    }
 
    return cell;
}











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



























@end
