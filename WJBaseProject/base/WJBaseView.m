//
//  WJBaseView.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJBaseView.h"

@interface WJBaseView ()

@property (nonatomic,assign) BOOL initFlag;

@end

@implementation WJBaseView

-(instancetype)init{
    if (self=[super init]) {
        
        [self initViews];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self=[super initWithCoder:aDecoder]) {
        [self setupViews];
    }
    
    return self;
}

- (void)initViews{
    if (_initFlag) {
        return;
    }
    _initFlag=YES;
    [self setupViews];
}

-(void)setupViews{
    
};

@end
