//
//  ImageSourceView.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "ImageSourceView.h"
#import "Helper.h"
#import <AppKit/NSPasteboard.h>
#import <AppKit/NSDragging.h>

@interface ImageSourceView (){
    NSString *DRAGGING_CURSOR;
    NSMutableArray<NSPasteboardType> *acceptableTypes;
    NSDictionary *filteringOptions;
}

@end

@implementation ImageSourceView

- (void)awakeFromNib {
    [super awakeFromNib];
    DRAGGING_CURSOR = @"star";
    filteringOptions = @{NSPasteboardURLReadingContentsConformToTypesKey: NSImage.imageTypes};
    acceptableTypes = [[NSMutableArray alloc] initWithArray:@[NSPasteboardTypeTIFF, NSPasteboardTypeURL]];
    [self registerForDraggedTypes:acceptableTypes];
    [self setCursor];
}

- (NSDragOperation)draggingSession:(NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context {
    return NSDragOperationGeneric;
}

- (void)pasteboard:(NSPasteboard *)pasteboard item:(NSPasteboardItem *)item provideDataForType:(NSPasteboardType)type {
    NSString *typeTIFF = (NSString*)kUTTypeTIFF;
    NSImage *image = [NSImage imageNamed:@"unicorn"];
    NSImage *finalImage = [[Helper sharedInstance] tintImageWithImage:image color:[[Helper sharedInstance] randomColor]];
    NSData *tiffData = [finalImage TIFFRepresentation];
    [pasteboard setData:tiffData forType:typeTIFF];
}

// Same
- (void)mouseDragged:(NSEvent *)event {
    NSLog(@"Set cursor in mouse dragging");
    [self setCursor];
    NSPasteboardItem *pasteBoardItem = [[NSPasteboardItem alloc] init];
    [pasteBoardItem setDataProvider:self forTypes:@[NSPasteboardTypeTIFF]];
    
    NSDraggingItem *draggingItem = [[NSDraggingItem alloc] initWithPasteboardWriter:pasteBoardItem];
    [draggingItem setDraggingFrame:self.bounds contents: [[Helper sharedInstance] snapshotWithView:self]];
    
    [self beginDraggingSessionWithItems:@[draggingItem] event:event source:self];
   
}

- (void)setCursor {
    NSCursor *draggingCursor = [[NSCursor alloc] initWithImage:[NSImage imageNamed:DRAGGING_CURSOR] hotSpot:NSMakePoint(4.0, 4.0)];
    [draggingCursor set];
}

// Same
- (void)mouseDown:(NSEvent *)event {
    [self setCursor];
    NSLog(@"mouse down");
    
}
- (void)mouseEntered:(NSEvent *)event {
    NSLog(@"mouse enter");
}

- (void)mouseUp:(NSEvent *)event {
    NSLog(@"mouse up");
}

- (void)mouseMoved:(NSEvent *)event {
    NSLog(@"mouse moved");
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    [self setCursor];
    return NSDragOperationNone;
}
- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    [self setCursor];
    return NSDragOperationNone;
}

@end
