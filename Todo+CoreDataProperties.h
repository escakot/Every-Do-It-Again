//
//  Todo+CoreDataProperties.h
//  Every Do It Again
//
//  Created by Errol Cheong on 2017-07-20.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "Todo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Todo (CoreDataProperties)

+ (NSFetchRequest<Todo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *deadline;
@property (nonatomic) BOOL isCompleted;
@property (nonatomic) int16_t priority;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *todoDescription;

@end

NS_ASSUME_NONNULL_END
