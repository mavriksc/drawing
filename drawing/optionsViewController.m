//
//  optionsViewController.m
//  drawing
//
//  Created by sean carlisle on 3/1/13.
//  Copyright (c) 2013 sean carlisle. All rights reserved.
//

#import "optionsViewController.h"
#import "ViewController.h"

@interface optionsViewController ()

@end

@implementation optionsViewController

-(void)setMines:(int)mines{
    _mines=mines;
    self.mLbl.text=[NSString stringWithFormat:@"%i",self.mines];
    [self.mLbl setNeedsDisplay];
}

-(void)setHeight:(int)height{
    _height=height;
    self.hLbl.text=[NSString stringWithFormat:@"%i",self.height];
    [self.hLbl setNeedsDisplay];
}

-(void)setWidth:(int)width{
    _width=width;
    self.wLbl.text=[NSString stringWithFormat:@"%i",self.width];
    [self.wLbl setNeedsDisplay];
}

- (IBAction)heightChanged:(UISlider *)sender{
    self.height = floor(sender.value);
    NSLog(@"height slider=%f",sender.value);

}

- (IBAction)widthChanged:(UISlider *)sender{
    self.width = floor(sender.value);
        NSLog(@"width slider=%f",sender.value);
}

- (IBAction)minesChanged:(UISlider *)sender{
    self.mines =floor( sender.value*self.width*self.height);
        NSLog(@"mines slider = %f",sender.value);
}

-(IBAction)ok
{
    //send message to the delegate with the new settings
    [self.delegate setHeight:_height Width:_width Mines:_mines];
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

-(id)initWithHeight:(int)h Width:(int)w Mines:(int)m{
    
    self=[self initWithNibName:@"optionsViewController" bundle:[NSBundle mainBundle]];
    
    self.width=w;
    self.height=h;
    self.mines=m;
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.wSlider.maximumValue=50;
    self.wSlider.minimumValue=5;
    self.hSlider.maximumValue=50;
    self.hSlider.minimumValue=5;
    self.mSlider.maximumValue=0.4;
    self.mSlider.minimumValue=0.1;
    
    self.hSlider.value=_height;
    [self.hSlider setNeedsDisplay];
    self.wSlider.value=_width;
    [self.wSlider setNeedsDisplay];
    float mineP;
    mineP=(float)_mines/((float)_width*(float)_height);
    self.mSlider.value=mineP;
    [self.mSlider setNeedsDisplay];
    
    self.hLbl.text = [NSString stringWithFormat:@"%i",self.height];
    self.wLbl.text = [NSString stringWithFormat:@"%i",self.width];
    self.mLbl.text = [NSString stringWithFormat:@"%i",self.mines];
    [self.hLbl setNeedsDisplay];
    [self.wLbl setNeedsDisplay];
    [self.mLbl setNeedsDisplay];
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
