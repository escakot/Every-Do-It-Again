//
//  ViewController.m
//  Every Do It Again
//
//  Created by Errol Cheong on 2017-07-19.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "ViewController.h"
#import "TodoTableViewCell.h"
#import "AddTodoViewController.h"
#import "AppDelegate.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, AddTodoViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) NSMutableArray<Todo*>* listOfTodos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editDoneButton:)];
    
    
    [self fetchWithSort:@"priority" ascending:NO];
}



# pragma mark - CoreData Methods
- (void)fetchWithSort:(NSString*)sortKey ascending:(BOOL)order
{
    NSSortDescriptor *sortMethod = [NSSortDescriptor sortDescriptorWithKey:sortKey ascending:order];
    NSFetchRequest *request = [Todo fetchRequest];
//   NSFetchRequest *request = [Todo fetchRequest];
    request.sortDescriptors = @[sortMethod];
    NSManagedObjectContext *context = [self getContext];
    NSArray<Todo*>* tempArray = [context executeFetchRequest:request error:nil];
    self.listOfTodos = [tempArray mutableCopy];
}

-(void)setListOfTodos:(NSMutableArray<Todo *> *)listOfTodos
{
    _listOfTodos = listOfTodos;
    [self.tableView reloadData];
}

# pragma mark - UITableView Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listOfTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoCell" forIndexPath:indexPath];
    
    cell.todo = self.listOfTodos[indexPath.row];
    
    return cell;
}

# pragma mark - UITableView Delegate Methods

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    id movingObject = self.listOfTodos[sourceIndexPath.row];
    [self.listOfTodos removeObjectAtIndex:sourceIndexPath.row];
    [self.listOfTodos insertObject:movingObject atIndex:destinationIndexPath.row];
    [self.appDelegate saveContext];
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.listOfTodos removeObjectAtIndex:indexPath.row];
        [self.appDelegate saveContext];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
    
}
# pragma mark - Segue Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"addTodoSegue"]) {
        UINavigationController *navController = segue.destinationViewController;
        AddTodoViewController *addTodoController = navController.viewControllers[0];
        addTodoController.delegate = self;
    }
}

# pragma mark - AddNewTodo Delegate Methods

-(void)saveNewTodo:(Todo *)todo
{
    [self.listOfTodos addObject:todo];
    [self.tableView reloadData];
    [[self appDelegate] saveContext];
}

- (IBAction)editDoneButton:(UIBarButtonItem *)sender {
    if (!self.tableView.isEditing)
    {
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
        self.navigationItem.leftBarButtonItem.style = UIBarButtonSystemItemDone;
        self.tableView.editing = YES;
    } else {
        [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
        self.tableView.editing = NO;
    }
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
