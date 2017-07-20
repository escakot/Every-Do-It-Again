//
//  AddTodoViewController.h
//  Every Do It Again
//
//  Created by Errol Cheong on 2017-07-19.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Todo;
@protocol AddTodoViewControllerDelegate <NSObject>

- (void)saveNewTodo:(Todo*)todo;

@end

@interface AddTodoViewController : UIViewController

@property (weak, nonatomic) id <AddTodoViewControllerDelegate> delegate;

@end
