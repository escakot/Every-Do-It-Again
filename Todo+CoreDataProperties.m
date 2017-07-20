//
//  Todo+CoreDataProperties.m
//  Every Do It Again
//
//  Created by Errol Cheong on 2017-07-20.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "Todo+CoreDataProperties.h"

@implementation Todo (CoreDataProperties)

+ (NSFetchRequest<Todo *> *)fetchRequest {
//	return [[NSFetchRequest alloc] initWithEntityName:@"Todo"];
    return [NSFetchRequest fetchRequestWithEntityName:@"Todo"];
}

@dynamic deadline;
@dynamic isCompleted;
@dynamic priority;
@dynamic title;
@dynamic todoDescription;

@end
