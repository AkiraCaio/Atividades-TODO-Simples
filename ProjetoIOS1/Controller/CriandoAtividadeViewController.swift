//
//  CriandoAtividadeViewController.swift
//  ProjetoIOS1
//
//  Created by Caio Vinicius Pinho Vasconcelos on 29/09/19.
//  Copyright © 2019 akira. All rights reserved.
//

import UIKit

class CriandoAtividadeViewController: UIViewController {
    
    @IBOutlet weak var ativadeNome: UITextField!
    @IBOutlet weak var atividadePrioridade: UISegmentedControl!
    @IBOutlet weak var atividadeConcluida: UISwitch!
    
    var atividade: Atividade?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let atividade = self.atividade {
            self.ativadeNome.text = atividade.nome
            self.atividadePrioridade.selectedSegmentIndex = atividade.prioridade.rawValue
            self.atividadeConcluida.isOn = atividade.concluida
            
            self.atividadeConcluida.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "novo"){
            if let atividade = self.atividade {
                atividade.nome = self.ativadeNome.text ?? ""
                atividade.prioridade = PrioridadeEnum(rawValue:self.atividadePrioridade.selectedSegmentIndex) ?? PrioridadeEnum.BAIXA
                atividade.concluida = self.atividadeConcluida.isOn
            }else{
                let nome = self.ativadeNome.text ?? ""
                let prioridade = PrioridadeEnum(rawValue:self.atividadePrioridade.selectedSegmentIndex) ?? PrioridadeEnum.BAIXA
                
                self.atividade = Atividade(nome: nome, prioridade: prioridade)
            }
        }
    }
}
