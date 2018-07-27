//
//  ListTableViewController.m
//  通讯录-OC
//
//  Created by yangfan on 2017/12/26.
//  Copyright © 2017年 yangfan. All rights reserved.
//

#import "ListTableViewController.h"
#import "DetailsTableViewController.h"
#import "Person.h"

@interface ListTableViewController ()

- (IBAction)add:(id)sender;

@property(nonatomic, strong) NSMutableArray<Person *> *personArray;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadData];
    
    
}

-(void)loadData{

   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       
       [NSThread sleepForTimeInterval:1];
       
       NSMutableArray<Person *> *temp = [NSMutableArray array];
       
       for (int i = 0; i< 20; i++) {
           
           Person *p = [[Person alloc]init];
           
           p.name = [NSString stringWithFormat:@"yangfan-%d", i];
           
           p.phone = [NSString stringWithFormat:@"188%08d", arc4random_uniform(100000000)];
           
           p.address = @"AnHuiWuhu";
           
           [temp addObject:p];
           
       }
       
       self.personArray = temp;
       
       dispatch_async(dispatch_get_main_queue(), ^{
           
           [self.tableView reloadData];
           
           
       });
       
       
   });

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.personArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];
    
    Person *person = [self.personArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = person.name;
    
    cell.detailTextLabel.text = person.phone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"list2details" sender:indexPath];

}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
    DetailsTableViewController *vc = [segue destinationViewController];
    
    if(sender != nil){
        
        NSIndexPath *indexPath = sender;
        
        Person *person = [self.personArray objectAtIndex:indexPath.row];
        
        vc.person = person;
        
        vc.completionCallback = ^(){
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            
        };

    
    }
    
    else{
    
        __weak typeof(vc) weakVc = vc;
        
        vc.completionCallback = ^(){
            
            [self.personArray insertObject:weakVc.person atIndex:0];
            
            [self.tableView reloadData];

        };

    }
    
    
}


- (IBAction)add:(id)sender {
    
    [self performSegueWithIdentifier:@"list2details" sender:nil];
}
@end
