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
    var isAlteracao: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isAlteracao {
            if let atividade = self.atividade {
                self.ativadeNome.text = atividade.nome
                self.atividadePrioridade.selectedSegmentIndex = atividade.prioridade.rawValue
            }
            
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.isAlteracao = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "novo"){
            let nome = self.ativadeNome.text ?? ""
            let prioridade = PrioridadeEnum(rawValue:self.atividadePrioridade.selectedSegmentIndex) ?? PrioridadeEnum.BAIXA
            
            self.atividade = Atividade(nome: nome, prioridade: prioridade)
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
