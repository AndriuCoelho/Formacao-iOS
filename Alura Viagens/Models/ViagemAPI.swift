//
//  ViagemAPI.swift
//  Alura Viagens
//
//  Created by Ândriu Coelho on 29/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import Foundation
import Alamofire

class ViagemAPI {
    
    func getViagens(completion: @escaping(_ viagens: [Viagem]) -> Void, falha: @escaping(_ error: Error) -> Void) {
        
        guard let url = URL(string: "https://jsonblob.com/api/jsonBlob/323504e6-7b9c-11e8-a427-bd70c0ac7141") else { return }
        
        Alamofire.request(url, method: .get).responseJSON { (resposta) in
            switch resposta.result {
            case .success:
                if let json = resposta.result.value as? [[String: Any]] {
                    let listaDeViagens = Viagem().serializeObject(json)
                    completion(listaDeViagens)
                }
                break
            case .failure:
                falha(resposta.result.error!)
                break
            }
        }
    }
}
