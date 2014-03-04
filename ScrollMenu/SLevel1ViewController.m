//
//  SViewController.m
//  ScrollMenu
//
//  Created by conans on 2/28/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import "SLevel1ViewController.h"
#import "SLevel2ViewController.h"

#define CUSTOM_CELL_TAG 101

@interface SLevel1ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *levelOneTableView;
@property (weak, nonatomic) IBOutlet UIImageView *sliderIndicatorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet UIView *coverIconsView;

//Variables

@end

@implementation SLevel1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Initialize
    self.levelOneTableView.delegate = self;
    self.levelOneTableView.dataSource = self;
    
    //The slide indicator.
    self.sliderIndicatorImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"panel_slider" ofType:@"png"]];
    //Initial the preview image.
    self.previewImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"panel_slider_dino" ofType:@"png"]];
    
    //Setup the data.
    [self setupTheContentArraysFoThisLevelTableView];
    
}

- (void)setupTheContentArraysFoThisLevelTableView{ //The array variables are in the parent's class.
    self.previewImageNameArray = [NSArray arrayWithObjects:@"panel_slider_beagle", @"panel_slider_dino", @"panel_slider_beagle", @"panel_slider_dino", @"panel_slider_beagle", nil];
    
    NSArray *itemOneArray = [NSArray arrayWithObjects:@"panel_yellow_a0", @"icon_oops_100", @"OPPS!", nil];
    NSArray *itemTwoArray = [NSArray arrayWithObjects:@"panel_yellow_a1", @"icon_screamie_100", @"Screamies", nil];
    NSArray *itemThreeArray = [NSArray arrayWithObjects:@"panel_orange_a2", @"icon_misc_100", @"Misc", nil];
    NSArray *itemFourArray = [NSArray arrayWithObjects:@"panel_orange_a1", @"icon_product_100", @"Products", nil];
    NSArray *itemFiveArray = [NSArray arrayWithObjects:@"panel_orange_a0", @"icon_info_100", @"Information", nil];
    self.scrollMenuContentArray = [NSArray arrayWithObjects:itemOneArray, itemTwoArray, itemThreeArray, itemFourArray, itemFiveArray, nil];
}

//Table View Scroll View delegate.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setThePreviewImageWithMiddleCellIndexInTableView:self.levelOneTableView forImageView:self.previewImageView];
}

    //To next level.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if((indexPath.row % 5) == 0){ //For demo, only item one can be selected.
        [self setTheAlphaOfNonSelectedRowsInTableView:self.levelOneTableView forSelectedRow:indexPath];
        [self.coverIconsView setHidden:NO];
        
        SLevel2ViewController *level2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"level2TableViewController"];
        level2ViewController.modalPresentationStyle = UIModalPresentationCustom;
        level2ViewController.transitioningDelegate = (id)self;
        
        [self presentViewController:level2ViewController animated:YES completion:nil];
    }
}
    //Back from upper level.
- (IBAction)unwindFromSecondLevel:(UIStoryboardSegue *)sender{
    [self SetTheAlphaBackForTableView:self.levelOneTableView];
    [self.coverIconsView setHidden:YES];
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
        SMenuCellView *customCell = [[SMenuCellView alloc] initWithFrame:CGRectMake(0, 0, 340, 65) AndLevel:1];
        customCell.tag = CUSTOM_CELL_TAG;
        customCell.backgroundImageView.image = [cellContentArray objectAtIndex:0];
        customCell.iconImageView.image = [cellContentArray objectAtIndex:1];
        customCell.titleLabel.text = [cellContentArray objectAtIndex:2];
        
        [cell.contentView addSubview:customCell];
        
        //NSLog(@"Created");
    }
    else{
        SMenuCellView *customCell = (SMenuCellView *)[cell.contentView viewWithTag:CUSTOM_CELL_TAG];
        customCell.backgroundImageView.image = [cellContentArray objectAtIndex:0];
        customCell.iconImageView.image = [cellContentArray objectAtIndex:1];
        customCell.titleLabel.text = [cellContentArray objectAtIndex:2];
        //customCell.iconImageView.alpha = 1.0;
    }
 
    return cell;
}



























@end
