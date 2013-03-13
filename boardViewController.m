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
       // NSLog(@"data size %i",_bd.data.count);
        tileView *tv;
        for (int i=0; i<self.bd.rows*self.bd.cols; i++) {
            int row,col;
            row=i/self.bd.cols;
            col=i%self.bd.cols;
            
            tv=[[tileView alloc] initWithFrame:CGRectMake(col*60+5,row*60+5, 60, 60) andValue:[self.bd valueForIndex:i]];
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
    UITouch *touch = [touches anyObject];
    self.lastTile=[self tileFromPoint:[touch locationInView:self.view]];
    [self.lastTile setStateDown];
}

-(NSArray *)unRevealedAdjacentTiles:(int)i{
    NSArray *locs=[[NSArray alloc]initWithArray:[self adjacentTilesForIndex:i]];
    NSMutableArray *tiles=[[NSMutableArray alloc]init];
    for (NSNumber *n in locs) {

        if (![[[self.view subviews]objectAtIndex:[n integerValue]] isRevealed]) {
            [tiles addObject:[[self.view subviews]objectAtIndex:[n integerValue]]];
        }
    }
    return tiles;
}

-(void)revealAdjacentTilesToEmptySpace:(int)i{

    NSArray *tilesToReveal=[self unRevealedAdjacentTiles:i];
    for (tileView *tv in tilesToReveal) {
        [tv reveal];
        [self.bd decSafeTiles];
    }
    for (tileView *tv in tilesToReveal) {
        if ([tv.value isEqualToString:@"0"]) {
            
            [self revealAdjacentTilesToEmptySpace:[[self.view subviews]indexOfObject:tv]];
        }
    }
    if (self.bd.safeTilesLeft==0) {
        //GAME OVER WIN!!!!
        NSLog(@"You win");
    }

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //trigger the reveal and the the following logic to possibly reveal other squares.
    if (![self.lastTile.value isEqualToString:@"m"]) {
        if (![self.lastTile isRevealed]) {

            [self.lastTile reveal];
            [self.bd decSafeTiles];
            
            if ([self.lastTile.value isEqualToString:@"0"]) {
                [self revealAdjacentTilesToEmptySpace:[[[self view] subviews]indexOfObject:self.lastTile]];
                
            }
            if (self.bd.safeTilesLeft==0) {
                //GAME OVER WIN!!!!
                NSLog(@"You win");
            }
        }
        
    }
    
}

//for scroll view: may need to change this if the touch moves out of one tile to begin scrolling
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self.lastTile setStateUp];
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
