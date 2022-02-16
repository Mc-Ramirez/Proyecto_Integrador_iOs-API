//
//  ViewControllerAddPlanet.swift
//  Proyecto_Integrador_iOs+API
//
//  Created by Felipe Ramírez on 11/2/22.
//

import UIKit

class ViewControllerAddPlanet: UIViewController {
    
    var decodePlanet : [Planetas] = []
    
    @IBAction func btnAdd(_ sender: Any) {
        executeAPI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    
    func executeAPI(){
        let urlSession = URLSession.shared
        let url = URL(string: "https://iplanet-api.herokuapp.com/getallplanets")
        
        urlSession.dataTask(with: url!) {
            data, response, error in
           /* print("Data \(String(describing: data))")
            print("Response \(String(describing: response))")*/
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data)
                print(String(describing: json)
            )}
            print("Error \(String(describing: error))")
        }.resume()
        
        /*func decodeJson(url : URL){
            do{
                let decoder = JSONDecoder()
                let datosPlanetas = try Data(contentsOf: url)
                
                self.decodePlanet = try decoder.decode([Planetas].self, from: datosPlanetas)
            } catch {
                print("Error")
            }
        }*/
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
