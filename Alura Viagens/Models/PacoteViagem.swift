//
//  PacoteViagem.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class PacoteViagem: NSObject {
    
    let nomeDoHotel: String
    let descricao: String
    let dataViagem: String
    let viagem: Viagem
    
    var favoritado = false
    
    init(nomeDoHotel: String, descricao: String, dataViagem: String, viagem: Viagem) {
        self.nomeDoHotel = nomeDoHotel
        self.descricao = descricao
        self.dataViagem = dataViagem
        self.viagem = viagem
    }
    
    class func serializaPacoteViagem(_ pacotesEntity: [PacoteViagemEntity]) -> [PacoteViagem] {
        var pacotes: [PacoteViagem] = []
        for pacote in pacotesEntity {
            let id = Int(pacote.id)
            let quantidadeDias = Int(pacote.quantidadeDeDias)
            guard let titulo = pacote.titulo else { return [] }
            guard let preco = pacote.preco else { return [] }
            guard let caminhoImagem = pacote.caminhoDaImagem else { return [] }
            
            let novaViagem = Viagem(id: id, titulo: titulo, quantidadeDeDias: quantidadeDias, preco: preco, caminhoDaImagem: caminhoImagem, localizacao: "")
            
            guard let hotel = pacote.nomeDoHotel else { return [] }
            guard let descricao = pacote.descricao else { return [] }
            guard let data = pacote.dataViagem else { return [] }
            
            let novoPacote = PacoteViagem(nomeDoHotel: hotel, descricao: descricao, dataViagem: data, viagem: novaViagem)
            
            pacotes.append(novoPacote)
        }
        
        return pacotes
    }

}
