//
//  CustomDraggingDestination.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/20/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <AppKit/NSPasteboard.h>
#import <AppKit/NSDragging.h>

#ifndef CustomDraggingDestination_h
#define CustomDraggingDestination_h

typedef NS_OPTIONS(NSUInteger, CustomEnumDragOperation) {
    CustomDragOperationNone        = 0,
    CustomDragOperationCopy        = 1,
    CustomDragOperationLink        = 2,
    CustomDragOperationGeneric    = 4,
    CustomDragOperationPrivate    = 8,
    CustomDragOperationMove        = 16,
    CustomDragOperationDelete    = 32,
    CustomDragOperationEvery    = NSUIntegerMax,
};





@protocol CustomDestinationDraggingProtocol <NSObject>
@optional
- (NSDragOperation)customDraggingEntered:(id <NSDraggingInfo>_Nonnull)sender;
- (NSDragOperation)customDraggingUpdated:(id <NSDraggingInfo>_Nonnull)sender; /* if the destination responded to draggingEntered: but not to draggingUpdated: the return value from draggingEntered: is used */
- (void)customDraggingExited:(nullable id <NSDraggingInfo>)sender;
- (BOOL)customPrepareForDragOperation:(id <NSDraggingInfo>_Nonnull)sender;
- (BOOL)customPerformDragOperation:(id <NSDraggingInfo>_Nonnull)sender;
- (void)customConcludeDragOperation:(nullable id <NSDraggingInfo>)sender;
/* draggingEnded: is implemented as of Mac OS 10.5 */
- (void)customDraggingEnded:(id<NSDraggingInfo>_Nonnull)sender;
/* the receiver of -wantsPeriodicDraggingUpdates should return NO if it does not require periodic -draggingUpdated messages (eg. not autoscrolling or otherwise dependent on draggingUpdated: sent while mouse is stationary) */
- (BOOL)customWantsPeriodicDraggingUpdates;

/* While a destination may change the dragging images at any time, it is recommended to wait until this method is called before updating the dragging image. This allows the system to delay changing the dragging images until it is likely that the user will drop on this destination. Otherwise, the dragging images will change too often during the drag which would be distracting to the user. The destination may update the dragging images by calling one of the -enumerateDraggingItems methods on the sender.
 */
- (void)customUpdateDraggingItemsForDrag:(nullable id <NSDraggingInfo>)sender API_AVAILABLE(macos(10.7));

 @end


#endif /* CustomDraggingDestination_h */
