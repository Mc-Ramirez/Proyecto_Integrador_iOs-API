//  ViewControllerAddPlanet.swift
//  Proyecto_Integrador_iOs+API
//  Created by Felipe Ramírez on 11/2/22.

import UIKit

class ViewControllerAddPlanet: UIViewController {
    var decodePlanet : [Planetas] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func executeAPI(){
        let urlSession = URLSession.shared
        let url = URL(string: "https://iplanet-api.herokuapp.com/getallplanets")
        urlSession.dataTask(with: url!) {
            data, response, error in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data)
                print(String(describing: json)
            )}
            print("Error \(String(describing: error))")
        }.resume()
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        executeAPI()
    }
}
