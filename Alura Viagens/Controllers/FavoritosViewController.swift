//
//  FavoritosViewController.swift
//  Alura Viagens
//
//  Created by Ândriu Coelho on 26/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class FavoritosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var colecaoPacotesViagens: UICollectionView!
    
    // MARK: - Atributos
    
    var listaViagens: [PacoteViagem] = []
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        carregaPacotesFavoritos()
    }
    
    // MARK: - Métodos
    
    func carregaPacotesFavoritos() {
        let pacotes = PacoteViagemDao().carrega()
        listaViagens = PacoteViagem.serializaPacoteViagem(pacotes)
        colecaoPacotesViagens.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaViagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaPacote = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacotesCollectionViewCell
        let pacoteAtual = listaViagens[indexPath.item]
        celulaPacote.configuraCelula(pacoteAtual)
        
        return celulaPacote
    }
    
    // MARK: - UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2-20, height: 160) : CGSize(width: collectionView.bounds.width/3-20, height: 250)
    }
}
