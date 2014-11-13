//
//  ViewController.m
//  LBB_Test
//
//  Created by William Clark on 11/12/14.
//  Copyright (c) 2014 William Clark. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        // custom init //
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.connected = NO;
    
    // add connect button to nav bar //
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Connect" style:UIBarButtonItemStylePlain target:self action:@selector(connectBtnPressed:)];
    
    [self.batteryLabel setText:@"Not connected"];
    
    // view that will display color picker (must be square) //
    self.colorPicker = [[RSColorPickerView alloc] initWithFrame: self.colorPickerView.frame];
    
    // set delegate to receive events //
    [self.colorPicker setDelegate:self];
    
    // add as subview //
    [self.view addSubview:_colorPicker];
    
    // setup bean manager //
    self.beans = [NSMutableDictionary dictionary];
    // instantiating the bean starts a scan. make sure you have you delegates implemented
    // to receive bean info
    self.beanManager = [[PTDBeanManager alloc] initWithDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private functions

-(PTDBean*)beanAtIdx:(NSInteger)idx{
    return [self.beans.allValues objectAtIndex:idx];
}

#pragma mark - Action sheet
- (void)connectBtnPressed:(id)sender {
    // show action sheet //
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"Connect to..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    // add options from beans dictionary //
    NSArray *keys = [_beans allKeys];
    for(int i=0;i<[keys count];i++)
    {
        PTDBean* b = [_beans objectForKey:[keys objectAtIndex:i]];
        NSLog(@"Name: %@", b.name);
        [self.actionSheet addButtonWithTitle:b.name];
    }
    
    [self.actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Clicked button idx: %ld", (long)buttonIndex);
    
    if(buttonIndex == [actionSheet cancelButtonIndex]) {
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        return;
    }
    
    self.bean = [self.beans.allValues objectAtIndex:buttonIndex-1];
    if (_bean.state == BeanState_Discovered) {
        _bean.delegate = self;
        [self.beanManager connectToBean:_bean error:nil];
//        self.connectButton.enabled = NO;
    }
    else {
        _bean.delegate = self;
        [self.beanManager disconnectBean:_bean error:nil];
    }
}

#pragma mark - BeanManagerDelegate Callbacks
- (void)beanManagerDidUpdateState:(PTDBeanManager *)beanManager {
    // start scan if bluetooth is enabled, otherwise throw an error //
    if(self.beanManager.state == BeanManagerState_PoweredOn){
        [self.beanManager startScanningForBeans_error:nil];
    }
    else if (self.beanManager.state == BeanManagerState_PoweredOff) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Turn on bluetooth to continue" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    }
}

- (void)BeanManager:(PTDBeanManager*)beanManager didDiscoverBean:(PTDBean*)bean error:(NSError*)error{
    NSUUID * key = bean.identifier;
    if (![self.beans objectForKey:key]) {
        // New bean
        NSLog(@"BeanManager:didDiscoverBean:error %@", bean);
        [self.beans setObject:bean forKey:key];
    }
}
- (void)BeanManager:(PTDBeanManager*)beanManager didConnectToBean:(PTDBean*)bean error:(NSError*)error{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    } else {
        self.connected = YES;
        [self.navigationItem.rightBarButtonItem setTitle:@"Connected"];
        [bean readBatteryVoltage];
        // set one time timer (non-repeating) to update status text //
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(updateStatus:)
                                       userInfo:nil
                                        repeats:NO];
        // set timer to periodically update battery level //
        self.updateStatusTimer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                         target:self
                                       selector:@selector(updateStatus:)
                                       userInfo:nil
                                        repeats:YES];
    }
    
    [self.beanManager stopScanningForBeans_error:&error];
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    }
}

- (void)BeanManager:(PTDBeanManager*)beanManager didDisconnectBean:(PTDBean*)bean error:(NSError*)error{
    [self.navigationItem.rightBarButtonItem setTitle:@"Connect"];
    [self.batteryLabel setText:@"Not connected."];
    self.connected = NO;
    [self.updateStatusTimer invalidate];
}

#pragma mark - Update status info
- (void) updateStatus:(id) sender {
    // update battery level //
    [_bean readBatteryVoltage];
    NSInteger pct = ([_bean.batteryVoltage floatValue] / 3) * 100;
    NSString *batteryPct = [NSString stringWithFormat:@"Battery: %ld%%", (long)pct];
    [self.batteryLabel setText:batteryPct];
}

@end
