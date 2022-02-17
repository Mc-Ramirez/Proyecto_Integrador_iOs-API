//  ViewModel.swift
//  Proyecto_Integrador_iOs+API
//  Created by Sergio Rivera Anguita on 16/2/22.

import Foundation

final class ViewModel {
    func executeAPI(){
        let urlSession = URLSession.shared
        let url = URL(string: "https://iplanet-api.herokuapp.com/getallplanets")
        
        urlSession.dataTask(with: url!) {
            data, response, error in
            print("Data \(String(describing: data))")
            print("Response \(String(describing: data))")
            print("Error \(String(describing: data))")
        }.resume()
    }
}
