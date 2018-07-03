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
    
    func alteraFavorito(_ pacote: PacoteViagem) {
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
}
