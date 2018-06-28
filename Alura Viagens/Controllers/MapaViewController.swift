//
//  MapaViewController.swift
//  Alura Viagens
//
//  Created by Ândriu Coelho on 27/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapa: MKMapView!
    
    // MARK: - Atributos
    
    var localizacao = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        localiza()
    }
    
    // MARK: - Métodos
    
    func localiza() {
        let conversor = CLGeocoder()
        conversor.geocodeAddressString(localizacao) { (localizacoes, erro) in
            guard let localizacao = localizacoes?.first else { return }
            
            let pino = MKPointAnnotation()
            pino.coordinate = localizacao.location!.coordinate
            pino.title = localizacao.name
            
            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 5000, 5000)
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}
