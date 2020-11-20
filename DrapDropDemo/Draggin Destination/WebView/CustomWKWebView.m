//
//  CustomWKWebView.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/16/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "CustomWKWebView.h"
#import <AppKit/NSPasteboard.h>
#import <AppKit/NSDragging.h>

@interface CustomWKWebView ()<NSDraggingDestination> {
    CGFloat lineWidth;
    NSMutableArray<NSPasteboardType> *acceptableTypes;
    NSDictionary *filteringOptions;
    NSString *DEFAULT_CURSOR;
    NSString *CLICKED_CURSOR;
    NSString *DRAGGING_CURSOR;
}

@property (nonatomic) BOOL isReceivingDrap;
@property (nonatomic, retain) NSArray *cursors;

@end

@implementation CustomWKWebView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
//    if (self.isReceivingDrap) {
//        [[NSColor selectedControlTextColor] set];
//        
//        NSBezierPath *path = [NSBezierPath bezierPathWithRect:self.bounds];
//        path.lineWidth = lineWidth;
//        [path stroke];
//    }
//    [self setup];
//    //    self.alphaValue = 0.0;
//        
//    self.wantsLayer = YES;
//    self.layer.backgroundColor = [[NSColor redColor] CGColor];
    
}

- (void)setup {
    lineWidth = 10.0;
    self.wantsLayer = YES;
//    self.layer.backgroundColor = [[NSColor purpleColor] CGColor];
//    self.alphaValue = 0.5;
    
    DEFAULT_CURSOR = @"unicorn-small";
    CLICKED_CURSOR = @"ic_cursor_position";
    DRAGGING_CURSOR = @"ic_cursor_position";
    
    
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

    BOOL allow = [self shouldAllowDrapWithDraggingInfo:sender];
    self.isReceivingDrap = allow;
    return allow ? NSDragOperationEvery : NSDragOperationNone;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    BOOL allow = [self shouldAllowDrapWithDraggingInfo:sender];
    return allow;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
    self.isReceivingDrap = NO;
}

- (void)setCursor {
    if (self.isReceivingDrap) {
        NSLog(@"Set mouse isReceivingDrap = YES");
        NSCursor *draggingCursor = [[NSCursor alloc] initWithImage:[NSImage imageNamed:DRAGGING_CURSOR] hotSpot:NSMakePoint(4.0, 4.0)];
        [draggingCursor set];
    } else {
        NSLog(@"Exit mouse isReceivingDrap = NO");
       NSCursor *draggingCursor = [[NSCursor alloc] initWithImage:[NSImage imageNamed:@"star"] hotSpot:NSMakePoint(4.0, 4.0)];
        [draggingCursor set];
    }
}

@end
