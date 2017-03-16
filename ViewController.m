//
//  ViewController.m
//  315Learning
//
//  Created by 薛俊友 on 2017/3/15.
//  Copyright © 2017年 薛俊友. All rights reserved.
//

#import "ViewController.h"
#import "ImageUtils.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)whiteSkinClick:(id)sender {
    self.photoImageView.image = [ImageUtils imageWhitening:self.photoImageView.image];
}

- (IBAction)cleanClick:(id)sender {
    self.photoImageView.image = [UIImage imageNamed:@"test"];
}

@end
