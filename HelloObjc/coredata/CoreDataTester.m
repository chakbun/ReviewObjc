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

- (void)insert {
    Employee *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.moc];
    employee.sn = @"em_1001";
    employee.name = @"Zach";
    employee.age = 15;
    
    NSError *err;
    if([self.moc hasChanges]) {
        BOOL result = [self.moc save:&err];
        NSLog(@"============ result:%@ ============", result?@"YES":@"NO");
    }
    
    if (err) {
        NSLog(@"============ insert err=%@ ============", err);
    }
    
}

@end
