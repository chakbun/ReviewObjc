//
//  Department+CoreDataProperties.h
//  HelloObjc
//
//  Created by jaben on 2020/4/11.
//  Copyright © 2020 Jaben. All rights reserved.
//
//

#import "Department.h"


NS_ASSUME_NONNULL_BEGIN

@interface Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sn;
@property (nullable, nonatomic, retain) NSSet<Employee *> *employee;

@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addEmployeeObject:(Employee *)value;
- (void)removeEmployeeObject:(Employee *)value;
- (void)addEmployee:(NSSet<Employee *> *)values;
- (void)removeEmployee:(NSSet<Employee *> *)values;

@end

NS_ASSUME_NONNULL_END
