//
//  SLevel3ViewController.m
//  ScrollMenu
//
//  Created by conans on 3/4/14.
//  Copyright (c) 2014 Zihang Wang. All rights reserved.
//

#import "SLevel3ViewController.h"
#import "SCustomLevelChangeTransition.h"

#define CUSTOM_CELL_TAG 101

@interface SLevel3ViewController () <UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UITableView *levelThreeTableView;
@property (weak, nonatomic) IBOutlet UIImageView *sliderIndicatorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@end

@implementation SLevel3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Initialize
    self.levelThreeTableView.delegate = self;
    self.levelThreeTableView.dataSource = self;
    
    //The slide indicator.
    self.sliderIndicatorImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"panel_slider" ofType:@"png"]];
    //Initial the preview image.
    self.previewImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"eye_22" ofType:@"png"]];
    
    //Setup the data.
    [self setupTheContentArraysFoThisLevelTableView];
    
}

- (void)setupTheContentArraysFoThisLevelTableView{ //The array variables are in the parent's class.
    self.previewImageNameArray = [NSArray arrayWithObjects:@"eye_09", @"eye_10", @"eye_22", @"eye_12", @"eye_19", nil];
    
    NSArray *itemOneArray = [NSArray arrayWithObjects:@"panel_yellow_c1", @"icon_halloween", @"Halloween", nil];
    NSArray *itemTwoArray = [NSArray arrayWithObjects:@"panel_yellow_c1", @"icon_xmas", @"Xmas", nil];
    NSArray *itemThreeArray = [NSArray arrayWithObjects:@"panel_yellow_c2", @"icon_default_100", @"Default", nil];
    NSArray *itemFourArray = [NSArray arrayWithObjects:@"panel_orange_c0", @"icon_special", @"SFX", nil];
    NSArray *itemFiveArray = [NSArray arrayWithObjects:@"panel_yellow_c0", @"icon_thxgiving", @"Thxgiving", nil];
    self.scrollMenuContentArray = [NSArray arrayWithObjects:itemOneArray, itemTwoArray, itemThreeArray, itemFourArray, itemFiveArray, nil];
}

//Table View Scroll View delegate.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setThePreviewImageWithMiddleCellIndexInTableView:self.levelThreeTableView forImageView:self.previewImageView];
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
        SMenuCellView *customCell = [[SMenuCellView alloc] initWithFrame:CGRectMake(0, 0, 195, 65) AndLevel:3];
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

//Transition delegate.
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source{
    
    SCustomLevelChangeTransition *animator = [SCustomLevelChangeTransition new];
    
    animator.ifInAnimating = YES;
    
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    SCustomLevelChangeTransition *animator = [SCustomLevelChangeTransition new];
    
    animator.ifInAnimating = NO;
    
    return animator;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
