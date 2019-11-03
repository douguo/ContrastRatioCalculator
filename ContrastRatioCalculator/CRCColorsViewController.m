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
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;

@end

@implementation CRCColorsViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
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
		
		CRCRatioViewController *controller = (CRCRatioViewController *)[[segue destinationViewController] topViewController];
		controller.color = self.color;
		controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
		controller.navigationItem.leftItemsSupplementBackButton = YES;
		
	} else if ([[segue identifier] isEqualToString:@"present"]) {
		
		CRCPaletteViewController *controller = (CRCPaletteViewController *)[[segue destinationViewController] topViewController];
		controller.delegate = self;
		
		if ([sender isKindOfClass:[CRCColor class]]) {
			
			CRCColor *color = (CRCColor *)sender;
			controller.color = [color copy];
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
		
		if (self.color == color) {
			
			if (self.secondaryColor) {
				
				self.color = self.secondaryColor;
				self.secondaryColor = nil;
				
			} else {

				self.color = nil;
			}
		}
		
		if (self.secondaryColor == color) {
			self.secondaryColor = nil;
		}
		
		[self.colors removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		
		if (self.lastSelectedIndexPath.row == indexPath.row) {
			self.lastSelectedIndexPath = nil;
		}
		
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
	
	cell.contentView.superview.backgroundColor = color.color;
	
	
	
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
	
	
	
	if (self.allowsMultipleSelection) {
		
		if (color == self.color || color == self.secondaryColor) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			cell.tintColor = color.color.crc_oppositeColor;
		} else {
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
		
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	self.lastSelectedIndexPath = indexPath;
}

#pragma mark - CRCPaletteViewControllerDelegate

- (void)paletteViewController:(CRCPaletteViewController *)controller didAddColor:(CRCColor *)color {
	
	[self.colors addObject:color];
	
	[self.tableView reloadData];
	
	NSIndexPath *path = [NSIndexPath indexPathForRow:self.colors.count - 1 inSection:0];
	[self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)paletteViewController:(CRCPaletteViewController *)controller didEditColor:(CRCColor *)color {
	
	[self.colors replaceObjectAtIndex:self.editingIndexPath.row withObject:color];
	[self.tableView reloadRowsAtIndexPaths:@[self.editingIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	
	self.editingIndexPath = nil;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
	
	if ([identifier isEqualToString:@"showDetail"]) {
		
		NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
		
		if (indexPath.row >= self.colors.count) {
			return YES;
		}
		
		CRCColor *color = self.colors[indexPath.row];
		
		UINavigationController *navigationController = self.splitViewController.viewControllers.lastObject;
		CRCRatioViewController *controller = (CRCRatioViewController *)navigationController.topViewController;
		
		if (![controller isKindOfClass:[CRCRatioViewController class]]) {
			self.color = color;
			return YES;
		}
		
		if (!self.allowsMultipleSelection) {
			
			self.color = color;
			controller.color = color;
			
			[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
			
			return YES;
			
		} else {
			
			if (self.color == nil) {
				
				self.color = color;
				controller.color = color;
				
				[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
				
				return YES;
			}
			
			
			
			if (color == self.color) {
				
				if (self.secondaryColor != nil) { // deselect the primary color, make the secondary color primary
					
					self.color = self.secondaryColor;
					self.secondaryColor = nil;
					
					controller.color = self.color;
					controller.secondaryColor = nil;
					
				} else { // select primary color twice, while no secondary color selected
					
					// do nothing
				}
				
			} else if (color == self.secondaryColor) {
				
				if (self.color != nil) { // select secondary color twice, deselect it
					
					self.secondaryColor = nil;
					controller.secondaryColor = nil;
					
				} else { // select secondary color before primary color?
					
					// impossible, has already performed segue in the first place
				}
				
			} else { // select a new secondary color
				
				self.secondaryColor = color;
				controller.secondaryColor = color;
				
			} // (and it's also impossible that priamry color and secondary color are same colors)
			
			
			
			NSArray *paths;
			
			if (self.lastSelectedIndexPath) {
				paths = @[indexPath, self.lastSelectedIndexPath];
			} else {
				paths = @[indexPath];
			}
			
			[self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
			
			return NO;
		}
	}
	
	return YES;
}

- (void)multiSelectionItemTapped:(UIBarButtonItem *)item {
	
	if (self.splitViewController.isCollapsed) {
		
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Multiple selection requires a bigger window"
																	   message:nil
																preferredStyle:UIAlertControllerStyleAlert];
		
		[alert addAction:[UIAlertAction actionWithTitle:@"OK"
												  style:UIAlertActionStyleCancel
												handler:nil]];
		
		[self presentViewController:alert animated:YES completion:nil];
		
		return;
	}
	
	
	
	self.allowsMultipleSelection = !self.allowsMultipleSelection;
	
	if (self.allowsMultipleSelection) {
		
		item.image = [UIImage systemImageNamed:@"2.circle.fill"];
		
	} else {
		
		self.secondaryColor = nil;
		
		UINavigationController *navigationController = self.splitViewController.viewControllers.lastObject;
		CRCRatioViewController *controller = (CRCRatioViewController *)navigationController.topViewController;
		controller.secondaryColor = nil;
		
		item.image = [UIImage systemImageNamed:@"2.circle"];
	}
	
	[self.tableView reloadData];
}

@end
