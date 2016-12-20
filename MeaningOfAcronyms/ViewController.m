//
//  ViewController.m
//  MeaningOfAcronyms
//
//  Created by spandana nayakanti on 12/18/16.
//  Copyright © 2016 spandana. All rights reserved.
//

#import "ViewController.h"
#import <AFHTTPSessionManager.h>
#import <MBProgressHUD.h>


@interface ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *hud;
    IBOutlet UITableView *TVForAcronym;
    NSMutableArray *arrayForTableViewData;
}

@end

@implementation ViewController

#pragma mark View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txtFldForSearchWord.delegate=self;
    
    arrayForTableViewData=[[NSMutableArray alloc]init];
 
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark Response From Server

- (IBAction)ActnForSearchWordForAcronym:(UIButton *)sender {
    
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"Loading";
    hud.label.font=[UIFont fontWithName:@"Verdana" size:12.0f];
    
    [hud showAnimated:YES];
    
    NSDictionary *dictParameters = @{@"sf":self.txtFldForSearchWord.text,@"lf": @""};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:@"http://www.nactem.ac.uk/software/acromine/dictionary.py" parameters:dictParameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self.txtFldForSearchWord.text=@"";
        [hud hideAnimated:YES];
        
        NSError *error = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        
        if (error != nil) {
            NSLog(@"Error parsing JSON.");
        }
        else {
            if (arrayForTableViewData.count>0) {
                
            
            
            [arrayForTableViewData addObjectsFromArray:[[[jsonArray objectAtIndex:0] valueForKey:@"lfs"] mutableCopy]];
            [TVForAcronym reloadData];
            }
            
            else{
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Info"
                                              message:@"No acronym avilable for given search"
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         NSLog(@"Resolving UIAlert Action for tapping OK Button");
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                UIAlertAction* cancel = [UIAlertAction
                                         actionWithTitle:@"Cancel"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             
                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                             
                                         }];
                
                [alert addAction:ok];
                [alert addAction:cancel];
                
               
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        [hud hideAnimated:YES];

        NSLog(@"Error: %@", error);
    }];

    
    
}
#pragma mark - UITableView Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayForTableViewData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"meaningcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[[arrayForTableViewData objectAtIndex:indexPath.row] valueForKey:@"lf"];
    
    return cell;
}

#pragma mark -Hiding KeyBoard

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}
#pragma mark - UITextField Delegate Method For Hiding KeyBoard

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
  
    return YES;
    
}

#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
