//
//  PacotesCollectionViewCell.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class PacotesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imagemViagem: UIImageView!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelQuantidadeDias: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var botaoFavoritar: UIButton?
    
    // MARK: - Métodos
    
    func configuraCelula(_ pacoteViagem: PacoteViagem) {
        labelTitulo.text = pacoteViagem.viagem.titulo
        labelQuantidadeDias.text = "\(pacoteViagem.viagem.quantidadeDeDias) dias"
        labelPreco.text = "R$ \(pacoteViagem.viagem.preco)"
        imagemViagem.image = UIImage(named: pacoteViagem.viagem.caminhoDaImagem)
        
        botaoFavoritar?.setImage(pacoteViagem.favoritado ? UIImage(named: "icon_favorite_filled") : UIImage(named: "icon_favorite"), for: .normal)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        layer.cornerRadius = 8
    }
}
