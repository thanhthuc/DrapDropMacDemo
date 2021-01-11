//
//  BaseDrapDropableView.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 23/11/2020.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "BaseDrapDropableView.h"

@interface BaseDrapDropableView() {
    NSString *allowCursor;
    NSString *donAllowCursor;
    NSString *startCursor;
}

@end

@implementation BaseDrapDropableView

- (instancetype)initWithDelegate: (id<CustomDestinationDraggingProtocol>)delegate
{
    self = [super init];
    if (self) {
        self.draggingDelegate = delegate;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self registerForDraggedTypes:@[]];
    allowCursor = @"mouse";
    donAllowCursor = @"mouse-2";
    startCursor = @"ic_cursor_position";
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    CustomEnumDragOperation customOperation = [self.draggingDelegate customDraggingEntered:sender];
    NSDragOperation operation = [self decidedCustomOperation:customOperation];
    
    return operation;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    CustomEnumDragOperation customOperation = [self.draggingDelegate customDraggingUpdated:sender];
    NSDragOperation operation = [self decidedCustomOperation:customOperation];
    
    return operation;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    return YES;
}

- (NSDragOperation)decidedCustomOperation:(CustomEnumDragOperation)operation {
    if (operation == CustomDragOperationGeneric) {
        return NSDragOperationGeneric;
    }
    return NSDragOperationNone;
}

- (void)setCursor: (NSString *)imageNamed {
    NSCursor *draggingCursor = [[NSCursor alloc]
                                initWithImage:[NSImage imageNamed:imageNamed]
                                hotSpot:NSMakePoint(4.0, 4.0)];
    [draggingCursor set];
}

- (void)decidedCursorWithOperation:(ValidDrapOperation)validOperation {
    if (validOperation == CustomDragOperationAllow) {
        [self setCursor: allowCursor];
    }
    else if (validOperation == CustomDragOperationDonAllow) {
        [self setCursor: donAllowCursor];
    }
    else {
        [self setCursor: startCursor];
    }
}

- (void)customRegisterForDraggedTypes:(NSArray<NSPasteboardType> *)newTypes {
    
}
@end
