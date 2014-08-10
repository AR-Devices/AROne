//
//  ARProfileHeaderView.m
//  ARTwo
//
//  Created by Chenchen Zheng on 8/9/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARProfileHeaderView.h"
#import <DZNSegmentedControl.h>

@implementation ARProfileHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    
    self.userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.userIcon.layer.cornerRadius = self.userIcon.bounds.size.height/2;
    self.userIcon.layer.masksToBounds = YES;
    [self.userIcon setCenter:CGPointMake(self.bounds.size.width/2, 100)];
    [self addSubview:self.userIcon];
    
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
    [self.userName setCenter:CGPointMake(self.bounds.size.width/2, 170)];
    [self.userName setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.userName];
    
    self.control = [[DZNSegmentedControl alloc] initWithItems:@[@"Following", @"Follower"]];
    [self.control setFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
    [self.control setCenter:CGPointMake(self.bounds.size.width/2, 220)];
    [self addSubview:self.control];
    
}

@end
