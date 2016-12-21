//
//  BookListItemViewCell.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "BookListItemViewCell.h"



@interface BookListItemViewCell ()
@property (weak, nonatomic) IBOutlet UIView *cellPrentView;
@property (weak, nonatomic) IBOutlet UILabel *desUILabel;

@property (weak, nonatomic) IBOutlet UILabel *titleUILabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@end

@implementation BookListItemViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    _cellPrentView.layer.cornerRadius = 8;
    
    _cellPrentView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    
    _cellPrentView.layer.borderWidth = 0.5;
    
    _cellPrentView.layer.borderColor = [[UIColor colorWithRed:0xed green:0xed blue:0xed alpha:1] CGColor];

}

-(void)setBookModel:(BookModel *)bookModel{
    _bookModel = bookModel;
    if (bookModel!=nil) {
        NSString *name = bookModel.name;
        NSString *descrpon = bookModel.descriptions;
        
        self.titleUILabel.text = name;
        self.desUILabel.text = descrpon;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
