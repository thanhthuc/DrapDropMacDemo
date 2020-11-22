//
//  CustomDestinationDragging.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/20/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/NSPasteboard.h>
#import <AppKit/NSDragging.h>

NS_ASSUME_NONNULL_BEGIN

// /* Methods implemented by an object that receives dragged images.  The
//    destination view or window is sent these messages during dragging if it
//    responds to them.
//  */
// @protocol NSDraggingDestination <NSObject>
// @optional
// - (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender;
// - (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender; /* if the destination responded to draggingEntered: but not to draggingUpdated: the return value from draggingEntered: is used */
// - (void)draggingExited:(nullable id <NSDraggingInfo>)sender;
// - (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender;
// - (BOOL)performDragOperation:(id <NSDraggingInfo>)sender;
// - (void)concludeDragOperation:(nullable id <NSDraggingInfo>)sender;
// /* draggingEnded: is implemented as of Mac OS 10.5 */
// - (void)draggingEnded:(id<NSDraggingInfo>)sender;
// /* the receiver of -wantsPeriodicDraggingUpdates should return NO if it does not require periodic -draggingUpdated messages (eg. not autoscrolling or otherwise dependent on draggingUpdated: sent while mouse is stationary) */
// - (BOOL)wantsPeriodicDraggingUpdates;
//
// /* While a destination may change the dragging images at any time, it is recommended to wait until this method is called before updating the dragging image. This allows the system to delay changing the dragging images until it is likely that the user will drop on this destination. Otherwise, the dragging images will change too often during the drag which would be distracting to the user. The destination may update the dragging images by calling one of the -enumerateDraggingItems methods on the sender.
// */
// - (void)updateDraggingItemsForDrag:(nullable id <NSDraggingInfo>)sender API_AVAILABLE(macos(10.7))

// @end


@interface CustomDestinationDragging : NSObject<NSDraggingDestination>

@end

NS_ASSUME_NONNULL_END
