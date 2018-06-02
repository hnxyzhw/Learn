//
//  CaculatorMaker.m
//  RacDemo
//
//  Created by zhw on 2018/6/1.
//  Copyright © 2018年 zhw. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (CaculatorMaker *(^)(int))add {
    __weak typeof(self) weakSelf = self;
    return ^CaculatorMaker *(int value) {
        weakSelf.result = weakSelf.result + value;
        return weakSelf;
    };
}

- (CaculatorMaker *(^)(int))sub {
    __weak typeof(self) weakSelf = self;
    return ^CaculatorMaker *(int value) {
        weakSelf.result = weakSelf.result - value;
        return weakSelf;
    };
}

- (CaculatorMaker *(^)(int))muilt {
    __weak typeof(self) weakSelf = self;
    return ^CaculatorMaker *(int value) {
        weakSelf.result = weakSelf.result * value;
        return weakSelf;
    };
}

- (CaculatorMaker *(^)(int))divide {
    __weak typeof(self) weakSelf = self;
    return ^CaculatorMaker *(int value) {
        weakSelf.result = weakSelf.result / value;
        return weakSelf;
    };
}

- (void)testNoParam {
    NSLog(@". language Method");
}

- (int)testNoParamReturnValue {
    NSLog(@". language Method Return value");
    return 11;
}

- (CaculatorMaker *)caculator:(int(^)(int result))caculator {
    self.result = caculator(self.result);
    return self;
}
//- (CaculatorMaker *)caculator:(int (^)(int))caculator {
//    self.result = caculator(self.result);
//    return self;
//}

- (CaculatorMaker *)equle:(BOOL (^)(int))operation {
    self.isEqule = operation(self.result);
    return self;
}
@end
