//
//  ActionView.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RoundedRectView.h"
#import "BaseDrapDropableView.h"

NS_ASSUME_NONNULL_BEGIN
@interface ActionView : BaseDrapDropableView<CustomDestinationDraggingProtocol>

@end

NS_ASSUME_NONNULL_END
