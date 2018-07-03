//
//  PacoteViagemAPI.swift
//  Alura Viagens
//
//  Created by Ândriu Coelho on 02/07/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import Foundation
import Alamofire

class PacoteViagemAPI {
    
    func getPacotes(completion: @escaping(_ pacotes: [PacoteViagem]) -> Void, falha: @escaping(_ error: Error) -> Void) {
        
        guard let url = URL(string: "https://jsonblob.com/api/jsonBlob/72ba157b-7e19-11e8-a193-8b2365152932") else { return }
        
        Alamofire.request(url, method: .get).responseJSON { (resposta) in
            switch resposta.result {
            case .success:
                if let json = resposta.result.value as? [[String: Any]] {
                    let pacotesViagem = PacoteViagem.serializaJson(json)
                    completion(pacotesViagem)
                }
                break
            case .failure:
                falha(resposta.result.error!)
                break
            }
        }
        
    }
    
}
