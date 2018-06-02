//
//  ViewController.m
//  RacDemo
//
//  Created by zhw on 2018/5/31.
//  Copyright © 2018年 zhw. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACReturnSignal.h>
#import "NSObject+Caculator.h"
#import "CaculatorMaker.h"
#import "SecondViewController.h"
#import "SingleList.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic,strong) id proxy;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // RAC
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据1：%@",x);
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据2：%@",x);
    }];
    
    
    //RACSubject使用步骤,向有序的订阅者，发送信号，会按照顺序调用订阅者的block
    RACSubject *subObject = [RACSubject subject];
    
    [subObject subscribeNext:^(id  _Nullable x) {
        NSLog(@"=====first RACSubscriber:%@",x);
    }];
    
    [subObject subscribeNext:^(id  _Nullable x) {
        NSLog(@"=====second RACSubscriber:%@",x);
    }];
    
    [subObject sendNext:@"test1"];
    [subObject sendNext:@"test2"];
    
    //RACReplaySubject使用，可以先订阅信号，也可以先发送信号。
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    [replaySubject sendNext:@"test001"];
    [replaySubject sendNext:@"test002"];
    
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"==== first RACReplaySubject:%@",x);
    }];
    
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"==== second RACReplaySubject:%@",x);
    }];
    
    // 链式编程
    int result = [NSObject makeCaculators:^(CaculatorMaker *maker) {
        maker.add(1).add(1).add(3).muilt(4).divide(5);
        //当函数没人任何参数时，可以使用.语法直接调用，这也是为什么像Masonry
        //maker.testNoParam;
        //maker.testNoParamReturnValue;
    }];
    NSLog(@"%i",result);
    
    
    // 函数式编程
    CaculatorMaker *calue = [[CaculatorMaker alloc] init];
    BOOL isEqual = [[[calue caculator:^int(int result) {
        result += 3;
        result += 5;
        return result;
    }] equle:^BOOL(int result) {
        return result == 8;
    }] isEqule] ;
    NSLog(@"===%d",isEqual);
    
    
//    [_inputTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"输出:%@",x);
//    }];
    
    [[_inputTextField.rac_textSignal bind:^RACSignalBindBlock _Nonnull{
        return ^RACSignal*(id value, BOOL *stop){
            // 做好处理，通过信号返回出去.
            // 需要引入头文件 #import <ReactiveObjC/RACReturnSignal.h>
            return [RACSignal return:[NSString stringWithFormat:@"输入的用户名: %@",value]];
        };
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    //文本组合信号
    [self verifyCombination];
    
    [self buttonVerify];
    
    [self verifyTextFieldNextResponder];
    
    //正则替换字符串
    //NSString *resultStr =
    [self verifyRegex:@"how are you" sourceStr:@"%20"];
    [self replaceStr:@"how are you" sourceStr:@"%20"];
    
    //单链表
    SingleList *list = [[SingleList alloc] initWithData:@[@"4",@"6",@"3"]];
    NSLog(@"head:%i====hail:%i",list.head.data,list.hail.data);
    [list printList];
    
    //[list reverse];
    //[list printList];
    NSLog(@"head:%i====hail:%i",list.head.data,list.hail.data);
    
    SingleList *list2 = [[SingleList alloc] initWithData:@[@"9",@"8",@"7"]];
    [list2 printList];
    
    ListNode *current1 = list.head;
    ListNode *current2 = list2.head;
    SingleList *newList = [[SingleList alloc] init];
    while (current1 && current2) {
        NSLog(@"%ld==%ld",(long)current1.data,(long)current2.data);
        
        ListNode *newCode = [self addLists:current1 node2:current2 carry:0];
        [newList append:newCode.data];
        current1 = current1.next;
        current2 = current2.next;
    }
    
    NSLog(@"xxxxxx%@",newList);
}

- (ListNode *)plusAC:(ListNode *)aNode bNode:(ListNode *)bNode {
    if (aNode == NULL) {
        return bNode;
    }
    if (bNode == NULL) {
        return aNode;
    }
    //进位处理
    int carry = 0;
    ListNode *tempAListNode = aNode;
    ListNode *tempBListNOde = bNode;
    ListNode *tempListNode = [[ListNode alloc] init];
    ListNode *newListNode = tempListNode;
    
    while (tempAListNode != NULL || tempBListNOde != NULL || carry != 0) {
        int data = 0;
        if (tempAListNode != NULL) {
            data = tempAListNode.data;
        }
        if (tempBListNOde != NULL) {
            data = tempBListNOde.data;
        }
        data = data + carry;
        
        carry = data/10;
        data = data%10;
        
        ListNode *changeListNode = [[ListNode alloc] init];
        newListNode.next = changeListNode;
        newListNode = newListNode.next;
        
        if (tempAListNode != NULL) {
            tempAListNode = tempAListNode.next;
        }
        if (tempBListNOde != NULL) {
            tempBListNOde = tempBListNOde.next;
        }
    }
    
    return tempListNode.next;
}

- (ListNode *)addLists:(ListNode *)node1 node2:(ListNode *)node2 carry:(int)carry {
    if ( node1 == nil && node2 == nil && carry==0) {
        return nil;
    }
    ListNode *result = [[ListNode alloc] init];
    int value= carry;
    if (node1 != nil){
        value = value + node1.data;
    }
    if (node2 != nil){
        value = value + node2.data;
    }
    result.data = value%10;
    ListNode *more = [self addLists:(node1 == nil?nil:node1.next) node2:(node2 == nil? nil: node2.next) carry:(value/10==1?1:0)];
    result.next= more;
    return result;
}

// 验证输入的文本是否符合要求
- (void)verifyCombination {
    id single = @[[self.inputTextField rac_textSignal], [self.inputPwdTextField rac_textSignal]];
    @weakify(self);
    [[RACSignal combineLatest:single] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        NSString *inputName = [x first];
        NSString *inputPwd = [x second];
        
        if (inputName.length > 0 && inputPwd.length > 0) {
            self.loginButton.enabled = YES;
        } else {
            self.loginButton.enabled = NO;
        }
    }];
}

// 监听按钮
- (void)buttonVerify {
    @weakify(self);
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSLog(@"inputName: %@, inputPwd: %@",self.inputTextField.text,self.inputPwdTextField.text);
        // 递归N阶楼梯算法验证
        [self verifyLoftSteps:@"50"];
    }];
    
}

//验证正则匹配
- (NSString *)verifyRegex:(NSString *)originStr sourceStr:(NSString *)sourceStr {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arr = [regex matchesInString:originStr options:NSMatchingReportCompletion range:NSMakeRange(0, originStr.length)];
    arr = [[arr reverseObjectEnumerator] allObjects];
    for (NSTextCheckingResult *str in arr) {
        originStr = [originStr stringByReplacingCharactersInRange:[str range] withString:sourceStr];
    }
    NSLog(@"====%@====",originStr);
    return originStr;
}

//系统方法替换
- (NSString *)replaceStr:(NSString *)originStr sourceStr:(NSString *)sourceStr {
    originStr = [originStr stringByReplacingOccurrencesOfString:@" " withString:sourceStr];
    NSLog(@"====%@====",originStr);
    return originStr;
}

// 验证递归算法
- (void)verifyLoftSteps:(NSString *)inputStr {
    int value = [inputStr intValue];
    if (value > 77) {
        NSLog(@"数据长度过大，会越界");
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //动态规划算法，缩短计算时间，降低成本
        NSString *results = [self newCacul:value];
        //递归算法，如果处理的数据量过大，那么运算时会过于耗
        //long long allmethod = [self cacul:value];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"result = %@",results);
            //NSLog(@"all = %ld",(long)allmethod);
        });
    });
}

// 动态递归，动态规划算法
- (NSString *)newCacul:(int)allSteps {
    NSMutableArray *resutlsArr = [NSMutableArray array];
    resutlsArr[0] = @"0";
    resutlsArr[1] = @"1";
    resutlsArr[2] = @"2";
    resutlsArr[3] = @"4";
    for (int i = 4; i <= allSteps; i ++) {
        resutlsArr[i] = [NSString stringWithFormat:@"%lli",([resutlsArr[i - 1]  longLongValue] + [resutlsArr[i - 2] longLongValue] + [resutlsArr[i - 3] longLongValue])];
    }
    return resutlsArr[allSteps];
}

// 常规的递归方法
- (long long)cacul:(int) allSteps {
    if (allSteps < 0) {
        return 0;
    }
    if (allSteps == 0 || allSteps == 1) {
        return 1;
    }
    return [self cacul:(allSteps-1)]+[self cacul:(allSteps-2)] + [self cacul:(allSteps-3)];
}

// 验证textField的输入是，回车键盘
- (void)verifyTextFieldNextResponder {
    @weakify(self);
    self.proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UITextFieldDelegate)];
    [[self.proxy rac_signalForSelector:@selector(textFieldShouldReturn:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if (self.inputTextField.hasText) {
            [self.inputPwdTextField becomeFirstResponder];
        } else {
            [self.inputTextField resignFirstResponder];
        }
    }];
    self.inputTextField.delegate = (id<UITextFieldDelegate>)self.proxy;
}

- (IBAction)btnClick:(id)sender {
    SecondViewController *secVC = [[SecondViewController alloc] init];
    secVC.delegateSubject = [RACSubject subject];
    [secVC.delegateSubject subscribeNext:^(id  _Nullable x) {
        //通知回调
        NSLog(@"====点击了通知按钮");
    }];
    [self presentViewController:secVC animated:YES completion:^{
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
