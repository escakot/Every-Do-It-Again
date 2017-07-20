//
//  AddTodoViewController.m
//  Every Do It Again
//
//  Created by Errol Cheong on 2017-07-19.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "AddTodoViewController.h"
#import "Todo+CoreDataClass.h"
#import "AppDelegate.h"

@interface AddTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIView *priorityView;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlineDatePicker;
@property (strong, nonatomic) NSArray<UIColor*> *priorityColors;

@end

@implementation AddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.priorityColors = @[[UIColor greenColor],
                            [UIColor yellowColor],
                            [UIColor orangeColor],
                            [UIColor redColor]];
    
    self.priorityView.backgroundColor = [UIColor greenColor];
    self.priorityView.layer.cornerRadius = self.priorityView.bounds.size.width/2;
    self.descriptionTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.descriptionTextView.layer.borderWidth = 1.0;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePriorityColor:)];
    [self.priorityView addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(UIBarButtonItem*)sender {
//    Todo *newTodo = [[Todo alloc] initWithContext:self.context];
    NSManagedObjectContext *context = [self getContext];
    Todo *newTodo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:context];
    newTodo.title = self.titleTextField.text;
    newTodo.todoDescription = self.descriptionTextView.text;
    newTodo.priority = [self.priorityColors indexOfObject:self.priorityView.backgroundColor];
    newTodo.deadline = [self.deadlineDatePicker date];
    [self.delegate saveNewTodo:newTodo];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changePriorityColor:(UITapGestureRecognizer*)sender{
    NSUInteger newPriority = ([self.priorityColors indexOfObject:self.priorityView.backgroundColor] + 1) % self.priorityColors.count;
    
    self.priorityView.backgroundColor = self.priorityColors[newPriority];
}

# pragma mark - NSManagerContext Methods

- (AppDelegate *)appDelegate {
  return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (NSPersistentContainer *)getContainer{
  return [self appDelegate].persistentContainer;
}

- (NSManagedObjectContext *)getContext {
  return [self getContainer].viewContext;
}


@end
