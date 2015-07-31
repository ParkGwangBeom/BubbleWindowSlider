//
//  ViewController.m
//  BubbleWindowSlider
//
//  Created by 박광범 on 2015. 7. 31..
//  Copyright (c) 2015년 YelloMobile. All rights reserved.
//

#import "ViewController.h"

#import "GBSliderBubbleView.h"

@interface ViewController () <GBSliderBubbleViewDelegate>
@property (weak, nonatomic) IBOutlet GBSliderBubbleView *GBSliderBubbleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.GBSliderBubbleView.delegate = self;
    self.GBSliderBubbleView.isBubbleHideAnimation = NO;
    self.GBSliderBubbleView.maxValue = 1000;
    [self.GBSliderBubbleView renderSliderBubbleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark - GBSliderBubbleViewDelegate
-(void)getSliderDidEndChangeValue:(NSInteger)value{
    NSLog(@"didEndChanged - %ld",value);
}

-(void)getSliderDidChangeValue:(NSInteger)value{
    NSLog(@"didChanged - %ld",value);
}

@end
