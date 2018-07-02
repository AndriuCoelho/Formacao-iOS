//
//  PacotesViagensViewController.swift
//  Alura Viagens
//
//  Created by Alura on 25/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class PacotesViagensViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UISearchBarDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var colecaoPacotesViagens: UICollectionView!
    @IBOutlet weak var pesquisarViagens: UISearchBar!
    @IBOutlet weak var labelContadorPacotes: UILabel!
    
    // MARK: - Atributos
    
    let listaComTodasViagens: [PacoteViagem] = PacoteViagemDao().retornaTodasAsViagens()
    var listaViagens: [PacoteViagem] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pesquisarViagens.delegate = self
        listaViagens = listaComTodasViagens
        labelContadorPacotes.text = atualizaContadorLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        verificaPacotesFavoritos()
    }
    
    // MARK: - Métodos
    
    func atualizaContadorLabel() -> String {
        if listaViagens.count == 1 {
            return "1 pacote encontrado"
        }
        else {
            return "\(listaViagens.count) pacotes encontrados"
        }
    }
    
    func verificaPacotesFavoritos() {
        let favoritos = PacoteViagemDao().carrega()
        favoritos.forEach({ filtraPacoteFavorito(Int($0.id)) })
        colecaoPacotesViagens.reloadData()
    }
    
    func filtraPacoteFavorito(_ id: Int) {
        let pacoteFavorito = listaViagens.filter({ $0.viagem.id == id })
        pacoteFavorito.first?.favoritado = true
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listaViagens = listaComTodasViagens
        if searchText != "" {
            listaViagens = listaViagens.filter({ $0.viagem.titulo.contains(searchText) })
        }
        labelContadorPacotes.text = atualizaContadorLabel()
        colecaoPacotesViagens.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaViagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaPacote = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacotesCollectionViewCell
        celulaPacote.botaoFavoritar?.tag = indexPath.item
        let pacoteAtual = listaViagens[indexPath.item]
        celulaPacote.configuraCelula(pacoteAtual)
        
        return celulaPacote
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pacote = listaViagens[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesViagemViewController
        controller.pacoteSelecionado = pacote
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2-20, height: 160) : CGSize(width: collectionView.bounds.width/3-20, height: 250)
    }
    
    // MARK: - IBActions
    
    @IBAction func botaoFavoritar(_ sender: UIButton) {
        let pacote = listaViagens[sender.tag]
        pacote.favoritado = !pacote.favoritado
        colecaoPacotesViagens.reloadData()
        PacoteViagemDao().alteraFavorito(pacote)
    }
}
