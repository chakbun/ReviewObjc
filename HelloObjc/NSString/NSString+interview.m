//
//  NSString+interview.m
//  HelloObjc
//
//  Created by jaben on 2021/9/12.
//  Copyright © 2021 Jaben. All rights reserved.
//

#import "NSString+interview.h"

@implementation NSString (interview)

- (NSString *)reverseString {
    int size = (int)self.length;
    char reverseArr[size];
    memset(reverseArr, 0, size*sizeof(char));
    
    const char *UTF8String = [self UTF8String];
    for (int i = size - 1; i >= 0; i--) {
        reverseArr[size-i-1] = UTF8String[i];
    }
//    printf(reverseArr);
    return [NSString stringWithUTF8String:reverseArr];
}

@end
