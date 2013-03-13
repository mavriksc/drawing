//
//  boardViewController.h
//  drawing
//
//  Created by sean carlisle on 2/21/13.
//  Copyright (c) 2013 sean carlisle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "board.h"   
#import "tileView.h"

@interface boardViewController : UIViewController

@property (readonly) board *bd;
@property tileView *curTile,*lastTile;
@property UIScrollView *scrollV;

- (id) initWithHeight:(int)h andWidth:(int)w andMines:(int)m;

@end
