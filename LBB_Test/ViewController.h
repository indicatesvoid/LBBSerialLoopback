//
//  ViewController.h
//  LBB_Test
//
//  Created by William Clark on 11/12/14.
//  Copyright (c) 2014 William Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PTDBeanManager.h>

@interface ViewController : UIViewController <UIActionSheetDelegate, PTDBeanManagerDelegate, PTDBeanDelegate> {
    
}

- (IBAction)sendMsgPressed:(id)sender;

@property (nonatomic, strong) PTDBean *bean;
@property (nonatomic, strong) PTDBeanManager *beanManager;
// all the beans returned from a scan
@property (nonatomic, strong) NSMutableDictionary *beans;

@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;

@property (strong, nonatomic) UIActionSheet *actionSheet;
@property Boolean connected;
@property (strong, nonatomic) NSTimer* updateStatusTimer;
@end

