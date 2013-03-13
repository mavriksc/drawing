//
//  tileView.m
//  drawing
//
//  Created by sean carlisle on 11/11/12.
//  Copyright (c) 2012 sean carlisle. All rights reserved.
//

#import "tileView.h"

@implementation tileView

-(BOOL)isMine{

    return [self.value isEqualToString:@"m"];
}

-(BOOL)isEmpty{
    
    return [self.value isEqualToString:@"0"];
}

-(void)reveal{
    if (![self isRevealed]) {
        _state=@"revealed";
        [self setNeedsDisplay];
    }
}
-(void)setStateUp
{
    
    if (![self isRevealed]) {
        _state=@"up";
        [self setNeedsDisplay];
}
    
}
-(BOOL)isUp
{
    return [self.state isEqualToString:@"up"];
}

-(void)setStateDown
{
    if (![self isRevealed]) {
        _state=@"down";
        [self setNeedsDisplay];
    }
    
}
-(BOOL)isDown
{
    return [self.state isEqualToString:@"down"];
}

-(BOOL)isRevealed
{
    return([self.state isEqualToString:@"revealed"]);
}

- (id)initWithFrame:(CGRect)frame andValue:(NSString *)value
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _state=@"up";
        _value=value;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self=[self initWithFrame:frame andValue:@"0"];
    return self;
}

-(void)drawRevealedTileWithContext:(CGContextRef)context{
    CGContextSetLineWidth(context, 1);
    //if the tile is not a mine display the tile.
    //probably not needed as if it is a mine the game is over. and need the ability to reveal mines at the end. look at this further.
    if (![self.value isEqualToString: @"m"]) {
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
        CGContextSetRGBFillColor (context,  0.5, 0.5, 0.5, 1);
        CGContextAddRect(context, CGRectMake(0, 0, 60, 60));
        CGContextDrawPath(context, kCGPathFillStroke);
        //not skipping this when 0???? !!FIXED!! stupid stirng compare
        if (![self.value isEqualToString:@"0"]) {
            //NSLog(@"%@",self.value);
            switch ([self.value integerValue]) {
                case 1:
                    CGContextSetRGBFillColor(context, 0, 1, 0, 1);
                    break;
                
                case 2:
                    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
                    break;
                case 3:
                    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
                    break;
                    
                case 4:
                    CGContextSetRGBFillColor(context, 0, 0.5, 0.5, 1);
                    break;
                case 5:
                    CGContextSetRGBFillColor(context, 0.5, 0, 0.5, 1);
                    break;
                    
                case 6:
                    CGContextSetRGBFillColor(context, 0.2, 0.8, 0.5, 1);
                    break;
                case 7:
                    CGContextSetRGBFillColor(context, 0.2, 0.5, 0.8, 1);
                    break;
                    
                case 8:
                    CGContextSetRGBFillColor(context, 0.8, 0.2, 0.5, 1);
                    break;
                
                case 9:
                    CGContextSetRGBFillColor(context, 0.5, 0.5, 0, 1);
                    break;
                default:
                    break;
            }
            
            [self.value drawAtPoint:CGPointMake(10, 5) withFont:[UIFont fontWithName:@"AppleGothic" size:50]];
        }
       
    }
    
}

-(void)drawDepressedTileWithContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 0.9, 0.9, 0.9, 1);
    
    CGContextSetRGBFillColor (context,  0.4, 0.4, 0.4, 1);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 5, 5);
    CGContextAddLineToPoint(context, 5, 55);
    CGContextAddLineToPoint(context, 0, 60);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBFillColor (context,  0.2, 0.2, 0.2, 1);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 5, 5);
    CGContextAddLineToPoint(context, 55, 5);
    CGContextAddLineToPoint(context, 60, 0);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBFillColor (context,  0.6, 0.6, 0.6, 1);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 60, 0);
    CGContextAddLineToPoint(context, 55, 5);
    CGContextAddLineToPoint(context, 55, 55);
    CGContextAddLineToPoint(context, 60, 60);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBFillColor (context,  0.8, 0.8, 0.8, 1);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 60);
    CGContextAddLineToPoint(context, 5, 55);
    CGContextAddLineToPoint(context, 55, 55);
    CGContextAddLineToPoint(context, 60, 60);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBFillColor (context,  0.5, 0.5, 0.5, 1);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 5, 5);
    CGContextAddLineToPoint(context, 5, 55);
    CGContextAddLineToPoint(context, 55, 55);
    CGContextAddLineToPoint(context, 55, 5);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
}

-(void)drawUpTileWithContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    
    CGContextSetRGBFillColor (context,  0.6, 0.6, 0.6, 1);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 5, 5);
    CGContextAddLineToPoint(context, 5, 55);
    CGContextAddLineToPoint(context, 0, 60);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBFillColor (context,  0.8, 0.8, 0.8, 1);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 5, 5);
    CGContextAddLineToPoint(context, 55, 5);
    CGContextAddLineToPoint(context, 60, 0);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBFillColor (context,  0.4, 0.4, 0.4, 1);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 60, 0);
    CGContextAddLineToPoint(context, 55, 5);
    CGContextAddLineToPoint(context, 55, 55);
    CGContextAddLineToPoint(context, 60, 60);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBFillColor (context,  0.2, 0.2, 0.2, 1);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 60);
    CGContextAddLineToPoint(context, 5, 55);
    CGContextAddLineToPoint(context, 55, 55);
    CGContextAddLineToPoint(context, 60, 60);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBFillColor (context,  0.5, 0.5, 0.5, 1);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 5, 5);
    CGContextAddLineToPoint(context, 5, 55);
    CGContextAddLineToPoint(context, 55, 55);
    CGContextAddLineToPoint(context, 55, 5);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);

}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef myContext =UIGraphicsGetCurrentContext() ;
        if ([self isUp]) {
        [self drawUpTileWithContext:myContext];

    }
    else if ([self isDown]) {
        [self drawDepressedTileWithContext:myContext];
        
    }
    else if ([self isRevealed]) {
        [self drawRevealedTileWithContext:myContext];
        
    }
}


@end
