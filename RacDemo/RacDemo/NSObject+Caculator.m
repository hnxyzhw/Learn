//
//  NSObject+Caculator.m
//  RacDemo
//
//  Created by zhw on 2018/6/1.
//  Copyright © 2018年 zhw. All rights reserved.
//

#import "NSObject+Caculator.h"
#import "CaculatorMaker.h"

@implementation NSObject (Caculator)

+ (int)makeCaculators:(void (^)(CaculatorMaker *))caculatorMakerBlock {
    CaculatorMaker *mgr = [[CaculatorMaker alloc] init];
    caculatorMakerBlock(mgr);
    return mgr.result;
}

@end
