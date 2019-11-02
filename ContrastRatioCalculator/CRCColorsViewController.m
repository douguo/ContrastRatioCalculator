//
//  CRCRatioViewController.m
//  ContrastRatioCalculator
//
//  Created by Sean Chen on 2019/9/24.
//  Copyright © 2019 Douguo Inc. All rights reserved.
//

#import "CRCColorsViewController.h"

@interface CRCColorsViewController ()

@property (nonatomic, strong) NSMutableArray *colors;

@property (nonatomic, strong) NSIndexPath *editingIndexPath;

@end

@implementation CRCColorsViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.detailViewController = (CRCRatioViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
	
	self.colors = [NSMutableArray arrayWithCapacity:0];
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemBlueColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemGreenColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemIndigoColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemOrangeColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemPinkColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemPurpleColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemRedColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemTealColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemYellowColor"]];
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemGrayColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemGray2Color"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemGray3Color"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemGray4Color"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemGray5Color"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemGray6Color"]];
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"labelColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"secondaryLabelColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"tertiaryLabelColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"quaternaryLabelColor"]];
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemFillColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"secondarySystemFillColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"tertiarySystemFillColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"quaternarySystemFillColor"]];
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"placeholderTextColor"]];
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemBackgroundColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"secondarySystemBackgroundColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"tertiarySystemBackgroundColor"]];
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"systemGroupedBackgroundColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"secondarySystemGroupedBackgroundColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"tertiarySystemGroupedBackgroundColor"]];
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"separatorColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"opaqueSeparatorColor"]];
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"linkColor"]];
	
	
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"blackColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"blueColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"brownColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"cyanColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"darkGrayColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"grayColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"greenColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"lightGrayColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"magentaColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"orangeColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"purpleColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"redColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"whiteColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"yellowColor"]];
	
	[self.colors addObject:[CRCColor colorWithPaletteName:@"darkTextColor"]];
	[self.colors addObject:[CRCColor colorWithPaletteName:@"lightTextColor"]];
	
	
	
	[self.colors addObjectsFromArray:[CRCDefaults allColors]];
}

- (void)viewWillAppear:(BOOL)animated {
	self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
	[super viewWillAppear:animated];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([[segue identifier] isEqualToString:@"showDetail"]) {
		
	    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	    CRCColor *color = self.colors[indexPath.row];
		
	    CRCRatioViewController *controller = (CRCRatioViewController *)[[segue destinationViewController] topViewController];
	    controller.color = color;
		controller.phase = CRCPresentationPhase1;
	    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
	    controller.navigationItem.leftItemsSupplementBackButton = YES;
	    self.detailViewController = controller;
		
	} else if ([[segue identifier] isEqualToString:@"present"]) {
		
		CRCPaletteViewController *controller = (CRCPaletteViewController *)[[segue destinationViewController] topViewController];
		controller.delegate = self;
		
		if ([sender isKindOfClass:[CRCColor class]]) {
			
			CRCColor *color = (CRCColor *)sender;
			color = [color copy];
			
			controller.color = color;
		}
	}
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.colors.count;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	CRCColor *color = self.colors[indexPath.row];
	
	UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
																		 title:@"Delete"
																	   handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
		
		CRCColor *color = self.colors[indexPath.row];
		[CRCDefaults removeColor:color];
		
		[self.colors removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		
		completionHandler(YES);
	}];
	delete.image = [UIImage systemImageNamed:@"trash"];
	
	UIContextualAction *edit = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
																		 title:@"Edit"
																	   handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
		
		CRCColor *color = self.colors[indexPath.row];
		[self performSegueWithIdentifier:@"present" sender:color];
		
		self.editingIndexPath = indexPath;
		
		completionHandler(YES);
	}];
	edit.image = [UIImage systemImageNamed:@"pencil"];
	
	NSArray *actions;
	
	if (color.date) {
		actions = @[delete, edit];
	} else {
		actions = @[edit];
	}
	
	UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:actions];
	
	return config;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	
	CRCColor *color = self.colors[indexPath.row];
	cell.textLabel.text = color.name;
	cell.detailTextLabel.text = color.hexadecimalRepresentation;
	
	cell.contentView.backgroundColor = color.color;
	
	
	
	CGFloat ratio = [UIColor crc_contrastRatioBetweenColor1:color.color andColor2:[UIColor labelColor]];
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

#pragma mark - CRCPaletteViewControllerDelegate

- (void)paletteViewController:(CRCPaletteViewController *)controller didAddColor:(CRCColor *)color {
	
	[self.colors addObject:color];
	
	[self.tableView reloadData];
	
	NSIndexPath *path = [NSIndexPath indexPathForRow:self.colors.count - 1 inSection:0];
	[self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)paletteViewController:(CRCPaletteViewController *)controller didEditColor:(CRCColor *)color {
	
//	[self.colors replaceObjectAtIndex:self.editingIndexPath.row withObject:color];
	[self.tableView reloadRowsAtIndexPaths:@[self.editingIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	
	self.editingIndexPath = nil;
}

@end
