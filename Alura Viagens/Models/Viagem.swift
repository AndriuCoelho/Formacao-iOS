//
//  Viagem.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class Viagem: NSObject {
    
    // MARK: - Atributos
    
    let id: Int
    let titulo: String
    let quantidadeDeDias: Int
    let preco: String
    let caminhoDaImagem: String
    let localizacao: String
    
    // MARK: - Metodos
    
    init(id: Int, titulo: String, quantidadeDeDias: Int, preco: String, caminhoDaImagem: String, localizacao: String) {
        self.id = id
        self.titulo = titulo
        self.quantidadeDeDias = quantidadeDeDias
        self.preco = preco
        self.caminhoDaImagem = caminhoDaImagem
        self.localizacao = localizacao
    }
    
    convenience override init() {
        self.init(id: 0, titulo: "", quantidadeDeDias: 0, preco: "", caminhoDaImagem: "", localizacao: "")
    }
    
    func serializeObject(_ json: [[String: Any]]) -> [Viagem] {
        var viagens: [Viagem] = []
        for viagem in json {
            guard let id = viagem["id"] as? Int else { return [] }
            guard let titulo = viagem["titulo"] as? String else { return [] }
            guard let quantidadeDeDias = viagem["quantidadeDeDias"] as? Int else { return [] }
            guard let preco = viagem["preco"] as? String else { return [] }
            guard let caminhoDaImagem = viagem["imageUrl"] as? String else { return [] }
            guard let localizacao = viagem["localizacao"] as? String else { return [] }
            
            let novaViagem = Viagem(id: id, titulo: titulo, quantidadeDeDias: quantidadeDeDias, preco: preco, caminhoDaImagem: caminhoDaImagem, localizacao: localizacao)
            viagens.append(novaViagem)
        }
        return viagens
    }
}
