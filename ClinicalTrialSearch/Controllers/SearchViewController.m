//
//  SearchViewController.m
//  ClinicalTrialSearch
//
//  Created by matt rooney on 25/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import "SearchViewController.h"
#import "HTTPSearchDiseases.h"
#import "Disease.h"
#import "DiseaseDetailViewController.h"
#import "MedicalTrial.h"
#import "MedicalTrialDetailViewController.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL inDiseaseSearch;
@property (strong, nonatomic) NSTimer *searchTimer;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _searchBar.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(diseasesReceieved:) name:@"diseasesReceived" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trialsReceieved:) name:@"trialsReceived" object:nil];
    
    UIImage *clinicalTrialImage = [[UIImage imageNamed:@"clinical_trial_small.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *diseaseImage = [[UIImage imageNamed:@"disease_small.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableArray *buttonsArray = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *diseaseButton = [[UIBarButtonItem alloc] initWithImage:diseaseImage style:UIBarButtonItemStylePlain target:self action:@selector(switchToDiseaseLookUp)];
    [buttonsArray addObject:diseaseButton];
    
    UIBarButtonItem *clinicalTrialButton = [[UIBarButtonItem alloc] initWithImage:clinicalTrialImage style:UIBarButtonItemStylePlain target:self action:@selector(switchToTrialLookUp)];
    [buttonsArray addObject:clinicalTrialButton];
    
    [_toolBar setItems:buttonsArray];
    _inDiseaseSearch = YES;
    
    _spinner.hidden = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    if(_inDiseaseSearch){
        Disease *disease = [Disease new];
        disease = [_diseases objectAtIndex:indexPath.row];
        cell.textLabel.text = disease.name;
    } else {
        MedicalTrial *trial = [MedicalTrial new];
        trial = [_trials objectAtIndex:indexPath.row];
        cell.textLabel.text = trial.name;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _inDiseaseSearch ? [_diseases count] - 1 : [_trials count] - 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewToPresent;
    if(_inDiseaseSearch){
        DiseaseDetailViewController *ddvc = [DiseaseDetailViewController new];
        Disease *disease = [_diseases objectAtIndex:indexPath.row];
        ddvc.title = disease.name;
        ddvc.disease = disease;
        viewToPresent = ddvc;
    } else {
        MedicalTrialDetailViewController *mtvc = [MedicalTrialDetailViewController new];
        MedicalTrial *trial = [_trials objectAtIndex:indexPath.row];
        mtvc.title = trial.name;
        mtvc.trial = trial;
        viewToPresent = mtvc;
    }
    [self.navigationController pushViewController:viewToPresent animated:YES];
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        [_spinner stopAnimating];
        _spinner.hidden = YES;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0){
        [self clearSearchBarAndTable];
        return;
    }
    if(searchText.length<3){
        return;
    }
    
    [_spinner startAnimating];
    _spinner.hidden = NO;
    
    if (_searchTimer) {
        if ([_searchTimer isValid])
        {
            [_searchTimer invalidate];
        }
        _searchTimer = nil;
    }
    
    if(_inDiseaseSearch){
        _searchTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(searchDisease:) userInfo:searchText repeats:NO];
    } else {
       _searchTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(searchMedicalTrial:) userInfo:searchText repeats:NO];
    }
}

-(void)searchDisease:(NSTimer *)timer
{
    [HTTPSearchDiseases searchForDisease:timer.userInfo];
}

-(void)searchMedicalTrial:(NSTimer *)timer
{
    [HTTPSearchDiseases searchMedicalTrial:timer.userInfo];
}

-(void)diseasesReceieved:(NSNotification *)notification
{
    if(_inDiseaseSearch){
        dispatch_async (dispatch_get_main_queue(), ^{

            NSMutableDictionary *dict = notification.object;
            _diseases = [dict objectForKey:@"diseases"];
            [_tableView reloadData];
        });
    }
}

-(void)trialsReceieved:(NSNotification *)notification
{
    if(!_inDiseaseSearch){
        dispatch_async (dispatch_get_main_queue(), ^{
            
            NSMutableDictionary *dict = notification.object;
            _trials = [dict objectForKey:@"trials"];
            [_tableView reloadData];
        });
    }
}

-(void)switchToTrialLookUp{
    if(!_inDiseaseSearch)
        return;
    
    _inDiseaseSearch = NO;
    self.title = @"Medical Trial Lookup";
    [self clearSearchBarAndTable];
}

-(void)switchToDiseaseLookUp{
    if(_inDiseaseSearch)
        return;
    
    _inDiseaseSearch = YES;
    self.title = @"Disease Lookup";
    [self clearSearchBarAndTable];
}

-(void)clearSearchBarAndTable
{
    [_trials removeAllObjects];
    [_diseases removeAllObjects];
    _searchBar.text = @"";
    [self.tableView reloadData];
}

@end
