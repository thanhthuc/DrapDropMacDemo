//
//  TopViewControllerOnView.m
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/18/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import "TopViewControllerOnView.h"

@interface TopViewControllerOnView ()

@end

@implementation TopViewControllerOnView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    self.view.alphaValue = 0.5;
    self.view.layer.backgroundColor = [[NSColor greenColor] CGColor];
}

@end
