//
//  SingleList.h
//  RacDemo
//
//  Created by zhw on 2018/6/2.
//  Copyright © 2018年 zhw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

@interface SingleList : NSObject
//首节点
@property (nonatomic, strong) ListNode *head;
//尾节点
@property (nonatomic, strong) ListNode *hail;

//自定义初始化
- (instancetype)initWithData:(NSArray *)dataArr;

//增加节点
- (void)append:(int)data;

//输出链表
- (void)printList;

//反转
- (void)reverse;

@end
