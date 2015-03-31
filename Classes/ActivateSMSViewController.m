//
//  ActivateSMSViewController.m
//  linphone
//
//  Created by ankit khanna on 3/4/15.
//
//

#import <AVFoundation/AVAudioSession.h>
#import <AudioToolbox/AudioToolbox.h>

#import "DialerViewController.h"
#import "IncallViewController.h"
#import "LinphoneManager.h"
#import "Utils.h"
#include "linphone/linphonecore.h"
# import "ChatViewController.h"
#import "ActivateSMSViewController.h"
#import "PhoneMainView.h"

@interface ActivateSMSViewController()
@property (nonatomic, retain) UIView *dummyView;

@end

@implementation ActivateSMSViewController

@synthesize addressField; // Added by ankit khanna

// Added by ankit khanna on 5 March for
- (UIView *)dummyView {
    if (!_dummyView) {
        _dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _dummyView;
}

static UICompositeViewDescription *compositeProcessSMSDescription = nil;

+ (UICompositeViewDescription *)compositeProcessSMSViewDescription {
    if(compositeProcessSMSDescription == nil) {
        compositeProcessSMSDescription = [[UICompositeViewDescription alloc] init:@"ProcessSMSViewController"
                                                                   content:@"ProcessSMSViewController"
                                                                  stateBar:nil
                                                           stateBarEnabled:false
                                                                    tabBar: @"UIMainBar"
                                                             tabBarEnabled:true
                                                                fullscreen:false
                                                             landscapeMode:[LinphoneManager runningOnIpad]
                                                              portraitMode:true];
        //    compositeSMSDescription.statusBarMargin = 0.0f;
        //   compositeSMSDescription.darkBackground = NO;
        // compositeSMSDescription.statusBarColor = [UIColor colorWithWhite:0.935f alpha:0.0f];
    }
    return compositeProcessSMSDescription;
}

// End of added by ankit khanna for Activate SMS scene

// End of added by ankit khanna


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Added by ankit khanna on 5 March 2015 for Activate SMS No button
- (void)dismiss {

        [[PhoneMainView instance] popCurrentView];

}
- (IBAction)cancelActivationSMS:(id)sender {
    
    NSLog(@"Cancel Activate SMS");
    [self dismiss];

}
// Added by Ankit khanna on 6 March 2015 to Generate alpha-numeric-random string
- (NSString *)genRandStringLength:(int)len {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    return randomString;
}

- (IBAction)acceptActivationSMS:(id)sender {
    NSLog(@"Accept Activate SMS");

    NSString *randomChar = [self genRandStringLength:4];
    
    // Added by ankit khanna on 7 March for fetching Phone number / User ID
    if ([randomChar length])   {
        [[NSUserDefaults standardUserDefaults] setObject:randomChar forKey:@"Random_Character"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    //// End

    NSLog(@"Random generated Activation key:%@",randomChar);
    
    // Below code is used to initiate Web API -- by ankit khanna on 6 March 2015
    NSString *str_mblNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"User_Mobile_Number"];
    NSString *str_usrPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"User_Password"];
    
    NSLog(@"User Mobile Number is:%@",str_mblNumber);
    NSLog(@"User Password is:%@",str_usrPassword);
    
//    NSString *urlForHttpGet = [NSString stringWithFormat:@"http://india.msg91.com/sendhttp.php?user=khannaankit&password=nanana&mobiles=+%@&message=Your verification code is '%@'.&sender=GOBZAR",str_mblNumber,randomChar];
//    
    NSString *urlForHttpGet = [NSString stringWithFormat:@"https://onecallcaspian.co.uk/mobile/sms?phone_number=%@&password=%@&from=onecall&text=Your verification code is <%@>.&receiver=%@",str_mblNumber,str_usrPassword,randomChar,str_mblNumber];
    
    NSString* urlTextEscaped = [urlForHttpGet stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // Send a synchronous request
   NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlTextEscaped]];
//    NSURLResponse * response = nil;
//    NSError * error = nil;
    
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:[[NSOperationQueue alloc] init]
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error)
     {
         
         if ([data length] >0 && error == nil)
         {
             
             // DO YOUR WORK HERE
                     NSString *str_Data = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                     NSLog(@"Response is : %@", str_Data);
                    NSLog(@"Web API ran successfully.");
             
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"Nothing happened.");
         }
         else if (error != nil){
             NSLog(@"Error = %@", error);
         }
         
     }];
    
//    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
//                                          returningResponse:&response
//                                                      error:&error];
//    if(data)
//    {
//        NSString *str_Data = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"Response is : %@", str_Data);
//    }  //Added by ankit khanna to remove warnings on 7 March 2015
//    
//    
//    if (error == nil)
//    {
//        // Parse data here
//        NSLog(@"Web API ran successfully.");
//    }
    
    // End of Web API code

    ChatViewController *controller = DYNAMIC_CAST([[PhoneMainView instance] changeCurrentView:[ChatViewController compositeProcessSMSViewDescription]
                                                                                         push:TRUE], ChatViewController);
    if (addressField.text.length != 0) {
        controller.addressField.text = addressField.text;
        [controller onAddClick:nil];
    }

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
