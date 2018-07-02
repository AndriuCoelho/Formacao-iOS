//
//  TableViewCell.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import AlamofireImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelQuantidadeDias: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var imagemViagem: UIImageView!
    
    func configuraCelula(_ viagem:Viagem) {
        labelTitulo.text = viagem.titulo
        
        if viagem.quantidadeDeDias == 1 {
            labelQuantidadeDias.text = "1 dia"
        }
        else {
            labelQuantidadeDias.text = "\(viagem.quantidadeDeDias) dias"
        }
        
        labelPreco.text = "R$ \(viagem.preco)"
        
        guard let urlDaImagem = URL(string: viagem.caminhoDaImagem) else { return }
        imagemViagem.af_setImage(withURL: urlDaImagem)
        
        imagemViagem.layer.cornerRadius = 10
        imagemViagem.layer.masksToBounds = true
    }
}
