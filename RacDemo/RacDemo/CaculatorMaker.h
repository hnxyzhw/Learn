//
//  CaculatorMaker.h
//  RacDemo
//
//  Created by zhw on 2018/6/1.
//  Copyright © 2018年 zhw. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CaculatorMaker : NSObject

@property (nonatomic, assign) int result;

//============链式编程思想
//+
- (CaculatorMaker *(^)(int))add;
//-
- (CaculatorMaker *(^)(int))sub;
//x
- (CaculatorMaker *(^)(int))muilt;
// /
- (CaculatorMaker *(^)(int))divide;

- (void)testNoParam;

- (int)testNoParamReturnValue;


//===========函数式编程思想

@property (nonatomic, assign) BOOL isEqule;

- (CaculatorMaker *)caculator:(int(^)(int result))caculator;

- (CaculatorMaker *)equle:(BOOL(^)(int result))operation;
@end
