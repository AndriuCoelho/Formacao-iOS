//
//  PacoteViagemDao.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import CoreData

class PacoteViagemDao: NSObject {
    
    // MARK: - Atributos
    
    private var resultados: NSFetchedResultsController<PacoteViagemEntity>?
    
    var contexto: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Metodos
    
    func manipulaViagem(_ pacote: PacoteViagem) {
        if pacote.favoritado {
            salva(pacote)
        }
        else {
            deleta(pacote)
        }
    }
    
    func salva(_ pacoteDeViagem: PacoteViagem) {
        guard let entidade = NSEntityDescription.entity(forEntityName: "PacoteViagemEntity", in: contexto) else { return }
        let pacoteViagemObject = NSManagedObject(entity: entidade, insertInto: contexto)
        
        pacoteViagemObject.setValue(pacoteDeViagem.viagem.id, forKey: "id")
        
        pacoteViagemObject.setValue(pacoteDeViagem.viagem.titulo, forKey: "titulo")
        pacoteViagemObject.setValue(pacoteDeViagem.viagem.quantidadeDeDias, forKey: "quantidadeDeDias")
        pacoteViagemObject.setValue(pacoteDeViagem.viagem.preco, forKey: "preco")
        pacoteViagemObject.setValue(pacoteDeViagem.viagem.caminhoDaImagem, forKey: "caminhoDaImagem")
                
        pacoteViagemObject.setValue(pacoteDeViagem.nomeDoHotel, forKey: "nomeDoHotel")
        pacoteViagemObject.setValue(pacoteDeViagem.descricao, forKey: "descricao")
        pacoteViagemObject.setValue(pacoteDeViagem.dataViagem, forKey: "dataViagem")
        
        do {
            try contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func carrega() -> [PacoteViagemEntity] {
        let buscaPacote: NSFetchRequest<PacoteViagemEntity> = PacoteViagemEntity.fetchRequest()
        buscaPacote.sortDescriptors = []
        
        resultados = NSFetchedResultsController(fetchRequest: buscaPacote, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try resultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        guard let pacotes = resultados?.fetchedObjects else { return [] }
        
        return pacotes
    }
    
    func deleta(_ pacoteDeViagem: PacoteViagem) {
        let predicate = NSPredicate(format: "id = \(pacoteDeViagem.viagem.id)")
        let buscaPacote = NSFetchRequest<PacoteViagemEntity>(entityName: "PacoteViagemEntity")
        buscaPacote.predicate = predicate
        do {
            guard let resultado = try contexto.fetch(buscaPacote).first else { return }
            contexto.delete(resultado)
            try contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Mock
    
    func retornaTodasAsViagens() -> [PacoteViagem] {
        
        let pacotePortoGalinhas = PacoteViagem(nomeDoHotel: "Resort Porto de Galinhas", descricao: "Hotel + café da manhã", dataViagem: "8~15 de agosto", viagem: Viagem(id: 1, titulo: "Porto de Galinhas", quantidadeDeDias: 7, preco: "2.490,99", caminhoDaImagem: "img6.jpg"))
        
        let pacoteBuzios = PacoteViagem(nomeDoHotel: "Resort Buzios Spa", descricao: "Hotel + café da manhã", dataViagem: "9~16 de setembro", viagem: Viagem(id: 2, titulo: "Buzios", quantidadeDeDias: 7, preco: "1.990,99", caminhoDaImagem: "img7.jpg"))
        
        let pacoteNatal = PacoteViagem(nomeDoHotel: "Resort Natal Show", descricao: "Hotel + café da manhã", dataViagem: "13~18 de setembroo", viagem: Viagem(id: 3, titulo: "Natal", quantidadeDeDias: 5, preco: "1.700,00", caminhoDaImagem: "img8.jpg"))
        
        let pacoteRioDeJaneiro = PacoteViagem(nomeDoHotel: "Resort RJ Spa", descricao: "Hotel + café da manhã", dataViagem: "9~13 de outubro", viagem: Viagem(id: 4, titulo: "Rio de Janeiro", quantidadeDeDias: 4, preco: "2.300,00", caminhoDaImagem: "img9.jpg"))
        
        let pacoteAmazonas = PacoteViagem(nomeDoHotel: "Pousada Amazonas Plus", descricao: "Hotel + café da manhã", dataViagem: "9~13 de outubro", viagem: Viagem(id: 5, titulo: "Amazonas", quantidadeDeDias: 6, preco: "2.850,00", caminhoDaImagem: "img10.jpg"))
        
        let pacoteSalvador = PacoteViagem(nomeDoHotel: "Pousada Salvador", descricao: "Hotel + café da manhã", dataViagem: "5~10 de novembro", viagem: Viagem(id: 6, titulo: "Salvador", quantidadeDeDias: 6, preco: "1.880,90", caminhoDaImagem: "img11.jpg"))
        
        let listaPacotes: [PacoteViagem] = [pacotePortoGalinhas, pacoteBuzios, pacoteNatal, pacoteRioDeJaneiro, pacoteAmazonas, pacoteSalvador]
        
        return listaPacotes
    }
}
