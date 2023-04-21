//
//  ViewController.m
//  EjemploObjC
//
//  Created by Javier Rodríguez Gómez on 26/3/23.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
// .m lleva la implementación de la interfaz
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // cómo llamar a un método:
    [self setupUI];
}

// Crear el método de setupUI
- (void) setupUI {
    [_tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell-id"];
    _tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell-id" forIndexPath:indexPath];
    cell.textLabel.text = @"Soy una celda";
    return cell;
}

@end
