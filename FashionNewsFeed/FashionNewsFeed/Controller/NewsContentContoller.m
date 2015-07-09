//
//  NewsContentContoller.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 31.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "NewsContentContoller.h"


#import <HTMLReader/HTMLReader.h>
#import <GTScrollNavigationBar.h>

#import "HeaderArticleView.h"
#import <DateTools/DateTools.h>



#import <VKSdk.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

static NSString *CellIdentifierContent = @"CellIdentifierContent";
static NSString *CellIdentifierHeader = @"CellIdentifierHeader";

static CGFloat kShareViewHeight = 152.0;

@interface NewsContentContoller ()

@property (strong,nonatomic) NSString* contentString;

@end

@implementation NewsContentContoller{
  ArticleView* _articleView;
  BOOL isFramesBuilt;
  
  HeaderArticleView* _headerView;

  
}



- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSLog(@"%@",_post.postContent);
  NSString* catdate;
  if(![self.post.getCategoriesString isEqualToString:@""]){
    
    catdate = [NSString stringWithFormat:@"%@  %@",self.post.getCategoriesString,
                         self.post.postDate.timeAgoSinceNow];
  } else {
    catdate = @"";
  }
  
  
  
  _headerView = [[HeaderArticleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)
                                            articleTitle:self.post.postTitle
                                            articleImage:self.postImage
                                       articleCategories:catdate];
  
  
  
  
  self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height + 50)];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.contentInset = UIEdgeInsetsMake(350, 0, 0, 0);
  self.tableView.contentOffset = CGPointMake(0, -300);
  
  self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
  self.tableView.showsVerticalScrollIndicator = false;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifierContent];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifierHeader];
  
  CGRect shareFrame = CGRectMake(0, 0, self.view.frame.size.width, kShareViewHeight);
  _shareView = [self configureShareView:shareFrame];
  _shareView.delegate = self;
  
  //[self.view addSubview:self.tableView];
  
  isFramesBuilt = false;
  self.title = @"";
  
  [self.navigationController.scrollNavigationBar resetToDefaultPositionWithAnimation:YES];
  // Do any additional setup after loading the view.
  NSLog(@"%f",self.view.frame.origin.y);
  NSLog(@"%f",self.view.frame.size.height);
  
  
  _articleView = [[ArticleView alloc] initWithFrame:CGRectMake(0,50,self.view.frame.size.width,FLT_MAX) htmlString:_post.postContent postTitle:_post.postTitle];
  _articleView.delegate = self;
  
}

-(ShareFbVkView*)configureShareView:(CGRect)frame{
  return [[ShareFbVkView alloc] initWithFrame:frame];
}

-(void)updateHeaderView{

  CGRect headerRect = CGRectMake(0, -300, self.view.frame.size.width, 300);
  if (self.tableView.contentOffset.y < -300){
    headerRect.origin.y = self.tableView.contentOffset.y;
    headerRect.size.height = -self.tableView.contentOffset.y;
  }
  _headerView.frame = headerRect;
}


-(void)viewWillDisappear:(BOOL)animated{
  [super viewWillDisappear:animated];
  [[FashionCollectionAPI sharedInstance] cancelAllOperations];
}

-(void)viewDidLayoutSubviews{
  if(!isFramesBuilt){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
      [_articleView buildFrames];
      self.navigationController.scrollNavigationBar.scrollView = self.tableView;
      isFramesBuilt = true;
      dispatch_sync(dispatch_get_main_queue(), ^{
        [self.tableView addSubview:_headerView];
        [self.tableView addSubview:_shareView];
        
        
        [self addTableViewUnder:self.tableView];
        
        [self updateHeaderView];
        
      });
      
      [_articleView downloadImages];
    });
    
  }
}

-(void)addTableViewUnder:(UITableView*)tableView{
  [self.view addSubview:tableView];
}

#pragma mark -
#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

  if(indexPath.row == 0){
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierContent];
    [cell addSubview:_articleView];
      return cell;
  }
  return nil;
}

  
  


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row == 0){
    CGSize size = [_articleView.textView sizeThatFits:CGSizeMake(self.view.frame.size.width, FLT_MAX)];
  
    _shareView.frame = [self frameForShareView:size];
    
   return size.height + 8 + kShareViewHeight;
   
  } else if (indexPath.row == 1){
    return kShareViewHeight;
  }
  return kShareViewHeight;
}

-(CGRect)frameForShareView:(CGSize)size{
  
  return CGRectMake(0, size.height + 8, size.width, kShareViewHeight);
  
}




- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
  [self.navigationController.scrollNavigationBar resetToDefaultPositionWithAnimation:NO];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  [self updateHeaderView];
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

 #pragma mark - Activity

- (IBAction)activityButtonTapped:(id)sender {
  
  NSString* title = self.post.postTitle;
  NSURL* url = self.post.postLink;
  UIImage* image = self.postImage;
  
  UIActivityViewController *activityViewController;
  
  if (image != nil) {
    activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[title,image,url] applicationActivities:@[[VKActivity new]]];
    
  } else {
    
    activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[title,url] applicationActivities:@[[VKActivity new]]];
  
    
  }
  
  activityViewController.excludedActivityTypes = @[UIActivityTypePrint,UIActivityTypeCopyToPasteboard,
                                                   UIActivityTypeAssignToContact,UIActivityTypeAirDrop];
  [self presentViewController:activityViewController
                     animated:YES
                   completion:^{
                     // ...
                   }];
  
  /*
   NSArray *items = @[[UIImage imageNamed:@"apple"], @"Check out information about VK SDK" , [NSURL URLWithString:@"https://vk.com/dev/ios_sdk"]]; //1
   UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
   initWithActivityItems:items
   applicationActivities:@[ [VKActivity new] ] ]; //2
   [activityViewController setValue:@"VK SDK" forKey:@"subject"]; //3
   [activityViewController setCompletionHandler:nil]; //4
   if (VK_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") && UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
   UIPopoverPresentationController *popover = activityViewController.popoverPresentationController;
   popover.sourceView = self.view;
   popover.sourceRect = [tableView rectForRowAtIndexPath:indexPath];
   } //5
   [self presentViewController:activityViewController animated:YES completion:nil]; //6
   */
  
  
  
  
}

-(void)shareVk:(ShareFbVkView *)delegate{
  
  NSString* text = [NSString stringWithFormat:@"%@\n\n%@",self.post.postTitle,self.post.postExcerpt];
  NSURL* url = self.post.postLink;
  UIImage* image = self.postImage;
  
  
  
  VKShareDialogController * shareDialog = [VKShareDialogController new]; //1
  shareDialog.text = text; //2
  
  //shareDialog.vkImages = @[@"-10889156_348122347",@"7840938_319411365",@"-60479154_333497085"]; //3
  shareDialog.uploadImages = @[[VKUploadImage uploadImageWithImage:image andParams:[VKImageParameters pngImage]]];
  shareDialog.shareLink = [[VKShareLink alloc] initWithTitle:self.post.postTitle link:url]; //4
  [shareDialog setCompletionHandler:^(VKShareDialogControllerResult result) {
    [self dismissViewControllerAnimated:YES completion:nil];
  }]; //5
  [self presentViewController:shareDialog animated:YES completion:nil]; //6
  
}

-(void)shareFb:(ShareFbVkView *)delegate{

  FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
  content.contentURL = self.post.postLink;
  content.contentTitle = self.post.postTitle;
  content.contentDescription = self.post.postExcerpt;
  content.imageURL = self.post.postFeaturedImage.imageSource;
  
  [FBSDKShareDialog showFromViewController:self
                               withContent:content
                                  delegate:nil];
  
}

-(void)goWeb:(ShareFbVkView *)delegate{
  NSURL* url = self.post.postLink;
  [[UIApplication sharedApplication] openURL:url];
}

#pragma ArticleViewDelegate

-(void)relayoutView:(id)delegate{
  NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
  
}


@end
