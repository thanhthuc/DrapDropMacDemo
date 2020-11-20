//
//  AppDelegate.h
//  DrapDropDemo
//
//  Created by Thuc Nguyen on 11/12/20.
//  Copyright © 2020 Thuc Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
 1. There r some problem with other app, like safari => right and now have issue with javascript mouse event,
 1.b understand about dragging operation
 2. Question: should base on drap operation or not,
 answer: should base on each view to decide
 3. How to detect it: base on dragging source or base on destination view
 base on both, each will decide how dragging icon should look
 4. Understand all case in ticket
 5. Rule for drag and drop enable in all view,
 Why in app have case drap on normal view it make can not drag view => answer: because that view does not register for event drap drop // OR receive event and do not handle it
 6. If parent is ViewController, baseView have receive event or not => answer: lowest layer will receive
 7. In Flo app, if view don't handle event, that event will do nothing, below will receive and handling
 8. Find a relative relatioship between draggOperation and action in Flo app, also cursor image => answer: will return DraggingOperationEvery
 9. how to detect in a good way: set event mouse drag in manager, enable or disable, that view will know: because only at that view will know
 
 // Are resolving:
 10. Cover all case NSOperation Drap in Flo app
 */

// New question:
// 1. webView event have effect when have top view or not: answer:
    //because webView is not respond when have event mouse,
    //or return nil on hitTest function

// 1b. Why web accept view when have a top view with alpha not equal to 0 => still research

// 2. refactor NSDragOperation:
    // Using owner Operation
    // Using owner Cursor
// https://stackoverflow.com/questions/5146947/what-is-the-impact-of-view-alpha-0-vs-view-hidden-yes
// Can not copy on twitter page sign up

@interface AppDelegate : NSObject <NSApplicationDelegate>

@end

