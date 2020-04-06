//
//  JRPerferenceManager.m
//  HelloObjc
//
//  Created by jaben on 2020/4/6.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "JRPerferenceManager.h"

@implementation JRPerferenceManager

+ (id)valueForKey:(NSString *)key inPlist:(NSString *)plistName {
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
    id value = plist[key];
    if (value) {
        return value;
    }
    return nil;
}



@end
