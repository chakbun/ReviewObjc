//
//  JRPerferenceManager.h
//  HelloObjc
//
//  Created by jaben on 2020/4/6.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRPerferenceManager : NSObject

+ (id)valueForKey:(NSString *)key inPlist:(NSString *)plistName;

@end

NS_ASSUME_NONNULL_END
