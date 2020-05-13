//
//  KVOCTester.m
//  HelloObjc
//
//  Created by jaben on 2020/5/13.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "KVOCTester.h"
#import "KVOPerson.h"

@interface KVOCTester ()

@property (nonatomic, strong) KVOPerson *person;

@end

@implementation KVOCTester

- (void)kvcTesting {
    
    self.person = [KVOPerson quickPersonWithName:@"Zach" age:16];
    NSString *name = [self.person valueForKey:@"name"];
    int age = [[self.person valueForKey:@"age"] intValue];
    KVOAddress *addresssss = [self.person valueForKey:@"address"];
    
    //keypath
    NSString *line = [self.person valueForKeyPath:@"address.line"];
    
    //collection operator
    NSArray *cards = [self.person valueForKey:@"cards"];
    NSNumber *sum = [cards valueForKeyPath:@"@sum.fee"];
    NSNumber *avg = [cards valueForKeyPath:@"@avg.fee"];
    NSNumber *max = [cards valueForKeyPath:@"@max.fee"];
    NSNumber *min = [cards valueForKeyPath:@"@min.fee"];
    NSNumber *count = [cards valueForKeyPath:@"@count"];
    
    NSArray *distinctLevels = [cards valueForKeyPath:@"@distinctUnionOfObjects.level"];
    NSLog(@"============ distinctLevels: %@ ============", distinctLevels);
    
    NSArray *allLevels = [cards valueForKeyPath:@"@unionOfObjects.level"];
    NSLog(@"============ all level: %@ ============", allLevels);
    
    [self.person addObserver:self forKeyPath:NSStringFromSelector(@selector(name)) options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
}

- (void)cleanObserver {
    [self.person removeObserver:self forKeyPath:NSStringFromSelector(@selector(name))];
}

- (void)kvoTesting {
    self.person.name = @"Jaben";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"keyPath: %@", keyPath);
    NSLog(@"object: %@", object);
    NSLog(@"change: %@", change);

}

@end
