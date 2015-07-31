//
//  GBSliderBubbleView.m
//  neo_gooddoc_ios
//
//  Created by 박광범 on 2015. 7. 30..
//  Copyright (c) 2015년 YelloMobile. All rights reserved.
//

#import "GBSliderBubbleView.h"

#import "CustomSlider.h"

#define kFontSize 12
#define kFont [UIFont systemFontOfSize:kFontSize]
#define kBoxWidth 50
#define kShowHideAnimationDurtaion 0.5f
#define kSliderHeight 10
#define kSliderBubbleViewMargin 20

@implementation GBSliderBubbleView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self defaults];
}

-(void)defaults{
    //Default init
    _thumbImage = [UIImage imageNamed:@"ThumbImage"];
    _minTrackImage = [UIImage imageNamed:@"MinTrack"];
    _maxTrackImage = [UIImage imageNamed:@"MaxTrack"];
    _bubbleImage = [[UIImage imageNamed:@"BubbleBox"] stretchableImageWithLeftCapWidth:31.0f topCapHeight:11.0f];
    _minValue = 0;
    _maxValue = 100;
    _defaultValue = 20;
    _topMargin = 40.0f;
    _leftMargin = 45.0f;
    _sliderTrackHeight = 10.0f;
    _isBubbleHideAnimation = YES;
    
    [self renderSliderBubbleView];
}

- (void)renderSliderBubbleView{
    float viewMax = MAX(100, self.frame.size.height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, viewMax);
    [self setViewWithSliderFrame:CGRectMake(_leftMargin, _topMargin, self.frame.size.width - (_leftMargin*2), kSliderHeight)];
}

-(void)setViewWithSliderFrame:(CGRect)slideFrame{
    [self clearView];
    
    self.slider = [[CustomSlider alloc]initWithFrame:slideFrame];
    _slider.trackHeight = _sliderTrackHeight;
    _slider.minimumValue = _minValue;
    _slider.maximumValue = _maxValue;
    _slider.value = _defaultValue;
    [_slider setThumbImage:_thumbImage forState:UIControlStateNormal];
    
    //Track set TintColor
    [_slider setMinimumTrackTintColor:[UIColor orangeColor]];
    [_slider setMaximumTrackTintColor:[UIColor lightGrayColor]];
    
    //Track set Image
//    [_slider setMinimumTrackImage:_minTrackImage forState:UIControlStateNormal];
//    [_slider setMinimumTrackImage:_maxTrackImage forState:UIControlStateNormal];
    
    
    [_slider addTarget:self action:@selector(slierValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(sliderTouchEnd:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_slider];

    CGRect initFrame = CGRectMake(0.0f, 0.0f, kBoxWidth, 20.0f);
    self.bubbleView = [[UIView alloc]initWithFrame:initFrame];
    self.bubbleView.center = CGPointMake([self xPositionFromSliderValue:self.slider],  self.slider.frame.origin.y - kSliderBubbleViewMargin);
    
    UIImageView *boxImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, kBoxWidth, 20.0f)];
    [boxImage setImage:_bubbleImage];
    [self.bubbleView addSubview:boxImage];
    
    _valueLabel = [[UILabel alloc]initWithFrame:initFrame];
    [_valueLabel setTextAlignment:NSTextAlignmentCenter];
    _valueLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)self.slider.value];
    [_valueLabel setFont:kFont];
    
    [self.bubbleView addSubview:_valueLabel];
    [self addSubview:self.bubbleView];
    
    [self performSelector:@selector(bubbleViewAnimation) withObject:self afterDelay:1.0f];
    
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _slider.frame.origin.y + _slider.frame.size.height + 20.0f);
}

- (void)clearView
{
    [self.subviews enumerateObjectsUsingBlock:^(UIView *v, NSUInteger idx, BOOL *stop) {
        [v removeFromSuperview];
    }];
}

- (float)xPositionFromSliderValue:(UISlider *)aSlider {
    float sliderRange = aSlider.frame.size.width - aSlider.currentThumbImage.size.width;
    float sliderOrigin = aSlider.frame.origin.x + (aSlider.currentThumbImage.size.width / 2.0);
    
    float sliderValueToPixels = (((aSlider.value - aSlider.minimumValue)/(aSlider.maximumValue - aSlider.minimumValue)) * sliderRange) + sliderOrigin;
    
    return sliderValueToPixels;
}


#pragma mark - 
#pragma mark - BubbleView Animation
-(void)bubbleViewAnimation{
    if(_isBubbleHideAnimation){
        [UIView animateWithDuration:kShowHideAnimationDurtaion animations:^{
            self.bubbleView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.bubbleView.hidden = YES;
        }];
    }
}

#pragma mark - 
#pragma mark - Slider Events
//Slide Changed
-(void)slierValueChanged:(id)sender{
    self.bubbleView.alpha = 1.0f;
    self.bubbleView.hidden = NO;
    _valueLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)self.slider.value];
     self.bubbleView.center = CGPointMake([self xPositionFromSliderValue:self.slider],  self.slider.frame.origin.y - kSliderBubbleViewMargin);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(getSliderDidChangeValue:)]){
        [self.delegate getSliderDidChangeValue:(NSInteger)self.slider.value];
    }
}

//Slide Touch End
-(void)sliderTouchEnd:(id)sender{
    [self performSelector:@selector(bubbleViewAnimation) withObject:self afterDelay:1.0f];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(getSliderDidEndChangeValue:)]){
        [self.delegate getSliderDidEndChangeValue:(NSInteger)self.slider.value];
    }
}

@end
