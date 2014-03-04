//
//  SLevel2ViewController.m
//  ScrollMenu
//
//  Created by conans on 3/3/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import "SLevel2ViewController.h"

#define CUSTOM_CELL_TAG 101

@interface SLevel2ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *levelTwoTableView;
@property (weak, nonatomic) IBOutlet UIImageView *sliderIndicatorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@end

@implementation SLevel2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Initialize
    self.levelTwoTableView.delegate = self;
    self.levelTwoTableView.dataSource = self;
    
    //The slide indicator.
    self.sliderIndicatorImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"panel_slider" ofType:@"png"]];
    //Initial the preview image.
    self.previewImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"panel_slider_dino" ofType:@"png"]];
    
    //Setup the data.
    [self setupTheContentArraysFoThisLevelTableView];
}

- (void)setupTheContentArraysFoThisLevelTableView{ //The array variables are in the parent's class.
    self.previewImageNameArray = [NSArray arrayWithObjects:@"panel_slider_beagle", @"panel_slider_dino", @"panel_slider_beagle", @"panel_slider_dino", @"panel_slider_beagle", nil];
    
    NSArray *itemOneArray = [NSArray arrayWithObjects:@"panel_orange_b0", @"icon_default_100", @"Upcoming", nil];
    NSArray *itemTwoArray = [NSArray arrayWithObjects:@"panel_yellow_b1", @"icon_pug_100", @"Pug", nil];
    NSArray *itemThreeArray = [NSArray arrayWithObjects:@"panel_yellow_b2", @"icon_beagle_100", @"Beagle", nil];
    NSArray *itemFourArray = [NSArray arrayWithObjects:@"panel_yellow_b1", @"icon_que_100", @"Corgi", nil];
    NSArray *itemFiveArray = [NSArray arrayWithObjects:@"panel_orange_b0", @"icon_default_100", @"Upcoming", nil];
    self.scrollMenuContentArray = [NSArray arrayWithObjects:itemOneArray, itemTwoArray, itemThreeArray, itemFourArray, itemFiveArray, nil];
}

//Table View Scroll View delegate.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setThePreviewImageWithMiddleCellIndexInTableView:self.levelTwoTableView forImageView:self.previewImageView];
}


//Table View data source.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *cellContentArray = [self retrieveCellContentArrayAtIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        //Setup the custom cell view.
        SMenuCellView *customCell = [[SMenuCellView alloc] initWithFrame:CGRectMake(0, 0, 267, 65) AndLevel:2];
        customCell.tag = CUSTOM_CELL_TAG;
        customCell.backgroundImageView.image = [cellContentArray objectAtIndex:0];
        customCell.iconImageView.image = [cellContentArray objectAtIndex:1];
        customCell.titleLabel.text = [cellContentArray objectAtIndex:2];
        
        [cell.contentView addSubview:customCell];
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
