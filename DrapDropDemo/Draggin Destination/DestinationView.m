//
//  DestinationView.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "DestinationView.h"
#import <AppKit/NSPasteboard.h>
#import <AppKit/NSDragging.h>

@interface DestinationView ()<NSDraggingDestination> {
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

@implementation DestinationView

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self setup];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
//    if (self.isReceivingDrap) {
//        [[NSColor selectedControlTextColor] set];
//
//        NSBezierPath *path = [NSBezierPath bezierPathWithRect:self.bounds];
//        path.lineWidth = lineWidth;
//        [path stroke];
//    }
//    [self setCursor];
}

- (void)setup {
    lineWidth = 10.0;
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[NSColor purpleColor] CGColor];
    self.alphaValue = 1.0;
    
    DEFAULT_CURSOR = @"unicorn-small";
//    CLICKED_CURSOR = @"ic_cursor_position";
//    DRAGGING_CURSOR = @"ic_cursor_position";
    
    
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

    BOOL allow = [self shouldAllowDrapWithDraggingInfo:sender];
    self.isReceivingDrap = allow;
    return allow ? NSDragOperationCopy : NSDragOperationNone;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    
    BOOL allow = [self shouldAllowDrapWithDraggingInfo:sender];
    return allow;
}
//
- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    //NOTE

    self.isReceivingDrap = NO;
    NSPasteboard *pasteBoard = [sender draggingPasteboard];

    // Get point from source sender
    NSPoint point = [self convertPoint:[sender draggingLocation] fromView:nil];

    // Read url from soure image url
    NSArray *urls = [pasteBoard readObjectsForClasses:@[NSURL.self] options:filteringOptions];

    NSImage *image = [[NSImage alloc] initWithPasteboard:pasteBoard];
    if (urls.count >0) {
        [self.delegate processImageURLs:urls center:point];
        return YES;
    }
    else if (image != nil) {
        [self.delegate processImage:image center:point];
    }
    return NO;
}

//- (void)draggingExited:(id<NSDraggingInfo>)sender {
//    [self setCursor];
//    self.isReceivingDrap = NO;
//}


//- (NSView *)hitTest:(NSPoint)point {
//    [super hitTest:point];
//    
//    return nil;
//}

- (void)setCursor {
    NSCursor *draggingCursor = [[NSCursor alloc] initWithImage:[NSImage imageNamed:DRAGGING_CURSOR] hotSpot:NSMakePoint(4.0, 4.0)];
    [draggingCursor set];
}

//- (void)loadCursors
//{
//    NSCursor *defaultCursor = [[NSCursor alloc] initWithImage:[NSImage imageNamed:DEFAULT_CURSOR] hotSpot:NSMakePoint(4.0, 4.0)];
//    NSAssert(defaultCursor, @"defaultCursor failed to load");
//    NSCursor *clickedCursor = [[NSCursor alloc] initWithImage:[NSImage imageNamed:CLICKED_CURSOR] hotSpot:NSMakePoint(4.0, 4.0)];
//    NSAssert(clickedCursor, @"clickedCursor failed to load");
//    NSCursor *draggingCursor = [[NSCursor alloc] initWithImage:[NSImage imageNamed:DRAGGING_CURSOR] hotSpot:NSMakePoint(4.0, 4.0)];
//    NSAssert(draggingCursor, @"draggingCursor failed to load");
//
//    self.cursors = [NSArray arrayWithObjects:defaultCursor, clickedCursor, draggingCursor, nil];
//    [self resetCursorRects];
//}
//
//- (void)setCursor:(NSUInteger)cursorIndex
//{
//    [self discardCursorRects];
//    [self addCursorRect:self.bounds cursor:[self.cursors objectAtIndex:cursorIndex]];
//    [(NSCursor *)([self.cursors objectAtIndex:cursorIndex]) set];
//}
//
//- (void)resetCursorRects
//{
//    [self setCursor:0];
//}

@end
