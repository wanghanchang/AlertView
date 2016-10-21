//
//  ViewController.m
//  HttpAlert
//
//  Created by 匹诺曹 on 16/10/20.
//  Copyright © 2016年 匹诺曹. All rights reserved.
//

#import "ViewController.h"

#import "HTTPErrorAlert.h"
#import "PNCAutoAlertDialog.h"
#import "PNCAlertDialog.h"
#import "PNCAlertStarDialog.h"
#import "PNCDatePickerDialog.h"
#import "PNCInputDialog.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,StarScoreDelegate>
@property (nonatomic,strong) NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.array = @[@"网络错误",@"自动消失",@"普通提示框",@"星星",@"日期选择",@"输入框"];
    tab.delegate = self;
    tab.dataSource = self;
    [self.view addSubview:tab];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [HTTPErrorAlert handleError:DB_ERROR];
            break;
        case 1:
            [[PNCAutoAlertDialog autoAlertWithPic:@"kakaka" andTitle:@"test"] hideWithinSecond:1.5 after:1.0];
            break;
        case 2:
            [[PNCAlertDialog alertWithTitle:@"测试" andMessage:@"语言" containsButtonTitles:@[@"确定",@"取消"] buttonTapEventsBlock:^(PNCDialog *dialog, int buttonIndex) {
                if (buttonIndex == 1) {
                    [dialog hide];
                }
            }] show];
            break;
        case 3:
            [[PNCAlertStarDialog alertWithStarRating:@"采纳"
                                          andMessage:@"给一个评分吧"
                                containsButtonTitles:@[@"取消",@"确定"]
                                andStarScoreDelegate:self
                                buttonTapEventsBlock:^(PNCDialog *dialog, int buttonIndex) {
                                    [dialog hide];
                                    
                                }] show];
            break;
        case 4:
            [PNCDatePickerDialog pickDateWithBlock:^(NSDate *date) {
                NSLog(@"%@",date);
            }];
            break;
        case 5:
            [[PNCInputDialog inputWithTitle:@"输入" andHint:@"请输入内容" andOriginText:@"测试" containsButtonTitles:@[@"确定",@"取消"] andCommitBlock:^(PNCDialog *dialog, NSString *content, int buttonIndex) {
                [dialog hide];
            }] show];
            break;
        default:
            break;
    }
}

- (void)starScoreView:(PNCStarRatingView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent {
    NSLog(@"%.2f",newScorePercent);
}

@end
