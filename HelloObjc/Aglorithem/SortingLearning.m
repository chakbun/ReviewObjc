//
//  SortingLearning.m
//  HelloObjc
//
//  Created by edz on 2021/9/2.
//  Copyright © 2021 Jaben. All rights reserved.
//

#import "SortingLearning.h"

@interface VTNode : NSObjectX
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) VTNode *leftChild;
@property (nonatomic, strong) VTNode *rightChild;
@end

@implementation VTNode

- (NSString *)description {
    return [NSString stringWithFormat:@"Value=%li", self.value];
}
@end

@interface VTStack : NSObject
@property (nonatomic, strong) NSMutableArray<VTNode *> *stack;
@property (nonatomic, readonly) BOOL isEmpty;
- (void)push:(VTNode *)obj;
- (VTNode *)pop;

@end

@implementation VTStack

- (instancetype)init {
    if (self = [super init]) {
        _stack = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isEmpty {
    return self.stack.count == 0;
}

- (void)push:(VTNode *)obj {
    [self.stack addObject:obj];
}

- (VTNode *)pop {
    VTNode *top = [self.stack lastObject];
    [self.stack removeLastObject];
    return top;
}

@end

void preOrderRecursion(VTNode *node, NSMutableArray **resultArr) {
    if (node) {
        NSLog(@"%li", node.value);
        [(*resultArr) addObject:node];
        preOrderRecursion(node.leftChild, resultArr);
        preOrderRecursion(node.rightChild, resultArr);
    }else {
        return;
    }
}

void preOrderIteration(VTNode *node, NSMutableArray **resultArr) {
    VTStack *stack = [VTStack new];
    VTNode *currentNode = node;
    
    while (currentNode || !stack.isEmpty) {
        if (currentNode) {
            NSLog(@"%li", currentNode.value);
            [(*resultArr) addObject:currentNode];
            [stack push:currentNode];
            currentNode = currentNode.leftChild;

        }else {
            VTNode *top = [stack pop];
            currentNode = top.rightChild;
        }
    }
}

void inOrderIteration(VTNode *node, NSMutableArray **resultArr) {
    VTStack *stack = [VTStack new];
    VTNode *currentNode = node;
    
    while (currentNode || !stack.isEmpty) {
        if (currentNode) {

            [stack push:currentNode];
            
            currentNode = currentNode.leftChild;

        }else {
            VTNode *top = [stack pop];
            NSLog(@"%li", top.value);
            [(*resultArr) addObject:top];
            currentNode = top.rightChild;
        }
    }
}

void inOrderRecursion(VTNode *node, NSMutableArray **resultArr) {
    if (node != nil) {
        inOrderRecursion(node.leftChild, resultArr);
        NSLog(@"%li", node.value);
        [(*resultArr) addObject:node];
        inOrderRecursion(node.rightChild, resultArr);
    }else {
        return;
    }
}

void postOrderIteration(VTNode *node, NSMutableArray **resultArr) {
    VTStack *stack = [VTStack new];
    VTNode *currentNode = node;
    VTNode *lastNode = nil;

    while (currentNode || !stack.isEmpty) {
        if (currentNode) {
            [stack push:currentNode];
            currentNode = currentNode.leftChild;
        }else {
            VTNode *top = [stack pop];
            //判断右边节点是否遍历了。
            if (top.rightChild == lastNode || (top.leftChild == nil && top.rightChild == nil)) {
                lastNode = top;
                NSLog(@"%li", top.value);
                [(*resultArr) addObject:top];
            }else {
                currentNode = top.rightChild;
            }
        }
    }
}

void postOrderRecursion(VTNode *node, NSMutableArray **resultArr) {
    if (node != nil) {
        inOrderRecursion(node.leftChild, resultArr);
        inOrderRecursion(node.rightChild, resultArr);
        NSLog(@"%li", node.value);
        [(*resultArr) addObject:node];
    }else {
        return;
    }
}

NSArray * bubbleSortting(NSArray *array) {
    NSMutableArray *sortedArray = [NSMutableArray arrayWithArray:array];
    int countting = 0;
    for (int completedCount = 0; completedCount < array.count - 1; completedCount++) {
        for (int index = 0; index < array.count - 1 - completedCount; index++) {
            countting++;
            if([sortedArray[index] intValue] > [sortedArray[index + 1] intValue]) {
                [sortedArray exchangeObjectAtIndex:index withObjectAtIndex:index + 1];
            }
        }
    }
    NSLog(@"bubbleSortting=>n=%li,O(n)=%i result=%@", array.count, countting, sortedArray);
    return sortedArray;
}

NSArray * selectSortting(NSArray *array) {
    NSMutableArray *sortedArray = [NSMutableArray arrayWithArray:array];
    int countting = 0;
    for (int round = 0; round < array.count - 1; round++) {
        int minIndex = round;
        for (int index = round; index < array.count; index++) {
            countting++;
            if([sortedArray[index] intValue] < [sortedArray[minIndex] intValue]) {
                minIndex = index;
            }
        }
        [sortedArray exchangeObjectAtIndex:minIndex withObjectAtIndex:round];
    }
    NSLog(@"selectSortting=>n=%li,O(n)=%i result=%@", array.count, countting, sortedArray);
    return sortedArray;
}

NSArray * insertSortting(NSArray *array) {
    NSMutableArray *sortedArray = [NSMutableArray arrayWithArray:array];
    int countting = 0;
    for (int round = 0; round < array.count; round++) {
        for (int index = round; index > 0; index--) {
            countting++;
            if ([sortedArray[index] intValue] < [sortedArray[index - 1] intValue]) {
                [sortedArray exchangeObjectAtIndex:index withObjectAtIndex:index - 1];
            }else {
                break;
            }
        }
    }
    NSLog(@"insertSortting=>n=%li,O(n)=%i result=%@", array.count, countting, sortedArray);
    return sortedArray;
}

NSArray * quickSortting(NSArray *array) {
    return @[];
}

@implementation SortingLearning

@end
