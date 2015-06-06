//
//  SideBarMenuTableViewContoller.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 31.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "SideBarMenuTableViewContoller.h"
#import "FashionCollectionAPI.h"
#import "FCTableViewCell1.h"
#import "MenuTableViewCell.h"

@interface SideBarMenuTableViewContoller ()

@end

@implementation SideBarMenuTableViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //UIImageView* imageView = [[UIImageView alloc] initWithImage:
     //[UIImage imageNamed:@"menubg.png"]];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"menubg2.png"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    
    
    
    
    self.tableView.backgroundView = imageView;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden{
  return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //TODO
    // Return the number of rows in the section.
    return [[[FashionCollectionAPI sharedInstance] getHardCodedCategories] count] + 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        return 200;
    } else {
        return 36;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"menuCellHeader"];
        //cell.textLabel.text = @"Header";
        return cell;
        
    } else {
    
        MenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
        //TODO
        
        if (indexPath.row == 5) {
            
            cell.menuTitle.text = @"Информация";
            cell.menuTitle.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
            
        } else {
            cell.menuTitle.text = [[[[FashionCollectionAPI sharedInstance] getHardCodedCategories] objectAtIndex:indexPath.row - 1] categoryName];
        }
        
        return cell;
    
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    if (indexPath.row == 5) {
        //[self performSegueWithIdentifier:@"showInfo" sender:self];
        [self performSegueWithIdentifier:@"forteInfo" sender:self];
        
    }
    
    
    if([self.revealViewController.frontViewController isKindOfClass:[MainViewController class]]){
        MainViewController* mvc = (MainViewController*)self.revealViewController.frontViewController;
        if(indexPath.row - 1 < [[mvc pageTitles] count]){
        [mvc showPageAtIndex:indexPath.row - 1];
        }
    }
    
    
    
    
    [self.revealViewController revealToggleAnimated:YES];
    
    
}







/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
