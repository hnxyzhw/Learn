//
//  ListNode.h
//  RacDemo
//
//  Created by zhw on 2018/6/2.
//  Copyright © 2018年 zhw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject

//节点数据
@property (nonatomic, assign) int data;

//下一个节点
@property (nonatomic, strong) ListNode *next;

@end
