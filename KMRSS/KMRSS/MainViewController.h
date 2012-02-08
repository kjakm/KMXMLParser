//
//  MainViewController.h
//  KMRSS
//
//  Created by Kieran McGrady on 13/01/2012.
//

#import <UIKit/UIKit.h>
#import "KMXMLParser.h"

@interface MainViewController : UITableViewController <KMXMLParserDelegate>

@property (strong, nonatomic) NSArray *dataArray;

@end
