//  EditPlanet_ViewController.swift
//  Proyecto_Integrador_iOs+API
//  Created by Sergio Rivera Anguita on 22/2/22.

import UIKit

class EditPlanet_ViewController: UIViewController {
    @IBOutlet weak var planetUrlImage: UITextField!
    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var planetName: UITextField!
    @IBOutlet weak var planetCategory: UITextField!
    @IBOutlet weak var planetDensity: UITextField!
    @IBOutlet weak var planetMass: UITextField!
    @IBOutlet weak var planetDistance: UITextField!
    @IBOutlet weak var planetRadius: UITextField!
    @IBOutlet weak var planetRotation: UITextField!
    
    // var planetContent : Planetas?
    var idplaneta = ""
    var decodePlanet : Planetas?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url =  loadDataFromRemoteUrl()
        decodeJson(url: url)
        planetUrlImage.text = decodePlanet?.planetUrlImage
        planetName.text = decodePlanet?.planetName
        planetCategory.text = decodePlanet?.category
        planetDensity.text = decodePlanet?.planetDensity
        planetMass.text = decodePlanet?.planetMassKg
        planetDistance.text = decodePlanet?.planetDistanceMio
        planetRadius.text = decodePlanet?.planetEquatorialRadius
        planetRotation.text = decodePlanet?.planetRotationPeriod
        //planetImage = planetContent?.planetUrlImage
        idplaneta = decodePlanet?.id ?? ""
    }
    
    func loadDataFromRemoteUrl() -> URL{
        guard let url = URL(string: "https://iplanet-api.herokuapp.com/getplanetbyid/\(idplaneta)") else{ fatalError("ERROR")}
        print(url)
        return url
    }
    
    func decodeJson(url : URL){
        do{
            let decoder = JSONDecoder()
            let datosPlanetas = try Data(contentsOf: url)
            
            self.decodePlanet = try decoder.decode(Planetas.self, from: datosPlanetas)
        } catch {
            print("Error")
        }
    }
    
    @IBAction func btnSave(_ sender: Any) {
        print("clicas aqui")
        let planetJson: [String:String] = [
            "planetName": "\(planetName.text ?? "")",
            "planetDistanceMio": "\(planetDistance.text ?? "")",
            "planetEquatorialRadius": "\(planetRadius.text ?? "")",
            "planetRotationPeriod": "\(planetRotation.text ?? "")",
            "planetMassKg": "\(planetMass.text ?? "")",
            "planetDensity": "\(planetDensity.text ?? "")",
            "category": "\(planetCategory.text ?? "")",
            "planetUrlImage": "\(planetUrlImage.text ?? "")"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: planetJson)
        let url = URL(string: "https://iplanet-api.herokuapp.com/editplanet/\(idplaneta)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
