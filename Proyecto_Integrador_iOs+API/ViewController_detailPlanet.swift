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
    }
}
