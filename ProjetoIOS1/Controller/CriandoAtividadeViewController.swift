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
    
    var atividade: Atividade?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let atividade = self.atividade {
            self.ativadeNome.text = atividade.nome
            self.atividadePrioridade.selectedSegmentIndex = atividade.prioridade.rawValue
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "novo"){
            if let atividade = self.atividade {
                atividade.nome = self.ativadeNome.text ?? ""
                atividade.prioridade = PrioridadeEnum(rawValue:self.atividadePrioridade.selectedSegmentIndex) ?? PrioridadeEnum.BAIXA
            }else{
                let nome = self.ativadeNome.text ?? ""
                let prioridade = PrioridadeEnum(rawValue:self.atividadePrioridade.selectedSegmentIndex) ?? PrioridadeEnum.BAIXA
                
                self.atividade = Atividade(nome: nome, prioridade: prioridade)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
