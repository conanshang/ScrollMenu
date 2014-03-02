//
//  SViewController.m
//  ScrollMenu
//
//  Created by conans on 2/28/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import "SViewController.h"
#import "SMenuCell.h"
#import "SMenuCellView.h"

@interface SViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *levelOneTableView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@property NSUInteger currentMiddleCellIndex;

@end

@implementation SViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Initialize
    self.levelOneTableView.delegate = self;
    self.levelOneTableView.dataSource = self;
    
    self.currentMiddleCellIndex = 2;
}

- (UIImage *)getCellBackgroundImage:(NSIndexPath *)indexPath{
    NSString *imagePath;
    
    switch ((indexPath.row + 1) % 5) {
        case 1:
            imagePath = [[NSBundle mainBundle] pathForResource:@"panel_yellow_a0" ofType:@"png"];
            break;
            
        case 2:
            imagePath = [[NSBundle mainBundle] pathForResource:@"panel_yellow_a1" ofType:@"png"];
            break;
            
        case 3:
            imagePath = [[NSBundle mainBundle] pathForResource:@"panel_orange_a2" ofType:@"png"];
            break;
            
        case 4:
            imagePath = [[NSBundle mainBundle] pathForResource:@"panel_orange_a1" ofType:@"png"];
            break;
            
        case 0:
            imagePath = [[NSBundle mainBundle] pathForResource:@"panel_orange_a0" ofType:@"png"];
            break;
            
        default:
            break;
    }
    
    UIImage *cellBackgroundImage = [UIImage imageWithContentsOfFile:imagePath];
    
    return cellBackgroundImage;
}

- (void)setThePreviewImageByUsingDisappearedIndexPath:(NSIndexPath *)indexPath{
    NSString *imagePath;
    
    switch (indexPath.row % 5 + 3) {
        case 1:
            imagePath = [[NSBundle mainBundle] pathForResource:@"panel_slider_beagle" ofType:@"png"];
            break;
            
        case 2:
            imagePath = [[NSBundle mainBundle] pathForResource:@"panel_slider_dino" ofType:@"png"];
            break;
            
        case 3:
            imagePath = [[NSBundle mainBundle] pathForResource:@"panel_slider_beagle" ofType:@"png"];
            break;
            
        case 4:
            imagePath = [[NSBundle mainBundle] pathForResource:@"panel_slider_dino" ofType:@"png"];
            break;
            
        case 0:
            imagePath = [[NSBundle mainBundle] pathForResource:@"panel_slider_beagle" ofType:@"png"];
            break;
            
        default:
            break;
    }
    
    self.previewImageView.image = [UIImage imageWithContentsOfFile:imagePath];
}

//Table View delegate.
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentMiddleCellIndex++;
    
    [self setThePreviewImageByUsingDisappearedIndexPath:indexPath];
    
}




//Table View data source.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 16;
}

- (SMenuCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menuCell";
    SMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Setup the custom cell view.
    SMenuCellView *customCell = [[SMenuCellView alloc] initWithFrame:CGRectMake(0, 0, 340, 65)];
    customCell.backgroundImageView.image = [self getCellBackgroundImage:indexPath];
    
    [cell.contentView addSubview:customCell];
    
    return cell;
}











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



























@end
