//
//  AREditProfileSingleTableViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 10/23/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "AREditProfileSingleTableViewController.h"
#import "KPEditTextTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface AREditProfileSingleTableViewController ()

@end

@implementation AREditProfileSingleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"KPEditTextTableViewCell" bundle:nil] forCellReuseIdentifier:@"editCell"];

    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onSave:)];
//    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel:)];
//    self.navigationItem.leftBarButtonItem = cancel;
    self.navigationItem.rightBarButtonItem = saveItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPEditTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.editField.text = self.placeHolder;
    return cell;
}

#pragma mark - Private Method

- (void) onSave:(id)sender {
    KPEditTextTableViewCell *cell = (KPEditTextTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([self.type isEqualToString:@"displayname"]) {
        PFUser *user = [PFUser currentUser];
        [user setObject:cell.editField.text forKey:self.type];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            //loading and refresh
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadEditProfile" object:nil userInfo:nil];
            [self.navigationController popViewControllerAnimated:YES];
//            [self dismissViewControllerAnimated:YES completion:^{
//            }];
        }];
    } else if ([self.type isEqualToString:@"email"]) {
        PFUser *user = [PFUser currentUser];
        [user setObject:cell.editField.text forKey:self.type];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            //loading and refresh
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadEditProfile" object:nil userInfo:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {
        PFUser *user = [PFUser currentUser];
        [user setObject:cell.editField.text forKey:self.type];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            //loading and refresh
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadEditProfile" object:nil userInfo:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

@end
