//
//  UserViewController.m
//  MLottery
//
//  Created by Jack on 4/13/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import "UserViewController.h"
#import "UserViewModel.h"
#import "ViewController.h"

@interface UserViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) UserViewModel* viewModel;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [UserViewModel new];
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Actions
- (IBAction)handleAddUserEvent:(id)sender {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"添加参加抽奖人儿"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入抽奖人员姓名.";
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil]];
    
    __weak typeof(self) weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          UITextField* textField = alertController.textFields.firstObject;
                                                          [weakSelf.viewModel addUserWithName:textField.text completion:^(BOOL success) {
                                                              if (!success) {
                                                                  [[[UIAlertView alloc] initWithTitle:@"添加失败"
                                                                                              message:@"可能已经添加."
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"确定"
                                                                                    otherButtonTitles:nil] show];
                                                              }
                                                              [weakSelf.tableView reloadData];
                                                          }];
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewModel numberOfUsers];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [_viewModel nameWithIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete: {
            [_viewModel deleteUserWithName:[_viewModel nameWithIndexPath:indexPath] completion:^(BOOL success) {
                NSLog(@"delete");
                [self.tableView reloadData];
            }];
        }
            break;
        default:
            break;
    }
}

- (IBAction)handleStartLotteryEvent:(id)sender {
    if (_viewModel.numberOfUsers == 0) {
        return;
    }
    ViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
