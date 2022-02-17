//  CollectionViewControllerListPlanets.swift
//  Proyecto_Integrador_iOs+API
//  Created by Felipe Ramírez on 16/2/22.

import UIKit

class CollectionViewControllerListPlanets: UICollectionViewController {
    @IBOutlet var miTabla: UICollectionView!
    let dataSource : [String] = ["usa", "brasil","china", "japon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
