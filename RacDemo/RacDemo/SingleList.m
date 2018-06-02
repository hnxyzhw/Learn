//
//  SingleList.m
//  RacDemo
//
//  Created by zhw on 2018/6/2.
//  Copyright © 2018年 zhw. All rights reserved.
//

#import "SingleList.h"

@implementation SingleList

- (instancetype)initWithData:(NSArray *)dataArr {
    if (self = [super init]) {
        //创建首节点
        self.head = [[ListNode alloc] init];
        self.head.data = [dataArr.firstObject intValue];
        self.head.next = nil;
        //设置尾节点
        //新初始化的链表，尾节点就是首节点
        self.hail = self.head;
        
        for (int i = 1; i < dataArr.count; i ++) {
            [self append:[dataArr[i] intValue]];
        }
    }
    return self;
}

//拼接节点
- (void)append:(int)data {
    //创建新节点
    ListNode *node = [[ListNode alloc] init];
    node.data = data;
    node.next = nil;
    
    //之前的尾节点的next节点是现在新的节点
    self.hail.next = node;
    
    //将新节点设置成最新的尾节点
    self.hail = node;
}

//输出当前节点
- (void)printList {
    ListNode *current = self.head;
    while (current) {
        NSLog(@"%ld",(long)current.data);
        current = current.next;
    }
}

//反转链表
- (void)reverse {
    ListNode *prev = nil;
    ListNode *current = self.head;
    self.hail = self.head;
    ListNode *next = nil;
    while (current) {
        next = current.next;
        current.next = prev;
        prev = current;
        current = next;
    }
    self.head = prev;
}

@end
