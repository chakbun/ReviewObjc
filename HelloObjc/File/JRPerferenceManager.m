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

+ (BOOL)saveDictionary:(NSDictionary *)data toPlist:(NSString *)plistName {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        NSString *documentPath = paths[0];
        NSLog(@"document path : %@", documentPath);
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.plist", documentPath, plistName];
        return [data writeToFile:filePath atomically:YES];
    }
    
    return NO;
    
}



@end
