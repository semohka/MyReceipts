//
//  AddShopTableViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 05.09.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class AddShopTableViewController: UITableViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imageShop: UIImageView!
    @IBOutlet weak var nameShop: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView() //убирает разлиновку до конца страницы

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            //вызов алерта при нажатии на ячейку с фото
            let camera = UIAlertAction(title: "Камера", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            let photo = UIAlertAction(title: "Фото", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            
            present(actionSheet, animated: true)//как любой вью контроллер , нужно вызвать наш контроллер actionSheet
        } else {
            view.endEditing(true) //если тапнуть за пределами нулевой ячейуи то клавиатура должна скрываться
        }
        
    }
    
}

extension AddShopTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        //скрывает клавиатуру по нажатию на ВВОД
    }
}

extension AddShopTableViewController: UIImagePickerControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()//при вызове метода чусИмаджПикер в качестве параметра этого метода мы должны определить источник выбора изображения, если данный источник будет доступен. тогда уже создаем экземпляр класса юайИмаджПикерКонтроллер и далее работает с экземпляром этого класса
            imagePicker.delegate = self //этот объект будет делегировать обязанности по выполнению данного метода. Нужно определить объект который будет выполнять данный метод (т.е.назначить делегата) , это будет селф, то есть наш класс
            imagePicker.allowsEditing = true //это позволит пользователю РЕДАКТИРОВАТЬ выбранное изображение, например отмасштабировать перед тем, как применить к конкретному магазину
            imagePicker.sourceType = source//определяем тип источника выбранного изображения. То есть мы присваиваем значение параметра соурс свойству соурсТайп
            present(imagePicker, animated: true)//наше свойство имаджПикер по сути является вьюконтроллером и как любой другой вьюконтроллер, для того чтобы ототбразить его на экране нам необходимо вызвать метод презент. Данный метод реализован. Теперь его надо вызвать
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //мы должны взять значение по ключу словаря инфо. Ключами данного словаря являются свойцства того самой структуры юайИмаджПикерКонтроллер.ИнфоКей описание которой написано в документации.Свойство данной структуры отпределяют тип контента и значения этих свойств будем присваивать нашему аутлету имаджШоп
        imageShop.image = info[.editedImage] as? UIImage//обращаемся к параметру инфо и берем значение  по ключу эдитедИмадж и надо привести это значение к юайИмедж. Данный тип контента позволяет ИСПОЛЬЗОВАТЬ ОТРЕДАКТИРОВАННОЕ пользователем изображение
        imageShop.contentMode = .scaleAspectFill//позволяет масштабировать изображение по содержимому юайИмадж
        imageShop.clipsToBounds = true//обрезать изображение по границам самого юайИмедж
        dismiss(animated: true)//определившись с изображением нам необходимо закрыть имаджКонтроллер
    }
}
