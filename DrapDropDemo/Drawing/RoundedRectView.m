//
//  RoundedRectView.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "RoundedRectView.h"

@interface RoundedRectView () {
    CGFloat radius;
}

@end

@implementation RoundedRectView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
    
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
//    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(self.bounds, radius, radius) xRadius:radius yRadius:radius];
//    [[NSColor whiteColor] set];
//    [path fill];
    
}

- (void)setup {
//    radius = 10.0;
    self.wantsLayer = YES;
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [[NSColor systemBlueColor] CGColor];
}

@end
