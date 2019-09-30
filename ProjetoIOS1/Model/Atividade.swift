//
//  Atividade.swift
//  ProjetoIOS1
//
//  Created by Caio Vinicius Pinho Vasconcelos on 29/09/19.
//  Copyright © 2019 akira. All rights reserved.
//

import Foundation

class Atividade {
    var nome: String
    var prioridade: PrioridadeEnum
    var concluida: Bool
    
    init(nome: String, prioridade: PrioridadeEnum, concluida: Bool = false) {
        self.nome = nome
        self.prioridade = prioridade
        self.concluida = concluida
    }
}
