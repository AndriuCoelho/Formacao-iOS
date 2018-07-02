//
//  ViewController.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tabelaViagens: UITableView!
    @IBOutlet weak var viewHoteis: UIView!
    @IBOutlet weak var viewPacotes: UIView!
    
    // MARK: - Atributos
    
    var listaViagens:[Viagem] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraViews()
        getViagens()
    }
    
    // MARK: - Métodos
    
    func configuraViews() {
        viewPacotes.layer.cornerRadius = 10
        viewHoteis.layer.cornerRadius = 10
    }
    
    // MARK: - API
    
    func getViagens() {
        ViagemAPI().getViagens(completion: { (viagens) in
            self.listaViagens = viagens
            self.tabelaViagens.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaViagens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.tag = indexPath.row
        let viagemAtual = listaViagens[indexPath.row]
        cell.configuraCelula(viagemAtual)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(abrirMapa(_:)))
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 175 : 260
    }
    
    // MARK: - UILongPressGestureRecognizer
    
    @objc func abrirMapa(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let viagemSelecionada = listaViagens[(gesture.view?.tag)!]
            let mapaViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapa") as! MapaViewController
            mapaViewController.localizacao = viagemSelecionada.localizacao
            navigationController?.pushViewController(mapaViewController, animated: true)
        }
    }
}
