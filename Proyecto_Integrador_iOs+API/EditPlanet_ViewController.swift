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
    
    //Constrain
    @IBOutlet weak var urlTop: NSLayoutConstraint!
    @IBOutlet weak var urlPL: NSLayoutConstraint!
    @IBOutlet weak var namePL: NSLayoutConstraint!
    @IBOutlet weak var categoryPL: NSLayoutConstraint!
    @IBOutlet weak var densityPL: NSLayoutConstraint!
    @IBOutlet weak var massPL: NSLayoutConstraint!
    @IBOutlet weak var distancePL: NSLayoutConstraint!
    @IBOutlet weak var radiusPL: NSLayoutConstraint!
    @IBOutlet weak var rotationPL: NSLayoutConstraint!
    @IBOutlet weak var urlPR: NSLayoutConstraint!
    @IBOutlet weak var namePR: NSLayoutConstraint!
    @IBOutlet weak var categoryPR: NSLayoutConstraint!
    @IBOutlet weak var densityPR: NSLayoutConstraint!
    @IBOutlet weak var massPR: NSLayoutConstraint!
    @IBOutlet weak var distancePR: NSLayoutConstraint!
    @IBOutlet weak var radiusPR: NSLayoutConstraint!
    @IBOutlet weak var rotationPR: NSLayoutConstraint!
    @IBOutlet weak var massTop: NSLayoutConstraint!
    @IBOutlet weak var mass_wd: NSLayoutConstraint!
    @IBOutlet weak var url_wd: NSLayoutConstraint!
    @IBOutlet weak var name_wd: NSLayoutConstraint!
    @IBOutlet weak var category_wd: NSLayoutConstraint!
    @IBOutlet weak var density_wd: NSLayoutConstraint!
    @IBOutlet weak var distance_wd: NSLayoutConstraint!
    @IBOutlet weak var radius_wd: NSLayoutConstraint!
    @IBOutlet weak var rotation_wd: NSLayoutConstraint!
    
    //Autolayout
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientacion = UIDevice.current.orientation
        if (orientacion.isLandscape) {
            urlTop.constant = 3
            urlPL.constant = 50
            namePL.constant = 50
            categoryPL.constant = 50
            densityPL.constant = 50
            massPR.constant = 50
            distancePR.constant = 50
            radiusPR.constant = 50
            rotationPR.constant = 50
            url_wd.constant = 180
            name_wd.constant = 180
            category_wd.constant = 180
            density_wd.constant = 180
            mass_wd.constant = 180
            distance_wd.constant = 180
            radius_wd.constant = 180
            rotation_wd.constant = 180
            massTop.constant = -165
            urlPR.isActive = false
            namePR.isActive = false
            categoryPR.isActive = false
            densityPR.isActive = false
            massPL.isActive = false
            distancePL.isActive = false
            radiusPL.isActive = false
            rotationPL.isActive = false
        }else{
            urlTop.constant = 15
            urlPL.constant = 15
            namePL.constant = 15
            categoryPL.constant = 15
            densityPL.constant = 15
            url_wd.constant = 314
            name_wd.constant = 314
            category_wd.constant = 314
            density_wd.constant = 314
            urlPR.isActive = true
            namePR.isActive = true
            categoryPR.isActive = true
            densityPR.isActive = true
        }
    }
}
