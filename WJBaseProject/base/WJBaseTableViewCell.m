//
//  WJBaseTableViewCell.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/26.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "WJBaseTableViewCell.h"

@implementation WJBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self update];
        [self setupViews];
    }
    
    return self;
}

-(void)update{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.backgroundView=nil;
    self.backgroundColor=[UIColor clearColor];
}

-(void)setupViews{}

@end
