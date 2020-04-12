//
//  CoreDataTester.h
//  HelloObjc
//
//  Created by jaben on 2020/4/11.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataTester : NSObject

- (void)createManagerObjectContext;

- (void)addEmployeeName:(NSString *)name age:(NSInteger)age sn:(NSString *)sn;

- (void)deleteEmployeeWithName:(NSString *)name age:(NSInteger)age sn:(NSString *)sn;

- (NSArray *)queryEmployeeWithName:(NSString *)name age:(NSUInteger)age sn:(NSString *)sn;

@end

NS_ASSUME_NONNULL_END
