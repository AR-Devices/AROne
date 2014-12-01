//
//  ARPairController.m
//  AROne
//
//  Created by Chenchen Zheng on 5/27/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARPairController.h"
#import "DKCircleButton.h"
#import "LGBluetooth.h"


@interface ARPairController ()
@property BOOL buttonState;
@property DKCircleButton *scanButton;
@property UILabel *status;

@end

@implementation ARPairController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      [self.view setBackgroundColor:[UIColor lightGrayColor]];
      self.status = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
      self.status.center = CGPointMake(self.view.bounds.size.width/2, 0.3*self.view.bounds.size.height);
      self.status.textAlignment = NSTextAlignmentCenter;
      [self.status setTextColor:[UIColor whiteColor]];
      [self.status setText:@"Click on Scan to search"];
      [self.view addSubview:self.status];
      
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Initialization of CentralManager
  [LGCentralManager sharedInstance];
  
  self.scanButton = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
  
  self.scanButton.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
  self.scanButton.titleLabel.font = [UIFont systemFontOfSize:22];
  [self.scanButton setTitle:NSLocalizedString(@"Scan", nil) forState:UIControlStateNormal];
  [self.scanButton setTitle:NSLocalizedString(@"Scan", nil) forState:UIControlStateSelected];
  [self.scanButton setTitle:NSLocalizedString(@"Scan", nil) forState:UIControlStateHighlighted];
  self.scanButton.titleLabel.textColor = [UIColor whiteColor];
  self.scanButton.backgroundColor = [UIColor clearColor];
  [self.scanButton addTarget:self action:@selector(tapOnButton) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:self.scanButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tapOnButton {
  if (self.buttonState) {
    [self.scanButton setTitle:NSLocalizedString(@"Scan", nil) forState:UIControlStateNormal];
    [self.scanButton setTitle:NSLocalizedString(@"Scan", nil) forState:UIControlStateSelected];
    [self.scanButton setTitle:NSLocalizedString(@"Scan", nil) forState:UIControlStateHighlighted];
    
  } else {
    [self.scanButton setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateNormal];
    [self.scanButton setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateSelected];
    [self.scanButton setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateHighlighted];
    //need set a timer to tapOnButton with scanConstant
    [self pairing];
  }
  
  self.buttonState = !self.buttonState;
}

- (void)pairing
{
  // Scaning 4 seconds for peripherals
  [[LGCentralManager sharedInstance] scanForPeripheralsByInterval:4
                                                       completion:^(NSArray *peripherals)
   {
     [self updateStatus:@"Scanning..."];
//     [self.status setText:@"Scanning..."];
//     [self.status setNeedsDisplay];
     // If we found any peripherals sending to test
     if (peripherals.count) {
       for (LGPeripheral* peripheral in peripherals) {
         NSLog(@"name is %@", peripheral.name);
         //we should add a pair page that pairs with a Northstar device
         if ([peripheral.name isEqual:@"GogglePal"]) {
           [self updateStatus:@"Found!"];
//           [self.status setText:@"Found!"];

           [self pairWith:peripheral];
         }
       }
     }
   }];
}

- (void) pairWith:(LGPeripheral *)peripheral
{
  NSLog(@"Device UUID is %@", peripheral.UUIDString);
  [self updateStatus:@"Paired!"];

  [[NSUserDefaults standardUserDefaults] setValue:peripheral.UUIDString forKeyPath:@"UUID"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) updateStatus: ( NSString *)str
{
  [self.status performSelectorOnMainThread : @selector(setText:) withObject:str waitUntilDone:NO];
}

@end
