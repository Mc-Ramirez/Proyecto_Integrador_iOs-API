//  ViewControllerAddPlanet.swift
//  Proyecto_Integrador_iOs+API
//  Created by Felipe Ramírez on 11/2/22.

import UIKit

class ViewControllerAddPlanet: UIViewController {
    
    @IBOutlet weak var TFName: UITextField!
    @IBOutlet weak var TFDensity: UITextField!
    @IBOutlet weak var TFMass: UITextField!
    @IBOutlet weak var TFDistance: UITextField!
    @IBOutlet weak var TFRadius: UITextField!
    @IBOutlet weak var TFRotation: UITextField!
    @IBOutlet weak var TFCategory: UITextField!
    @IBOutlet weak var ImagePlanet: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    @IBOutlet weak var lblMass: UITextField!
    @IBAction func btnAdd(_ sender: Any) {
        // Preparamos los datos en formato json
        print("clicas aqui")
        let planetJson: [String:String] = [
            "planetName": "\(TFName.text ?? "")",
            "planetDistanceMio": "\(TFDistance.text ?? "")",
            "planetEquatorialRadius": "\(TFRadius.text ?? "")",
            "planetRotationPeriod": "\(TFRotation.text ?? "")",
            "planetMassKg": "\(TFMass.text ?? "")",
            "planetDensity": "\(TFDensity.text ?? "")",
            "category": "\(TFCategory.text ?? "")",
            "planetUrlImage": "a"
            ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: planetJson)
        
        // Creamos la peticion post
        let url = URL(string: "https://iplanet-api.herokuapp.com/addplanet")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        // Insertamos los datos json en la peticion
        
        request.httpBody = jsonData
       
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No hay datos")
        return
        }
            print ("RESPUESTA: \(String(describing: response))")
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
        print(responseJSON)
        }
        }
        task.resume()
    }
}
