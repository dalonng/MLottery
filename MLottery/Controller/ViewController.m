//
//  ViewController.m
//  MLottery
//
//  Created by Jack on 4/13/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import "ViewController.h"
#import <CCHexagonFlowLayout/CCHexagonFlowLayout.h>
#import "ViewModel.h"
#import "LotteryCollectionVeiwCell.h"
#import "ModalViewController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, CCHexagonDelegateFlowLayout,
UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView* collectionView;
@property (nonatomic, strong) NSIndexPath* currentIndexPath;
@property (nonatomic, strong) NSArray* indexPaths;
@property (nonatomic, assign) BOOL runable;
@property (nonatomic, strong) ViewModel* viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CCHexagonFlowLayout *layout = [[CCHexagonFlowLayout alloc] init];
    layout.delegate = self;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = -10.0f;
    layout.minimumLineSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    layout.itemSize = CGSizeMake(80, 80);
    layout.gap = 46.0f;
    
    _collectionView.collectionViewLayout = layout;
    [_collectionView reloadData];
    
    NSMutableArray* a = [NSMutableArray array];
    for (NSUInteger i = 0; i < 10; i ++) {
        [a addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    _indexPaths = [a copy];
    _currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    _viewModel = [ViewModel new];
    _runable = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (_runable) {
        [self removeCurrentAnimation];
        [self nextIndexPath];
        [self doAnimation];
    }
}

- (void)didDissmissModalViewController {
    [_viewModel deleteUserWithName:[_viewModel nameWithIndexPath:_currentIndexPath]
                        completion:^(BOOL success) {
//                            NSLog(@"delete : %@", [_viewModel nameWithIndexPath:_currentIndexPath]);
                            [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (NSString *)luckyDog {
    return [_viewModel nameWithIndexPath:_currentIndexPath];
}

- (void)doAnimation {
    NSLog(@"indexPath : %@", _currentIndexPath);
    LotteryCollectionVeiwCell* cell = (LotteryCollectionVeiwCell*)[_collectionView cellForItemAtIndexPath:_currentIndexPath];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setFromValue:[NSNumber numberWithFloat:1.0]];
    [animation setToValue:[NSNumber numberWithFloat:0.0]];
    [animation setDuration:0.07];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    animation.delegate = self;
    [animation setAutoreverses:NO];
    [animation setRepeatCount:1];
    [cell.imageView.layer addAnimation:animation forKey:@"opacity"];
}

- (void)removeCurrentAnimation {
    LotteryCollectionVeiwCell* cell = (LotteryCollectionVeiwCell*)[_collectionView cellForItemAtIndexPath:_currentIndexPath];
    [cell.imageView.layer removeAnimationForKey:@"opacity"];
}

- (void)nextIndexPath {
    NSUInteger item = (_currentIndexPath.item + 1) % _viewModel.numberOfUsers;
    NSIndexPath* next = [NSIndexPath indexPathForItem:item inSection:0];
    _currentIndexPath = next;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_viewModel numberOfUsers];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LotteryCollectionVeiwCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LotteryCollectionVeiwCell"
                                                                                forIndexPath:indexPath];
    cell.titleLabel.text = [_viewModel nameWithIndexPath:indexPath];
    return cell;
}

- (IBAction)handleLotteryEvent:(UIButton *)sender {
    _runable = !_runable;
    [sender setTitle: (_runable?@"结束":@"开始") forState:UIControlStateNormal];
    if (_runable == NO) {
        [self present:nil];
    } else {
        [self doAnimation];
    }
}

- (void)present:(id)sender {
    ModalViewController *modalViewController = [ModalViewController new];
    modalViewController.transitioningDelegate = self;
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    modalViewController.viewController = self;
    [self presentViewController:modalViewController animated:YES completion:NULL];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}

@end
