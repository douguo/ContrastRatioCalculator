//
//  CRCRatioViewController.m
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/9/24.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import "CRCColorsViewController.h"
#import "CRCRatioViewController.h"

@interface CRCColorsViewController ()

@property NSMutableArray *colors;

@end

@implementation CRCColorsViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.detailViewController = (CRCRatioViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
	
	
	
	self.colors = [NSMutableArray arrayWithCapacity:0];
	
	[self.colors addObject:[UIColor systemBlueColor]];
	[self.colors addObject:[UIColor systemGreenColor]];
	[self.colors addObject:[UIColor systemIndigoColor]];
	[self.colors addObject:[UIColor systemOrangeColor]];
	[self.colors addObject:[UIColor systemPinkColor]];
	[self.colors addObject:[UIColor systemPurpleColor]];
	[self.colors addObject:[UIColor systemRedColor]];
	[self.colors addObject:[UIColor systemTealColor]];
	[self.colors addObject:[UIColor systemYellowColor]];
	
	[self.colors addObject:[UIColor systemGrayColor]];
	[self.colors addObject:[UIColor systemGray2Color]];
	[self.colors addObject:[UIColor systemGray3Color]];
	[self.colors addObject:[UIColor systemGray4Color]];
	[self.colors addObject:[UIColor systemGray5Color]];
	[self.colors addObject:[UIColor systemGray6Color]];
	
	[self.colors addObject:[UIColor labelColor]];
	[self.colors addObject:[UIColor secondaryLabelColor]];
	[self.colors addObject:[UIColor tertiaryLabelColor]];
	[self.colors addObject:[UIColor quaternaryLabelColor]];
	
	[self.colors addObject:[UIColor systemFillColor]];
	[self.colors addObject:[UIColor secondarySystemFillColor]];
	[self.colors addObject:[UIColor tertiarySystemFillColor]];
	[self.colors addObject:[UIColor quaternarySystemFillColor]];
	
	[self.colors addObject:[UIColor placeholderTextColor]];
	
	[self.colors addObject:[UIColor systemBackgroundColor]];
	[self.colors addObject:[UIColor secondarySystemBackgroundColor]];
	[self.colors addObject:[UIColor tertiarySystemBackgroundColor]];
	
	[self.colors addObject:[UIColor systemGroupedBackgroundColor]];
	[self.colors addObject:[UIColor secondarySystemGroupedBackgroundColor]];
	[self.colors addObject:[UIColor tertiarySystemGroupedBackgroundColor]];
	
	[self.colors addObject:[UIColor separatorColor]];
	[self.colors addObject:[UIColor opaqueSeparatorColor]];
	
	[self.colors addObject:[UIColor linkColor]];
	
	
	
	[self.colors addObject:[UIColor blackColor]];
	[self.colors addObject:[UIColor blueColor]];
	[self.colors addObject:[UIColor brownColor]];
	[self.colors addObject:[UIColor cyanColor]];
	[self.colors addObject:[UIColor darkGrayColor]];
	[self.colors addObject:[UIColor grayColor]];
	[self.colors addObject:[UIColor greenColor]];
	[self.colors addObject:[UIColor lightGrayColor]];
	[self.colors addObject:[UIColor magentaColor]];
	[self.colors addObject:[UIColor orangeColor]];
	[self.colors addObject:[UIColor purpleColor]];
	[self.colors addObject:[UIColor redColor]];
	[self.colors addObject:[UIColor whiteColor]];
	[self.colors addObject:[UIColor yellowColor]];
	
	[self.colors addObject:[UIColor darkTextColor]];
	[self.colors addObject:[UIColor lightTextColor]];
}

- (void)viewWillAppear:(BOOL)animated {
	self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
	[super viewWillAppear:animated];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([[segue identifier] isEqualToString:@"showDetail"]) {
		
	    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	    UIColor *color = self.colors[indexPath.row];
		
	    CRCRatioViewController *controller = (CRCRatioViewController *)[[segue destinationViewController] topViewController];
	    controller.color = color;
		controller.phase = CRCPresentationPhase1;
	    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
	    controller.navigationItem.leftItemsSupplementBackButton = YES;
	    self.detailViewController = controller;
	}
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.colors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	
	UIColor *color = self.colors[indexPath.row];
	cell.textLabel.text = color.crc_name;
	cell.detailTextLabel.text = color.crc_hexValue;
	
	cell.contentView.backgroundColor = color;
	
	
	
	CGFloat ratio = [UIColor crc_contrastRatioBetweenColor1:color andColor2:[UIColor labelColor]];
	BOOL unreadable = ratio < 1.4;
	
	if (unreadable) {
		
		cell.textLabel.shadowColor = [UIColor labelColor].crc_oppositeColor;
		cell.detailTextLabel.shadowColor = [UIColor labelColor].crc_oppositeColor;
		
		CGFloat pixel = 1.0 / [UIScreen mainScreen].scale;
		CGSize shadowOffset = CGSizeMake(pixel, pixel);
		
		cell.textLabel.shadowOffset = shadowOffset;
		cell.detailTextLabel.shadowOffset = shadowOffset;
		
	} else {
		
		cell.textLabel.shadowColor = nil;
		cell.detailTextLabel.shadowColor = nil;
	}
	
	return cell;
}

@end
