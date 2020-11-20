//
//  Helper.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (Helper *)sharedInstance
{
    static Helper *_helper = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _helper = [Helper new];
    });
    return _helper;
}

- (NSImage *)snapshotWithView:(NSView *)view {
    NSData *pdfData = [view dataWithPDFInsideRect: view.bounds];
    NSImage *image = [[NSImage alloc] initWithData:pdfData];
    if (image != nil) {
        return image;
    }
    return [[NSImage alloc] init];
}

- (NSPoint)addRandomNoiseWithPoint:(NSPoint)point maximumDelta:(UInt32)maximumDelta {
    
    NSPoint newCenter = point;
    UInt32 range = 2 * maximumDelta;
    UInt32 xdelta = arc4random_uniform(range);
    UInt32 ydelta = arc4random_uniform(range);
    newCenter.x += ((CGFloat)xdelta - (CGFloat)maximumDelta);
    newCenter.y += ((CGFloat)ydelta - (CGFloat)maximumDelta);
    return newCenter;
}

- (NSImage *)tintImageWithImage:(NSImage *)image color:(NSColor *)color {
    NSImage *newImage = [[NSImage alloc] initWithSize:image.size];
    [newImage lockFocus];
    [color drawSwatchInRect:NSMakeRect(0, 0, image.size.width, image.size.height)];
    [image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositingOperationDestinationIn fraction:1.0];
    [newImage unlockFocus];
    return newImage;
}

- (NSSize)aspectFitSizeForMaxDimensionWithImage:(NSImage *)image maxDimension:(CGFloat)maxDimension {
    CGFloat width =  image.size.width;
    CGFloat height = image.size.height;
    if (image.size.width > maxDimension || image.size.height > maxDimension) {
        float aspectRatio = image.size.width/image.size.height;
        width = aspectRatio > 0 ? maxDimension : maxDimension*aspectRatio;
        height = aspectRatio < 0 ? maxDimension : maxDimension/aspectRatio;
    }
    return NSMakeSize(width, height);
}

- (NSColor *)randomColor {
    NSArray *colors = @[[NSColor redColor], [NSColor greenColor], [NSColor blueColor], [NSColor orangeColor], [NSColor cyanColor], [NSColor magentaColor], [NSColor yellowColor]];
    return colors[(int)arc4random_uniform((UInt32)colors.count)];
}

- (void)addAutoResizingView:(NSView *)containerView toView:(NSView *)toView
{
    if (containerView != nil)
    {
        [toView addSubview:containerView];
        
        [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [toView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)]];
        [toView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)]];
        
        // Should force update view constraints for update UI correctly.
        // [FM-1270] Show flashing for Flo app when open with Compact mode.
        [toView layoutSubtreeIfNeeded];
        [toView.superview layoutSubtreeIfNeeded];
    }
}


@end



