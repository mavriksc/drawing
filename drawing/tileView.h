//
//  tileView.h
//  drawing
//
//  Created by sean carlisle on 11/11/12.
//  Copyright (c) 2012 sean carlisle. All rights reserved.
//
// 60x60 tile that can be drawn normal. depressed, and revealed.
// The value to be displayed is passed upon creation
// it may be better for multiple games to allow the resetting of the state once revealed and the value.
// possibly a new game call. 

#import <UIKit/UIKit.h>

@interface tileView : UIView{
    NSString *_state;
    NSString *_value;
}
@property NSString *state;
@property (readonly) NSString *value;
- (id)initWithFrame:(CGRect)frame andValue:(NSString *)value;
-(void)setStateUp;
-(void)setStateDown;
-(BOOL)isRevealed;
@end
