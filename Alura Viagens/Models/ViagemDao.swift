//
//  ViagemDao.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class ViagemDao: NSObject {
    
    // MARK: - Mock
    
    func retornaTodasAsViagens() -> [Viagem] {
        let ceara = Viagem(id: 1, titulo: "Ceará", quantidadeDeDias: 3, preco: "1.800,59", caminhoDaImagem: "img1.png", localizacao: "Praia de Canoa Quebrada, Aracati")
        let rioDeJaneiro = Viagem(id: 2, titulo: "Rio de Janeiro", quantidadeDeDias: 6, preco: "1.200,00", caminhoDaImagem: "img2.jpg", localizacao: "Copacabana, Rio de Janeiro")
        let interiorSaoPaulo = Viagem(id: 3, titulo: "Atibaia - Sao Paulo", quantidadeDeDias: 1, preco: "890,00", caminhoDaImagem: "img3.jpg", localizacao: "Atibaia")
        let paraiba = Viagem(id: 4, titulo: "Paraíba", quantidadeDeDias: 3, preco: "1.385,00", caminhoDaImagem: "img4.jpg", localizacao: "Pitimbu – Pitimbu")
        let fortaleza = Viagem(id: 5, titulo: "Fortaleza", quantidadeDeDias: 4, preco: "3.120,00", caminhoDaImagem: "img5.jpg", localizacao: "Praia do Futuro")
        let listaViagem:[Viagem] = [rioDeJaneiro, ceara, interiorSaoPaulo, paraiba, fortaleza]
        
        return listaViagem
    }

}
