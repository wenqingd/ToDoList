//
//  TableViewController.m
//  ToDoList
//
//  Created by Wenqing Dai on 8/5/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"

BOOL enableAddItem = YES;

@interface TableViewController ()

@property (nonatomic, retain) NSMutableArray *list;

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"To Do List";
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Edit"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                  action:@selector(editItem)];
    self.navigationItem.leftBarButtonItem = editButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    self.navigationItem.rightBarButtonItem = addButton;

    _list = [[NSMutableArray alloc] init];
 //   self.toDoList.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(void) customCell:(CustomCell*)cell textFieldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [_list removeObjectAtIndex:0];
    if ([textField.text length]>0) {
        [_list insertObject:textField.text atIndex:0];
    }
    
    [[self tableView] reloadData];
    enableAddItem = YES;
     
}

-(void)editItem
{
    [self setEditing:YES animated:YES];

}

-(void)addItem
{
    if (enableAddItem) {
        UINib *customNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
        [_list insertObject:customNib atIndex:0];
        [self.tableView registerNib:customNib forCellReuseIdentifier:@"CustomCell"];
        [[self tableView] reloadData];
        enableAddItem = NO;

    }
    
    
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [self.view endEditing:YES];
//    [_list addObject:textField.text];
//    [[self tableView] reloadData];
//    return YES;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if([[_list objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]){
        static NSString *TextCellIdentifier = @"TextCell";
        [tableView dequeueReusableCellWithIdentifier:TextCellIdentifier];
        if (!cell) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextCellIdentifier];
        }
        cell.textLabel.text = [_list objectAtIndex:indexPath.row];

        
    }
    else if([[_list objectAtIndex:indexPath.row] isKindOfClass:[UINib class]]){
        static NSString *CellIdentifier = @"CustomCell";
        CustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        customCell.textLabel.text = nil;
        customCell.delegate = self;
        cell = customCell;
       // cell.textLabel.text = nil;
        
    }
    // Configure the cell...
    
   // cell.layer.borderColor = [UIColor blueColor].CGColor;
   // cell.layer.borderWidth = 1;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView beginUpdates];
     NSUInteger row = [indexPath row];
     if (editingStyle == UITableViewCellEditingStyleDelete && [[_list objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
         // Delete the row
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
         [_list removeObjectAtIndex:row];
     }
     [tableView reloadData];
     [tableView endUpdates];
 }

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
