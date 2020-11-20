//
//  RoundedRectView.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "RoundedRectView.h"

@interface RoundedRectView ()
@end

@implementation RoundedRectView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (void)setup {
    self.wantsLayer = YES;
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [[NSColor systemBlueColor] CGColor];
}

@end
