//
//  CopyTester.m
//  HelloObjc
//
//  Created by jaben on 2020/4/1.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "CopyTester.h"

@implementation CopyTester

- (void)test {
    NSArray *arr = @[@"a",@"b",@"c"];
    NSArray *arrCopy = [arr copy];
    
    NSArray *arrMutableCopy = [arr mutableCopy];
    
    NSLog(@"arr[%p]=> %@, firstObject[%p]=>%@", arr, arr, arr[0], arr[0]);
    NSLog(@"arrCopy[%p]=> %@, firstObject[%p]=>%@", arrCopy, arrCopy, arrCopy[0], arrCopy[0]);
    NSLog(@"arrMutableCopy[%p]=> %@, firstObject[%p]=>%@", arrMutableCopy, arrMutableCopy, arrMutableCopy[0], arrMutableCopy[0]);
    
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:arr];
    NSMutableArray *mArrCopy = [mArr copy];
    NSMutableArray *mArrMutableCopy = [mArr mutableCopy];
    
    NSLog(@"mArr[%p]=> %@, firstObject[%p]=>%@", mArr, mArr, mArr[0], mArr[0]);
    NSLog(@"mArrCopy[%p]=> %@, firstObject[%p]=>%@", mArrCopy, mArrCopy, mArrCopy[0], mArrCopy[0]);
    NSLog(@"mArrMutableCopy[%p]=> %@, firstObject[%p]=>%@", mArrMutableCopy, mArrMutableCopy, mArrMutableCopy[0], mArrMutableCopy[0]);
    
    [mArr addObject:@"d"];
    
    NSLog(@"mArr[%p]=> %@", mArr, mArr);
    NSLog(@"mArrCopy[%p]=> %@", mArrCopy, mArrCopy);
    NSLog(@"mArrMutableCopy[%p]=> %@", mArrMutableCopy, mArrMutableCopy);
    
    
//    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arr];
//    NSArray *tArr = [NSArray arrayWithObject:mutableArray];
//    NSArray *tCArr = [tArr copy];
//    NSArray *tMCaR = [tArr mutableCopy];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arr];
    NSMutableArray *tArr = [NSMutableArray arrayWithObject:mutableArray];
    NSMutableArray *tCArr = [tArr copy];
    NSMutableArray *tMCaR = [tArr mutableCopy];
    
    [mutableArray addObject:@"123"];

//    NSLog(@"arr=>%p, arrCopy=>%p, arrMutableCopy=>%p", arr, arrCopy, arrMutableCopy);
    
    NSString *str = @"this is a string";
    NSString *strCopy = [str copy];
    NSString *strMutableCopy = [str mutableCopy];
    
    str = @"xx";

    NSLog(@"str[%p]=> %@", str, str);
    NSLog(@"strCopy[%p]=> %@", strCopy, strCopy);
    NSLog(@"strMutableCopy[%p]=> %@", strMutableCopy, strMutableCopy);
    
    NSMutableString *mStr = [NSMutableString stringWithString:str];
    NSMutableString *mStrCopy = [mStr copy];
    NSMutableString *mStrMutableCopy = [mStr mutableCopy];
    
    NSLog(@"mStr[%p]=> %@", mStr, mStr);
    NSLog(@"mStrCopy[%p]=> %@", mStrCopy, mStrCopy);
    NSLog(@"mStrMutableCopy[%p]=> %@", mStrMutableCopy, mStrMutableCopy);
    
    [mStr appendString:@" is what ?"];
    NSLog(@"mStr[%p]=> %@", mStr, mStr);
    NSLog(@"mStrCopy[%p]=> %@", mStrCopy, mStrCopy);
    NSLog(@"mStrMutableCopy[%p]=> %@", mStrMutableCopy, mStrMutableCopy);
}

@end
