//
//  DetailsTableViewController.h
//  通讯录-OC
//
//  Created by yangfan on 2017/12/26.
//  Copyright © 2017年 yangfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
@interface DetailsTableViewController : UITableViewController

@property(nonatomic, strong) Person *person;

@property (copy, nonatomic) void (^completionCallback)();


@end
