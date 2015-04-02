//
//  smsHistoryFetch.h
//  linphone
//
//  Created by Ankit Khanna on 3/14/15.
//
//

#import <Foundation/Foundation.h>
#import "smsHistory.h"
#import <sqlite3.h>

@interface smsHistoryFetch : NSObject   {
    sqlite3 *_database;
    
}

+(smsHistoryFetch *)database;
-(NSArray *)getSMSHistory:(NSString *)phonenumber;        // Modified on 17 March to pass phone number
-(NSArray *)getSMSHistoryPhoneNumbers;
-(NSArray *)insertSMSHistory:(NSString *)username :(NSString *)phoneNumber :(NSString *)message;

@end
