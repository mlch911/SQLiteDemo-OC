//
//  ViewController.m
//  SQLiteDemo
//
//  Created by mlch911 on 2019/4/24.
//  Copyright © 2019 mlch911. All rights reserved.
//

#import "ViewController.h"
#import "SQLiteManager.h"
#import <UIKit/UIKit.h>

@interface ViewController () {
    UITextField *textField1;
    UITextField *textField2;
    UIButton *button1;
    UIButton *button2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(150, 250, 30, 30);
    button1.backgroundColor = [UIColor redColor];
    button1.titleLabel.text = @"插入数据";
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnButton1)];
    [button1 addGestureRecognizer:tap1];
    
    button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(150, 300, 30, 30);
    button2.backgroundColor = [UIColor grayColor];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnButton2)];
    [button2 addGestureRecognizer:tap2];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 100, 10)];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 100, 10)];
    [label1 setText:@"姓名："];
    [label2 setText:@"年龄："];
    textField1 = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    textField2 = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 100, 30)];
    
    [self.view addSubview:textField1];
    [self.view addSubview:textField2];
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:button1];
    [self.view addSubview:button2];
}

- (void)viewDidAppear:(BOOL)animated {
    [[SQLiteManager shareInstance] open];
//    [[SQLiteManager shareInstance] createTableWithName:@"Person" Keys:@"id integer, name text, age integer"];
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"123" message:@"234" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
//    [alertController addAction:action];
//    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[SQLiteManager shareInstance] close];
}

- (void) tapOnButton1 {
    if (textField1.hasText && textField2.hasText) {
        if (textField2.text.intValue) {
            [[SQLiteManager shareInstance] insertPersonWithName:textField1.text age:textField2.text.intValue];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"warnning" message:@"年龄只能填写数字！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"warnning" message:@"姓名或年龄不能为空！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void) tapOnButton2 {
    [[SQLiteManager shareInstance] select];
}

@end
