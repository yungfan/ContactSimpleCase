//
//  DetailsTableViewController.m
//  通讯录-OC
//
//  Created by yangfan on 2017/12/26.
//  Copyright © 2017年 yangfan. All rights reserved.
//

#import "DetailsTableViewController.h"

@interface DetailsTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *address;



- (IBAction)savePerson:(id)sender;

@end

@implementation DetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    //如果是增加，那么需要新建一个Person
    if (self.person == nil) {
        
        self.title = @"增加";
        
    }
    
}

-(void) setupData{

    if (self.person != nil) {
        
        self.name.text = self.person.name;
        self.phone.text = self.person.phone;
        self.address.text = self.person.address;
    }

}



- (IBAction)savePerson:(id)sender {
    
    
    //如果是增加，那么需要新建一个Person
    if (self.person == nil) {
        
        self.person = [[Person alloc]init];
        
    }
    
    
    self.person.name = self.name.text;
    self.person.phone = self.phone.text;
    self.person.address = self.address.text;
    
    //调用闭包
    _completionCallback();
    
    
    //_忽略警告

    [self.navigationController popViewControllerAnimated:YES];
}
@end
