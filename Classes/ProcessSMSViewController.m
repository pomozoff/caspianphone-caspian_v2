//
//  ProcessSMSViewController.m
//  linphone
//
//  Created by ankit khanna on 3/5/15.
//
//

#import "ProcessSMSViewController.h"
#import "PhoneMainView.h"



@interface ProcessSMSViewController ()

@end

@implementation ProcessSMSViewController
@synthesize textActivateSMS;
// Added by ankit khanna on 8 March for comparing the text field user entered data with the random char sent to the user


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
// Added by ankit khanna on 5 March 2015 for Activate SMS No button
- (void)dismiss {
    
    [[PhoneMainView instance] popCurrentView];
    
}
- (IBAction)cancelSMSActivationProcess:(id)sender {
    NSLog(@"Cancelled SMS Activation Process");
    [[PhoneMainView instance] popCurrentView];

}
- (void)alertErrorMessage:(NSString *)message withTitle:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}
- (IBAction)confirmActivationSMS:(id)sender {

    NSString *str_randomNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"Random_Character"];

    NSLog(@"Random generated Activation key:%@",str_randomNumber);
    
    NSString *textActivateConfirm = textActivateSMS.text;
    NSLog(@"Text Activate Confirm:%@",textActivateConfirm);
    
    if ([textActivateConfirm isEqualToString:str_randomNumber])    {
        NSLog(@"Bingo You have successfully authenticated yourself");
        NSString *smsActiveState = @"1";
        [[NSUserDefaults standardUserDefaults] setObject:smsActiveState forKey:@"SMS_Active_State"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        smsCaspianVC *controller = DYNAMIC_CAST([[PhoneMainView instance] changeCurrentView:[smsCaspianVC compositeViewDescription]
                                                                                       push:TRUE], smsCaspianVC);
        if (controller) {
            NSLog(@"Changing to smsCaspianVC View Controller");
        }
    }
    else    {
        [self alertErrorMessage:NSLocalizedString(@"Please enter correct activation code.", nil)
                      withTitle:NSLocalizedString(@"Incorrect activation code", nil)];
//            [[PhoneMainView instance] popCurrentView];
    }
}
// Dismiss keyboard 
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)dealloc {
    [textActivateSMS release];
    [super dealloc];
}
@end
