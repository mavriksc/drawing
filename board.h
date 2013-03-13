//
//  board.h
//  drawing
//
//  Created by sean carlisle on 12/31/12.
//  Copyright (c) 2012 sean carlisle. All rights reserved.
//
//need to implement this completely need init!!
//look up 

#import <Foundation/Foundation.h>

@interface board : NSObject

@property (readonly) NSArray *data;
@property (readonly) int mines,rows,cols;
@property (readonly) int safeTilesLeft;

-(void)decSafeTiles;
-(board *)initWithWidth:(int)w andHeight:(int)h andMines:(int)m;
-(NSArray *)newBoardWithWidth:(int)w andHeight:(int)h;
-(NSString *)valueForIndex:(int)i;
@end
