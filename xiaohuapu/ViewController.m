//
//  ViewController.m
//  xiaohuapu
//
//  Created by lulu on 14-1-2.
//  Copyright (c) 2014年 dianjoy. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "MJRefresh.h"
#import "MJRefreshFooterView.h"
#import "InfoCell.h"
#import "Reachability.h"

@interface ViewController ()<MJRefreshBaseViewDelegate>
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    BOOL                hasMore;
    BOOL                isLoading;
}


@end

@implementation ViewController
@synthesize dataArray;
@synthesize mytableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self isConnectionAvailable];
	// init ad controller
    _adController = [DianJoyAdController sharedDianJoyAdController];
    [_adController setAdDelegate:self];
    [_adController setAppId:@"2652099a792fbc3d59f887113a3bb3d2"];
    _adFinishLoad = NO;
    
//    UIImageView *tab = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    tab.image = [UIImage imageNamed:@"tab.png"];
//    UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(top)] autorelease];
//    [tab addGestureRecognizer:singleTap];
//    [self.view addSubview:tab];
    
    self.mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-55-6)];
    self.mytableView.dataSource = self;
    self.mytableView.delegate = self;
    [self.view addSubview:self.mytableView];
    self.mytableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:220/255.0 blue:201/255.0 alpha:1.0f];

    
    [self.mytableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    minTime = [[NSString alloc] init];
    maxTime = [[NSString alloc] init];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    page = [userDefaultes integerForKey:@"page"] + 1;
//    NSLog(@"page===%d",page);
    order = 1;

    self.dataArray = [NSMutableArray array];
    [self getData:page andOrder:1 andtime:minTime];
    
    hasMore = YES;
    isLoading = NO;
    // 3.3行集成下拉刷新控件
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.mytableView;
    _header.delegate = self;
    
    // 4.3行集成上拉加载更多控件
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.mytableView;
    // 进入上拉加载状态就会调用这个方法
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        if (!hasMore) {
            return ;
        }
        if(isLoading){
            return;
        }
        page++;
        order = 1;
        [self getData:page andOrder:order andtime:maxTime];
    };
}
- (void)getData:(int)p andOrder:(int)o andtime:(NSString *)so0
{
    NSString *url = [NSString stringWithFormat:@"http://z.turbopush.com/jokelist.php?p=%d&o=%d&so=%@",page,o,[so0 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:[NSNumber numberWithInteger:p] forKey:@"page"];
    [info setObject:[NSNumber numberWithInt:o] forKey:@"order"];
    [info setObject:so0 forKey:@"so"];
    [request setUserInfo:info];
    request.delegate = self;
    [request startAsynchronous];
}

- (void)reloadData:(NSArray *)result
{
    if (result.count == 0) {
        hasMore = NO;
    }
    [self.mytableView reloadData];
    [self reloadDeals];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    page++;
    order = 2;
    temp = 2;
    [self getData:page andOrder:order andtime:minTime];
}

- (void)reloadDeals
{
    // 结束刷新状态
    [_header endRefreshing];
    [_footer endRefreshing];
}

- (void)requestStarted:(ASIHTTPRequest *)request
{
    isLoading = YES;
}

- (void)requestFinished:(ASIHTTPRequest *)httprequest
{
    NSDictionary  *info = [httprequest userInfo];
    NSNumber  *page1 = [info objectForKey:@"page"];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:httprequest.responseData options:NSJSONReadingMutableContainers error:nil];
    if ([page1 intValue] == 0) {
        [self.dataArray removeAllObjects];
    }
    if ([page1 intValue] == 0) {
        [self.dataArray removeAllObjects];
    }
    if (temp == 2) {
        for (int i = 0;i<[[dic objectForKey:@"data"] count]; i++) {
            [self.dataArray insertObject:[[dic objectForKey:@"data"] objectAtIndex:i] atIndex:0];
        }
    }else{
        [self.dataArray addObjectsFromArray:[dic objectForKey:@"data"]];
    }
    [self reloadData:self.dataArray];
    isLoading = NO;
    NSLog(@"%d",page);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:page forKey:@"page"];
    
    minTime = [[self.dataArray objectAtIndex:0] objectForKey:@"date"];
    maxTime = [[self.dataArray objectAtIndex:[self.dataArray count]-1] objectForKey:@"date"];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    isLoading = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    static NSString *adCellID = @"adCell";
    NSDictionary  *info =  [self.dataArray objectAtIndex:indexPath.row];
    if (indexPath.row%10 == 6 && _adFinishLoad) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adCellID];
        if (cell == nil) {
            InfoCell  *infocell  = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adCellID];
            [infocell sethidden];
            cell = infocell;
        }
        [cell addSubview:[_adController getAdView]];
        return cell;
    } else {
        InfoCell *cell = [self.mytableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell setInfo:info];
        headimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 30, 30)];
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg",indexPath.row%50+1];
        [headimage setImage:[UIImage imageNamed:imageName]];
        [headimage setTag:10002];
        [cell addSubview:headimage];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%10 == 6 && _adFinishLoad)
    {
        return 214;
    }
    NSDictionary  *info =  [self.dataArray objectAtIndex:indexPath.row];
    return [InfoCell height:info];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mytableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (BOOL)shouldAutorotate
{
    return NO;
}

//#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    //return YES;
}

- (void)dealloc
{
    [self.mytableView release];
    [self.dataArray release];
    [super dealloc];
}

-(void)top
{
    [self.mytableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        UIAlertView *myalert = [[UIAlertView alloc]
                                initWithTitle:NSLocalizedString(@"Network error", @"Network error")
                                message:NSLocalizedString(@"Network isnt connected.Please check.", nil)
                                delegate:self
                                cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                otherButtonTitles:nil];
        
        [myalert show];
        
        [myalert release];
    }
    return isExistenceNetwork;
}

#pragma mark - DianJoyAdControllerDelegate callback
- (void)didFinishLoadAd:(DianJoyAdController *)adController
{
    _adFinishLoad = YES;
}
@end
