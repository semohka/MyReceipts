//
//  MainViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 25.03.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    let myReceipts = [
    "ВкусВилл","Дикси","Пятерочка","Лента","Карусель","Ларек"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // вернет количество строк в зависимости от количества наших чеков
        
        return myReceipts.count
    }
    
    let receipts = [Receipt(shop: "ВкусВилл", price: "2000руб.", image: "ВкусВилл")
    ]
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        // конфигурация ячейки. Является обязательным иначе программа упадет
        
        cell.shopLabel.text = myReceipts[indexPath.row]
        cell.imageOfStore.image = UIImage(named: myReceipts[indexPath.row])
        cell.imageOfStore.layer.cornerRadius = cell.imageOfStore.frame.size.height / 2
        cell.imageOfStore.clipsToBounds = true
        
        return cell
    }
    // MARK: - Table view delegate
    //данный метод возвращает конкретную высоту строки
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
