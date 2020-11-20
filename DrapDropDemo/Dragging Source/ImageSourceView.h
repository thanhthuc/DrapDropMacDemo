//
//  ImageSourceView.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RoundedRectView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageSourceView : RoundedRectView<NSDraggingSource, NSPasteboardItemDataProvider>

@end

NS_ASSUME_NONNULL_END
