//
//  SecondViewController.h
//  RacDemo
//
//  Created by zhw on 2018/6/1.
//  Copyright © 2018年 zhw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface SecondViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSubject;

@end
