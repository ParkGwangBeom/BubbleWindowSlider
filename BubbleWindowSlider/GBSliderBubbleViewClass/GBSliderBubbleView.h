//
//  GBSliderBubbleView.h
//  neo_gooddoc_ios
//
//  Created by 박광범 on 2015. 7. 30..
//  Copyright (c) 2015년 YelloMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSlider;

@protocol GBSliderBubbleViewDelegate <NSObject>

@optional
-(void)getSliderDidEndChangeValue:(NSInteger)value;
-(void)getSliderDidChangeValue:(NSInteger)value;
@end


@interface GBSliderBubbleView : UIView

@property (nonatomic, assign) id<GBSliderBubbleViewDelegate> delegate;

//Setting
@property (nonatomic, assign) BOOL  isBubbleHideAnimation;
@property (nonatomic, assign) float minValue;
@property (nonatomic, assign) float maxValue;
@property (nonatomic, assign) float defaultValue;

@property (nonatomic, assign) CGRect sliderFrame;
@property (nonatomic, assign) float topMargin;
@property (nonatomic, assign) float leftMargin;
@property (nonatomic, assign) float sliderTrackHeight;



@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) UIImage *minTrackImage;
@property (nonatomic, strong) UIImage *maxTrackImage;
@property (nonatomic, strong) UIImage *bubbleImage;

@property (nonatomic, strong) CustomSlider *slider;
@property (nonatomic, strong) UIView *bubbleView;
@property (nonatomic, strong) UILabel *valueLabel;


- (void)renderSliderBubbleView;

@end



