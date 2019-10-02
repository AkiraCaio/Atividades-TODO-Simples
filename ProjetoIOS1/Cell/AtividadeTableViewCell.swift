//
//  AtividadeTableViewCell.swift
//  ProjetoIOS1
//
//  Created by Caio Vinicius Pinho Vasconcelos on 29/09/19.
//  Copyright © 2019 akira. All rights reserved.
//

import UIKit

protocol AtividadeTableViewCellDelegate {
    func concluirAtividade(atividade: Atividade)
}

class AtividadeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundContentView: UIView!
    
    @IBOutlet weak var atividadeLabel: UILabel!
    @IBOutlet weak var prioridadeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var concluidoSwitch: UISwitch!
    
    var atividade: Atividade!
    
    var delegate: AtividadeTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(atividade: Atividade){
        self.atividade = atividade
        
        self.atividadeLabel?.text  = self.atividade.nome
        self.prioridadeSegmentedControl?.selectedSegmentIndex = self.atividade.prioridade.rawValue
        self.concluidoSwitch?.isOn = self.atividade.concluida
        
        self.changeColor()
    }
    
    func changeColor(){
        switch self.atividade.prioridade {
        case .BAIXA:
            self.backgroundContentView?.backgroundColor = UIColor.green
        case .MEDIA:
            self.backgroundContentView?.backgroundColor = UIColor.orange
        case .ALTA:
            self.backgroundContentView?.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func mudarPrioridade(_ sender: Any) {
        self.atividade.prioridade = PrioridadeEnum(rawValue:self.prioridadeSegmentedControl.selectedSegmentIndex)!
        self.changeColor()
    }
    
    @IBAction func conclusaoAtividade(_ sender: Any) {
        self.atividade.concluida = self.concluidoSwitch.isOn
        self.delegate.concluirAtividade(atividade: self.atividade)
    }
}
