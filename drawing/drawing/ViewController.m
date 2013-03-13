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

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.rows=10;
    self.cols=10;
    self.mines=20;
    //need to add frame componenet to initializer.
    self.boardScroller= [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.boardScroller.contentSize=CGSizeMake(self.cols*60+10, self.rows*60+10);
    
    _bvc=[[boardViewController alloc] initWithHeight:self.rows andWidth:self.cols andMines:self.mines];
    self.bvc.view.frame= CGRectMake(0, 0, self.cols*60+10, self.rows*60+10);
    [self.boardScroller addSubview:self.bvc.view];
    self.boardScroller.frame= self.view.bounds;
    self.boardScroller.minimumZoomScale= 0.5;
    [self.view addSubview:self.boardScroller];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
