//
//  CustomDestinationDragging.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/20/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "CustomDestinationDragging.h"
#import "CustomDestinationDraggingProtocol.h"



@implementation CustomDestinationDragging

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    return NSDragOperationEvery;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    return NSDragOperationGeneric;
}


@end
