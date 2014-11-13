//
//  AppDelegate.m
//  LBB_Test
//
//  Created by William Clark on 11/12/14.
//  Copyright (c) 2014 William Clark. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    
//    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//    [viewController setTitle:@"View"];
//    
    // create nav controller //
    
    /**
     // Create the PlainViewController (and give it a title)
     PlainViewController *plainView = [[PlainViewController alloc] initWithNibName:@"PlainViewController" bundle:nil];
     [plainView setTitle:@"PlainView"];
     
     // Create the NavRootView controller (and give it a title)
     NavRootView *navRoot = [[NavRootView alloc] initWithNibName:@"NavRootView" bundle:nil];
     [navRoot setTitle:@"NavRoot"];
     
     // Create our navigation controller using our NavRootView as it's root view
     UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:navRoot];
     
     // Make an array containing our plain view controller and our navigation controller
     NSArray *viewArray = [NSArray arrayWithObjects:plainView, navController, nil];
     
     // Release the views and nav controller
     [plainView release];
     [navRoot release];
     [navController release];
     
     // Create our tab bar controller
     UITabBarController *tabbarController = [[UITabBarController alloc] init];
     
     // Tell the tab bar controller to use our array of views
     [tabbarController setViewControllers:viewArray];
     
     // Finally, add the tabbar controller as a subview of the app window
     [window addSubview:[tabbarController view]];
     
     [self.window makeKeyAndVisible];
     
     //-----//
     // Initialize window view
     self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
     // Initialize tab bar controller, add tabs controllers
     self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [self initializeTabBarItems];
    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    return (YES);
     **/
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
