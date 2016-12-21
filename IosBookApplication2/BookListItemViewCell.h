//
//  BookListItemViewCell.h
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"


@interface BookListItemViewCell : UITableViewCell
@property(nonatomic,strong) BookModel *bookModel;
@end
