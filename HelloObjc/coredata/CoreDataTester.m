//
//  CoreDataTester.m
//  HelloObjc
//
//  Created by jaben on 2020/4/11.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "CoreDataTester.h"
#import <CoreData/CoreData.h>
#import "Employee.h"

@interface CoreDataTester ()

@property (strong, nonatomic) NSManagedObjectContext *moc;

@end

@implementation CoreDataTester

- (void)createManagerObjectContext {
    
    self.moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];

    // 创建托管对象模型，并使用Company.momd路径当做初始化参数
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"Company" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];

    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", @"Company"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];

    // 上下文对象设置属性为持久化存储器
    self.moc.persistentStoreCoordinator = coordinator;
    
}

- (NSArray *)queryEmployeeWithName:(NSString *)name age:(NSUInteger)age sn:(NSString *)sn {

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSMutableString *params = [NSMutableString stringWithString:@""];
    
    if (name) {
        [params appendFormat:@" name = %@ ", name];
    }
    
    if (age > 0) {
        if (params.length > 0) {
            [params appendString:@" AND "];
        }
        [params appendFormat:@" age = %lu ", age];
    }
    
    if (sn) {
        if (params.length > 0) {
            [params appendString:@" AND "];
        }
        [params appendFormat:@" sn = %@ ", sn];
    }
    
    if (name) {    
        request.predicate = [NSPredicate predicateWithFormat:@" name=%@ ", name];
    }
    
    NSError *err;

    NSArray *result = [self.moc executeFetchRequest:request error:&err];
    
    if (err) {
        NSLog(@"============ query err=%@ ============", err);
    }
    
    return result;
    
}

- (void)addEmployeeName:(NSString *)name age:(NSInteger)age sn:(NSString *)sn {
    Employee *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.moc];
    employee.sn = sn;
    employee.name = name;
    employee.age = age;
    
    NSError *err;
    if([self.moc hasChanges]) {
        BOOL result = [self.moc save:&err];
        NSLog(@"============ result:%@ ============", result?@"YES":@"NO");
        
        if (err) {
            NSLog(@"============ insert err=%@ ============", err);
        }
    }
}

- (void)deleteEmployeeWithName:(NSString *)name age:(NSInteger)age sn:(NSString *)sn {
    
    NSArray *result = [self queryEmployeeWithName:name age:age sn:sn];
    
     __weak __typeof(self) weakSelf = self;
    
    [result enumerateObjectsUsingBlock:^(Employee *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.moc deleteObject:obj];
    }];
    
    NSError *err;

    if ([self.moc hasChanges]) {
        BOOL result = [self.moc save:&err];
        NSLog(@"============ delete result:%@ ============", result?@"YES":@"NO");
        
        if (err) {
            NSLog(@"============ delete err=%@ ============", err);
        }
        
    }
}

@end
