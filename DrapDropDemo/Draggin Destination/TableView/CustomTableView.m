//
//  CustomTableView.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/18/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "CustomTableView.h"

#import <AppKit/NSPasteboard.h>
#import <AppKit/NSDragging.h>

@interface CustomTableView ()<NSDraggingDestination, NSTableViewDelegate, NSTableViewDataSource> {
    NSMutableArray<NSPasteboardType> *acceptableTypes;
    NSDictionary *filteringOptions;
    NSString *DRAGGING_CURSOR;
}
@property (nonatomic) BOOL isReceivingDrap;

@end

@implementation CustomTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.delegate = self;
    self.dataSource = self;
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[NSColor purpleColor] CGColor];
    DRAGGING_CURSOR = @"mouse-2";
    filteringOptions = @{NSPasteboardURLReadingContentsConformToTypesKey: NSImage.imageTypes};
    acceptableTypes = [[NSMutableArray alloc] initWithArray:@[NSPasteboardTypeTIFF, NSPasteboardTypeURL]];
    [self registerForDraggedTypes:acceptableTypes];
}

- (BOOL)shouldAllowDrapWithDraggingInfo:(id<NSDraggingInfo>)info {
    BOOL canAccept = NO;
    
    NSPasteboard *pasteBoard = [info draggingPasteboard];
    
    BOOL isCanRead = [pasteBoard canReadObjectForClasses: @[NSURL.self] options:filteringOptions];
    
    if (isCanRead) {
        canAccept = YES;
    }
    else if ([pasteBoard.types containsObject:NSPasteboardTypeTIFF]) {
        canAccept = YES;
    }
    return canAccept;
}

- (void)setIsReceivingDrap:(BOOL)isReceivingDrap {
    _isReceivingDrap = isReceivingDrap;
    self.needsDisplay = YES;
    [self setCursor];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    // NOTE:
    // NSDragOperationCopy have an image, don't need to return this,
    BOOL allow = [self shouldAllowDrapWithDraggingInfo:sender];
    self.isReceivingDrap = allow;
    
    if (allow) {
        return NSDragOperationGeneric;
    }
    return NSDragOperationNone;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    BOOL allow = [self shouldAllowDrapWithDraggingInfo:sender];
    return allow;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    self.isReceivingDrap = NO;
    return NO;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
    self.isReceivingDrap = NO;
}

- (void)setCursor {
    if (self.isReceivingDrap) {
        NSCursor *draggingCursor = [[NSCursor alloc] initWithImage:[NSImage imageNamed:DRAGGING_CURSOR] hotSpot:NSMakePoint(4.0, 4.0)];
        [draggingCursor set];
    } else {
       NSCursor *draggingCursor = [[NSCursor alloc] initWithImage:[NSImage imageNamed:@"star"] hotSpot:NSMakePoint(4.0, 4.0)];
        [draggingCursor set];
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 10;
}

#pragma mark - NSTableViewDataSource

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 30.0;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *view = (NSTableCellView *)[tableView makeViewWithIdentifier:@"CellName" owner:self];
    view.textField.stringValue = @"TableViewCell TableViewCell TEST";
    return view;
}
@end
