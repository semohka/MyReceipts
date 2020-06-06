//
//  SettingsView.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 01.06.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State var tapCount = false
    @State var balance = false
    @State var amountMoney = ""
//    @State var save = ""
    var body: some View {
        VStack{
            NavigationView {
                Form {
                    Toggle(isOn: $tapCount) {
                        Text("Темная тема")
                        
                    }
                    Toggle(isOn: $balance) {
                        Text("Оповещать об остатке")
                        
                    }
                    
                    Section {
                        HStack {
                            TextField ("Введите сумму", text: $amountMoney)
                            Button(action: {
                                UserDefaults.standard.set(self.amountMoney, forKey: "Tap")
                                self.hideKeyboard()
                            })
                            {
                            Text("ОК")
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Настройки"), displayMode: .inline)
            }
           
        }

    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
}
}
