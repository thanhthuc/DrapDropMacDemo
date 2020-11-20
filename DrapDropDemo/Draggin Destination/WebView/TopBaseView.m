//
//  TopBaseView.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/16/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "TopBaseView.h"
#import <AppKit/NSPasteboard.h>
#import <AppKit/NSDragging.h>

@interface TopBaseView ()<NSDraggingDestination> {
    NSMutableArray<NSPasteboardType> *acceptableTypes;
    NSDictionary *filteringOptions;
    NSString *DRAGGING_CURSOR;
}

@property (nonatomic) BOOL isReceivingDrap;

@end

@implementation TopBaseView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[NSColor purpleColor] CGColor];
    self.alphaValue = 0.5;
    
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
    return allow ? NSDragOperationGeneric : NSDragOperationNone;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    BOOL allow = [self shouldAllowDrapWithDraggingInfo:sender];
    return allow;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
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

//- (void)mouseDown:(NSEvent *)event{
//    NSLog(@"Mouse down");
//}

@end
