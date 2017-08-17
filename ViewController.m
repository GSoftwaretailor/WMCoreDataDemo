//
//  ViewController.m
//  CoreDataDemo
//
//  Created by kuyuZJ on 2017/8/2.
//
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "MStudent.h"
#import "AddStudent.h"
#import "EditStudent.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView* tableView;

@property(nonatomic,strong) NSArray* arrayData;

@end

@implementation ViewController{
    NSString* cellIdentifier;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    cellIdentifier =  @"cellIdentifier";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    NSArray<NSString*>* formats = @[@"H:|-defEdge-[tableView]-defEdge-|", @"V:|-defEdge-[tableView]-defEdge-|"];
    NSDictionary<NSString*,id>* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10)};
    NSDictionary<NSString*,id>* views = @{ @"tableView":self.tableView};
    [formats enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<NSLayoutConstraint*>* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self queryData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle: @"增加" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarTouch:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)queryData{
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    NSEntityDescription* entity = [NSEntityDescription entityForName: @"Student" inManagedObjectContext:[CoreDataManager shareManager].context];
    [request setEntity:entity];
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"userName LIKE %@",@"A*"];
    [request setPredicate:predicate];
    
    NSError* error = nil;
    NSArray* result = [[CoreDataManager shareManager].context executeFetchRequest:request error:&error];
    if(result){
        [result enumerateObjectsUsingBlock:^(MStudent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog( @"%@ %@ %@",obj.userName,obj.age,obj.sex);
        }];
    }
    self.arrayData = result;
    [self.tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = ((MStudent*)self.arrayData[indexPath.row]).userName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditStudent* controller = [[EditStudent alloc]initWithItem:self.arrayData[indexPath.row]];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [[CoreDataManager shareManager].context deleteObject:self.arrayData[indexPath.row]];
        NSError* error;
        if([[CoreDataManager shareManager].context save:&error]){
            [self queryData];
        }
    }
}


-(IBAction)rightBarTouch:(id)sender{
    AddStudent* controller = [[AddStudent alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}


-(UITableView *)tableView{
    if(!_tableView){
        UITableView* empty = [[UITableView alloc]init];
        empty.delegate = self;
        empty.dataSource = self;
        [empty registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        empty.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView = empty;
    }
    return _tableView;
}


@end
