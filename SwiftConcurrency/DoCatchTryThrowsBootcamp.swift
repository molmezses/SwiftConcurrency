//
//  DoCatchTryThrowsBootcamp.swift
//  SwiftConcurrency
//
//  Created by Mustafa Ölmezses on 14.02.2025.
//

import SwiftUI

/*
 
 Verilerin bize gelmesini ve kontrol etmemizi sağlayan DataManager bize getTitle Fonskiyonunda String bir değer dündürür fakar bu fonskiyon bir api ile çalıştıgımız zamanlarda String döndürmez ise burdaki hatayı kontrol edebilmemiz gerelit bunun için her zaman hatalı geldiği senaryo olan isActive fonkiyonu false yapılmıştır
 
 */
class DoCatchTryThrowsBootcampDataManager {
    
    var isActive: Bool = false
    
    
    //Throws fırlatmak anlamına gelir bu fonkiyonumuz işlevini yerine getiremez ise bize bir throw yani hata fırlatacaktır
    func getTitle() throws -> String{
        if isActive{
            return "NEW TEXT!"
        }else{
            
            //throw kullanarak hatamızı belirtiyoruz
            throw URLError(.badServerResponse)
        }
    }
    
}

class DoCatchTryThrowsBootcampViewModel: ObservableObject {
    
    @Published var text: String = "Starting text.."
    let manager = DoCatchTryThrowsBootcampDataManager()
    
    func fetchTitle(){
        
        //Throws kullanılan fonksiyonlarda do try catch yapısını kullanmak hata fırlatabilen fonskiyonların işletildiği takdirde hata varsa ne yapacağımızı yoksa işleme nasıl devam edeceğimizi belirtir
        
        do {
            let newText = try manager.getTitle()
            self.text = newText
        } catch {
            self.text = error.localizedDescription
        }
        
    }
    
}

struct DoCatchTryThrowsBootcamp: View {
    
    @StateObject private var viewModel = DoCatchTryThrowsBootcampViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .foregroundStyle(.white)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThrowsBootcamp()
}
