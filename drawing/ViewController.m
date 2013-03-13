//
//  ViewController.m
//  drawing
//
//  Created by sean carlisle on 11/11/12.
//  Copyright (c) 2012 sean carlisle. All rights reserved.
//

#import "ViewController.h"
#import "tileView.h"
#import "boardViewController.h" 
#include <stdlib.h>
#import "optionsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)setHeight:(int)h Width:(int)w Mines:(int)m{
    self.mines=m;
    self.rows=h;
    self.cols=w;
}

-(IBAction)options{
    optionsViewController   *ovc= [[optionsViewController alloc]initWithHeight:_rows Width:_cols Mines:_mines];
    [ovc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    ovc.delegate = self;
    [self presentViewController:ovc animated:YES completion:nil];
}

-(IBAction)newGameBoard{
    
    [_bvc.view removeFromSuperview];
    _bvc=[[boardViewController alloc]  initWithHeight:self.rows andWidth:self.cols andMines:self.mines];
    
    self.bvc.view.frame= CGRectMake(0, 0, self.cols*60+10, self.rows*60+10);
    self.boardScroller.contentSize=CGSizeMake(self.cols*60+10, self.rows*60+10);
    
    [self.boardScroller addSubview:self.bvc.view];
    self.boardScroller.frame= self.view.bounds;
    self.boardScroller.minimumZoomScale= 0.5;
    self.boardScroller.delegate=self;
    [self.view addSubview:self.boardScroller];
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.rows=10;
    self.cols=10;
    self.mines=10;
    [self newGameBoard];
        
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.bvc.view;
}
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
