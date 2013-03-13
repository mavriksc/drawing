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

@interface ViewController : UIViewController<UIScrollViewDelegate>{
    
    
 
}
@property IBOutlet UIButton *optionsButton;
@property IBOutlet UILabel *clock;
@property int rows,cols,mines;
@property IBOutlet UIScrollView *boardScroller;
@property  boardViewController *bvc;

-(IBAction)newGameBoard;
-(IBAction)options;
-(void)setHeight:(int)h Width:(int)w Mines:(int)m;

@end
