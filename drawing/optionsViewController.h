//
//  optionsViewController.h
//  drawing
//
//  Created by sean carlisle on 3/1/13.
//  Copyright (c) 2013 sean carlisle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface optionsViewController : UIViewController



@property (nonatomic, assign) id delegate;
@property (nonatomic)int height, width, mines;
@property float difficulty;
@property IBOutlet UISlider *hSlider,*wSlider, *mSlider;
@property IBOutlet  UILabel *hLbl,*wLbl,*mLbl;

-(id)initWithHeight:(int)h Width:(int)w Mines:(int)m;

-(IBAction)ok;
- (IBAction)heightChanged:(UISlider *)sender;
- (IBAction)widthChanged:(UISlider *)sender;
- (IBAction)minesChanged:(UISlider *)sender;

@end

