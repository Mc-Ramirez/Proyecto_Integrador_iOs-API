//  TableViewController_PlanetList.swift
//  Proyecto_Integrador_iOs+API
//  Created by Sergio Rivera Anguita on 16/2/22.

import UIKit

class TableViewController_PlanetList: UITableViewController {
    @IBOutlet weak var titulo: UINavigationItem!
    @IBOutlet var miTabla: UITableView!
    var decodePlanet : [Planetas] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url =  loadDataFromRemoteUrl()
        decodeJson(url: url)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let url =  loadDataFromRemoteUrl()
        decodeJson(url: url)
    }
    
    func loadDataFromRemoteUrl() -> URL{
        guard let url = URL(string: "https://iplanet-api.herokuapp.com/getallplanets") else{ fatalError("ERROR")}
        return url
    }
    
    func decodeJson(url : URL){
        do{
            let decoder = JSONDecoder()
            let datosPlanetas = try Data(contentsOf: url)
            
            self.decodePlanet = try decoder.decode([Planetas].self, from: datosPlanetas)
        } catch {
            print("Error")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decodePlanet.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configurar la celda
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = decodePlanet[indexPath.row].planetName
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irDetalle"{
            guard let celdaSeleccionada = miTabla.indexPathForSelectedRow?.row else {return}
            let planetaSeleccionado = decodePlanet[celdaSeleccionada]
            let vistaDetalle = segue.destination as! ViewController_detailPlanet
            vistaDetalle.planetContent = planetaSeleccionado
        }
    }
    
    //Pestaña editar personalizada
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let opBorrar = UIContextualAction(style: .normal, title: "Borrar") { _,_,_ in
            if indexPath.section == 0{
                
            }else{
                
            }
            self.miTabla.deleteRows(at: [indexPath], with: .fade)
        }
        
        opBorrar.image = UIImage(systemName: "trash")
        opBorrar.backgroundColor = UIColor.red
        
        let opEditar = UIContextualAction(style: .normal, title: "Editar") { _,_,_ in
            print("Has pulsado editar")
        }
        
        opEditar.backgroundColor = UIColor.blue
        opEditar.image = UIImage(systemName: "pencil")
        
        let configurarBotones = UISwipeActionsConfiguration(actions: [opBorrar, opEditar])
        return configurarBotones
    }
}
