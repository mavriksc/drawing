//
//  board.m
//  drawing
//
//  Created by sean carlisle on 12/31/12.
//  Copyright (c) 2012 sean carlisle. All rights reserved.
//

#import "board.h"

@implementation board

-(void)decSafeTiles
{
    _safeTilesLeft--;
}
-(NSString *)valueForIndex:(int)i
{
    return [[self data]objectAtIndex:i];
}

//
//  THese next two may only be needed in the view controller.
//

-(int)indexForPoint:(CGPoint)point{
    //returns the index for a linear array for a 2d array;
    return point.x+point.y*_cols;
}
-(CGPoint)pointForIndex:(int)i{
    //returns a point in a 2darray from an index
    return CGPointMake(i%_cols, i/_cols);
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
        if (loc.x+1<_cols) {
            [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x+1, loc.y-1)]]];
        }
    }
    if (loc.y+1<_rows) {
        //count next row
        [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x, loc.y+1)]]];
        if (loc.x>0) {
            [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x-1, loc.y+1)]]];
        }
        if (loc.x+1<_cols) {
            [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x+1, loc.y+1)]]];
        }
    }
    //count current row
    if (loc.x>0) {
        [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x-1, loc.y)]]];
    }
    if (loc.x+1<_cols) {
        [spots addObject:[NSNumber numberWithInt:[self indexForPoint: CGPointMake(loc.x+1, loc.y)]]];
    }
    return spots;
    
}

-(NSString *)minesAdjacentToIndex:(int)i inBoard:(NSArray*)b{
    int count=0;
    NSArray *spots=[self adjacentTilesForIndex:i];
    for (NSNumber *j in spots) {
        if ([[b objectAtIndex:[j integerValue]]isEqualToString: @"m"])  {
            count++;
        }
    }
    
    return [[NSNumber numberWithInt:count] stringValue];
}

-(void)outputBoard:(NSArray *)b{
    NSString *line=@"\n";
    for (int i=0; i<b.count; i++) {
        line=[line stringByAppendingString:[b objectAtIndex:i]];
        if ((i+1)%_cols==0) {
            line=[line stringByAppendingString:@"\n"];
        }
    }
    NSLog(@"%@",line);
}


-(board *)initWithWidth:(int)w andHeight:(int)h andMines:(int)m{
    if (self) {
        _rows = h;
        _cols = w;
        _mines=m;
        _safeTilesLeft=_rows*_cols-_mines;
        _data = [self newBoardWithWidth:self.cols andHeight:self.rows];
        
            }
    return self;
}

-(board *)init{
    if (self) {
        _rows = 7;
        _cols = 5;
        _mines= 10;
        _data = [self newBoardWithWidth:self.cols andHeight:self.rows];
        
    }
    return self;
}
-(NSArray *)newBoardWithWidth:(int)w andHeight:(int)h
{
    NSMutableArray *b=[[NSMutableArray alloc]initWithCapacity:w*h];
    int count = 0;
    int pos;
    
    // zero out the board
    for (int i = 0; i<w*h; i++) {
        [b setObject:@"0" atIndexedSubscript:i];
    }
    do {
        //add the mines
        pos = arc4random_uniform(b.count);
        
        if ([[b objectAtIndex:pos] isEqualToString:@"0"]) {
            [b setObject:@"m" atIndexedSubscript:pos];
            count++;
        }
    } while (count<self.mines);
    
    for (int i=0; i<b.count;i++) {
        //gets mines count and sets it to that positions value
        //something is not right here most values are correct issues on right hand edge most likely
        if (![[b objectAtIndex:i] isEqualToString:@"m"]) {
            [b setObject:[self minesAdjacentToIndex:i inBoard:b] atIndexedSubscript:i];
        }
        
    }
    return b;
}

@end
