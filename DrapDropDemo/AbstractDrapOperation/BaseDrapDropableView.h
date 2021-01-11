//
//  BaseDrapDropableView.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 23/11/2020.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CustomDestinationDraggingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseDrapDropableView : NSView<NSDraggingDestination>

- (void)decidedCursorWithOperation: (ValidDrapOperation)validOperation;
- (void)customRegisterForDraggedTypes:(NSArray<NSPasteboardType> *)newTypes;
@property (nonatomic, strong) id<CustomDestinationDraggingProtocol> draggingDelegate;

@end

NS_ASSUME_NONNULL_END
