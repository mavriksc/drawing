//
//  ViewController.h
//  drawing
//
//  Created by sean carlisle on 11/11/12.
//  Copyright (c) 2012 sean carlisle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tileView.h"
#import "boardViewController.h" 

@interface ViewController : UIViewController{
    int _rows,_cols;
    
 
}
@property int rows,cols,mines;
@property UIScrollView *boardScroller;
@property  boardViewController *bvc;

@end
