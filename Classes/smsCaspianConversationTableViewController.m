//
//  smsCaspianConversationTableViewController.m
//  linphone
//
//  Created by Ankit Khanna on 3/17/15.
//
//

#import "smsCaspianConversationTableViewController.h"

#import "Utils.h"
#import "PhoneMainView.h"


@interface smsCaspianConversationTableViewController ()

@end

@implementation smsCaspianConversationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGRect currentFrame = self.view.frame;
    if (currentFrame.origin.y < 0) {
        self.view.frame = CGRectMake(currentFrame.origin.x, 80, currentFrame.size.width, currentFrame.size.height);
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

@end
