//
//  CustomSlider.m
//  BubbleWindowSlider
//
//  Created by 박광범 on 2015. 7. 31..
//  Copyright (c) 2015년 YelloMobile. All rights reserved.
//

#import "CustomSlider.h"

@implementation CustomSlider

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

-(void)awakeFromNib{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _trackHeight);
}

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return bounds;
}

@end
