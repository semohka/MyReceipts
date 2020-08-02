//
//  StatisticTable.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 23.07.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit
import RealmSwift

class ProductTable: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate{
    
    


    var selectProduct = ""
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        statistic?.statisticTableField.text = selectProduct
        dismiss(animated: true, completion: nil)
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        //теперь всякий раз когда пользователь  будет взаимодействовать со строкой, UISearchController будет информировать об этом класс ProductTable, вызывая метод updateSearchResults, который в свою очередь будет вызывать метод filterContentForSearchText
    }
    
    private func filterContentForSearchText (_ searchText: String) {
        filteredProducts = products.filter({(product: Receipt) -> Bool in
            return(product.product?.lowercased().contains(searchText.lowercased()))!
            //содержит постеловательность символов независимо от регистра
        })
        tableView.reloadData()
    }
    

    
    weak var statistic: StatisticsViewController?
    var products: Results<Receipt>! //массив в котором соджержится тип чеков
    
    
    
    private var filteredProducts = [Receipt]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    } //не является ли строка поиска пустой, данное совйство будет возвращать труе если строка поиска будет пустой
    
    private var isFilterring: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        products = realm.objects(Receipt.self).distinct(by: ["product"])
        searchController.hidesNavigationBarDuringPresentation = false 
        searchController.searchBar.showsCancelButton = false
        searchController.searchResultsUpdater = self //получатель об изменении в поисковой стпроке должен быть наш класс
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Выберите продукт" //название для строки поиска
        navigationItem.searchController = searchController //отображение строки поиска в навигейшн бар
        definesPresentationContext = true //позволяет опустить скроку поиска на другой экран
        

        
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterring {
            return filteredProducts.count
        }
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var product: Receipt
        if isFilterring {
            product = filteredProducts[indexPath.row]
        }else{
            product = products[indexPath.row]
        }
        cell.textLabel?.text = product.product
          
        return cell
    }
    
    
    //отвечает за выбор и снятие выделения товара
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
            selectProduct = tableView.cellForRow(at: indexPath as IndexPath)!.textLabel!.text!
        }
    }
    
    
    
}
