//
//  NSObject+Caculator.h
//  RacDemo
//
//  Created by zhw on 2018/6/1.
//  Copyright © 2018年 zhw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CaculatorMaker;

@interface NSObject (Caculator)

// 计算
+ (int)makeCaculators:(void(^)(CaculatorMaker *make))caculatorMakerBlock;

@end
