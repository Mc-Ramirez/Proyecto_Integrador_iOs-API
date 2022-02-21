//
//  ViewController_detailPlanet.swift
//  Proyecto_Integrador_iOs+API
//
//  Created by Sergio Rivera Anguita on 16/2/22.
//

import UIKit

class ViewController_detailPlanet: UIViewController {
    @IBOutlet weak var planetImg: UIImageView!
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetCathegory: UILabel!
    @IBOutlet weak var planetDensity: UILabel!
    @IBOutlet weak var planetMass: UILabel!
    @IBOutlet weak var planetDistance: UILabel!
    @IBOutlet weak var planetEquatorialRadius: UILabel!
    @IBOutlet weak var planetRotationPeriod: UILabel!
    var planetContent : Planetas?
    var idplaneta = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //planetImg.image = planetContent?.planetUrlImage
        planetName.text = planetContent?.planetName
        planetCathegory.text = planetContent?.category
        planetDensity.text = planetContent?.planetDensity
        planetMass.text = planetContent?.planetMassKg
        planetDistance.text = planetContent?.planetDistanceMio
        planetEquatorialRadius.text = planetContent?.planetEquatorialRadius
        planetRotationPeriod.text = planetContent?.planetRotationPeriod
        idplaneta = planetContent?.id ?? ""
        
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        // Preparamos los datos en formato json
        print("clicas aqui")
        let planetJson: [String:String] = [
            "id" : "\(planetContent?.id)"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: planetJson)
        let url = URL(string: "https://iplanet-api.herokuapp.com/deletebyid/\(idplaneta)")!
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
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
