//
//  ViewController.m
//  ROCDatePicker
//
//  Created by HsuanYingHuang on 2014/3/14.
//  Copyright (c) 2014年 HsuanYingHuang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *aryYear;
	NSMutableArray *aryMonth;
    NSMutableArray *aryDay;
    
    NSString *didSelectYear;
    NSString *didSelectMonth;
    NSString *didSelectDay;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy"];
    NSDate *Year = [[NSDate alloc] init];
    NSString *YearString = [format stringFromDate:Year];
    NSInteger intYear = [YearString integerValue];
    
    aryYear = [[NSMutableArray alloc] init];
    aryMonth = [[NSMutableArray alloc] init];
    aryDay = [[NSMutableArray alloc] init];
    
    
    for (int i=1; i<=(intYear - 1911); i++) {
        [aryYear addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i=1; i<=12; i++) {
        [aryMonth addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    [self remakeAryDay:31];
    didSelectYear = [aryYear objectAtIndex:[aryYear count]-1];
    didSelectMonth = @"1";
    didSelectDay = @"1";
    [pv selectRow:([aryYear count]-1) inComponent:0 animated:false];
    [pv selectRow:(0) inComponent:1 animated:false];
    [pv selectRow:(0) inComponent:2 animated:false];
}

- (void)remakeAryDay:(int)ExpectDay
{
    NSMutableArray *day = [[NSMutableArray alloc] init];
    for (int i=1; i<=ExpectDay; i++){
        [day addObject:[NSString stringWithFormat:@"%d",i]];
    }
    aryDay = day;
}

- (BOOL)determineYear:(int)year
{
    BOOL determine;
    if (year%400==0) {
        NSLog(@"閏年");
        determine = YES;
    }
    else if(year%100==0){
        NSLog(@"平年");
        determine = NO;
    }
    else if(year%4==0){
        NSLog(@"閏年");
        determine = YES;
    }
    else{
        NSLog(@"平年");
        determine = NO;
    }
    return determine;
}

- (void)settingDay
{
    int year = [didSelectYear intValue]+1911;
    BOOL determine = [self determineYear:year];
    if (determine) {
        if ([didSelectMonth intValue]==2) {
            [self remakeAryDay:29];
            [pv reloadAllComponents];
        }
    }
    else{
        if ([didSelectMonth intValue]==2) {
            [self remakeAryDay:28];
            [pv reloadAllComponents];
        }
    }
    if ([didSelectMonth intValue]==1) {
        [self remakeAryDay:31];
        [pv reloadAllComponents];
    }
    if ([didSelectMonth intValue]==3) {
        [self remakeAryDay:31];
        [pv reloadAllComponents];
    }
    if ([didSelectMonth intValue]==4) {
        [self remakeAryDay:30];
        [pv reloadAllComponents];
    }
    if ([didSelectMonth intValue]==5) {
        [self remakeAryDay:31];
        [pv reloadAllComponents];
    }
    if ([didSelectMonth intValue]==6) {
        [self remakeAryDay:30];
        [pv reloadAllComponents];
    }
    if ([didSelectMonth intValue]==7) {
        [self remakeAryDay:31];
        [pv reloadAllComponents];
    }
    if ([didSelectMonth intValue]==8) {
        [self remakeAryDay:31];
        [pv reloadAllComponents];
    }
    if ([didSelectMonth intValue]==9) {
        [self remakeAryDay:30];
        [pv reloadAllComponents];
    }
    if ([didSelectMonth intValue]==10) {
        [self remakeAryDay:31];
        [pv reloadAllComponents];
    }
    if ([didSelectMonth intValue]==11) {
        [self remakeAryDay:30];
        [pv reloadAllComponents];
    }
    if ([didSelectMonth intValue]==12) {
        [self remakeAryDay:31];
        [pv reloadAllComponents];
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	switch (component)
    {
		case 0:
			return [aryYear count];
            break;
        case 1:
            return [aryMonth count];
            break;
        case 2:
            return [aryDay count];
            break;
	}
	return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
	switch (component)
    {
		case 0:
			return [NSString stringWithFormat:@"民國%@年",[aryYear objectAtIndex:row]];
            break;
        case 1:
            return [NSString stringWithFormat:@"%@月",[aryMonth objectAtIndex:row]];
        case 2:
            return [NSString stringWithFormat:@"%@日",[aryDay objectAtIndex:row]];
            break;
	}
	return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            didSelectYear = [aryYear objectAtIndex:row];
            [self settingDay];
            break;
        case 1:
            didSelectMonth = [aryMonth objectAtIndex:row];
            [self settingDay];
            break;
        case 2:
            didSelectDay = [aryDay objectAtIndex:row];
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
