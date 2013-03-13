//
//  boardViewController.m
//  drawing
//
//  Created by sean carlisle on 2/21/13.
//  Copyright (c) 2013 sean carlisle. All rights reserved.
//  

#import "boardViewController.h"
#import "board.h"
#import "tileView.h"

@interface boardViewController ()

@end

@implementation boardViewController

//need to add frame to initializer.
- (id) initWithHeight:(int)h andWidth:(int)w andMines:(int)m{
    self = [super init];
    if (self) {
        _bd= [[board alloc] initWithWidth:w andHeight:h andMines:m];
        tileView *tv;
        for (int i=0; i<self.bd.rows*self.bd.cols; i++) {
            int row,col;
            row=i/self.bd.cols;
            col=i%self.bd.cols;
            tv=[[tileView alloc] initWithFrame:CGRectMake(col*60+5, row*60+5, 60, 60) andValue:[self.bd valueForIndex:i]];
            [self.view addSubview:tv];
        }
                    
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

-(tileView *)tileFromPoint:(CGPoint)point
{
    //returns a tileView based on a point in the view. specifically a view containing many tile views null if it's not in a tile in that view.
    for (tileView *tv in [[self view] subviews]) {
        if (CGRectContainsPoint(tv.frame, point)) {
            return tv;
        }
    }
    return NULL;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TOUCHBEGAN");
    UITouch *touch = [touches anyObject];
    self.lastTile=[self tileFromPoint:[touch locationInView:self.view]];
    [self.lastTile setStateDown];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //trigger the reveal and the the following logic to possibly reveal other squares.
    NSLog(@"TOUCHESENDED");
    if (![self.lastTile.value isEqualToString:@"m"]) {
        self.lastTile.state=@"revealed";
        [self.lastTile setNeedsDisplay];
    }
    
}

//for scroll view: may need to change this if the touch moves out of one tile to begin scrolling
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if not dragging set current tile if different
    // if (!((UIScrollView *)self.view).dragging) {
    NSLog(@"TOUCHMOVED");
    UITouch *touch=[touches anyObject];
    CGPoint locinsuper=[touch locationInView:self.view];
    
    self.curTile= [self tileFromPoint:locinsuper];
    
    if(self.lastTile!=NULL){
        if (self.lastTile!=self.curTile) {
            [self.lastTile setStateUp];
            [self.curTile setStateDown];            }
    }
    self.lastTile=self.curTile;
    //}
    //else  dragging, "up" tile if beginning to scroll and do nothing else here.
    //    else if (!self.lastTile){
    //
    //        [self.lastTile setStateUp];
    //        self.lastTile=NULL;
    //
    //    }
    
    //moves the tile with the touch. some snap to if the touch is not centerd on the tile
    //    self.lastTile.center=locinsuper;
    //    [self.lastTile setNeedsDisplay];
}

-(int)indexForPoint:(CGPoint)point{
    //returns the index for a linear array for a 2d array;
    return point.x+point.y*self.bd.cols;
}

-(CGPoint)pointForIndex:(int)i{
    //returns a point in a 2darray from an index
    return CGPointMake(i%self.bd.cols, i/self.bd.cols);
}

-(NSArray*)adjacentTilesForIndex:(int)i{
    //returns a list of adjacent tiles
    CGPoint loc=[self pointForIndex:i];
    NSMutableArray *spots=[[NSMutableArray alloc]init];
    if (loc.y>0) {
        //count row above
        [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x, loc.y-1)]]];
        if (loc.x>0) {
            [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x-1, loc.y-1)]]];
        }
        if (loc.x+1<self.bd.cols) {
            [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x+1, loc.y-1)]]];
        }
    }
    if (loc.y+1<self.bd.rows) {
        //count next row
        [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x, loc.y+1)]]];
        if (loc.x>0) {
            [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x-1, loc.y+1)]]];
        }
        if (loc.x+1<self.bd.cols) {
            [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x+1, loc.y+1)]]];
        }
    }
    //count current row
    if (loc.x>0) {
        [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x-1, loc.y)]]];
    }
    if (loc.x+1<self.bd.cols) {
        [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x+1, loc.y)]]];
    }
    return spots;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
 

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
