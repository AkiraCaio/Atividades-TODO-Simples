//
//  AtividadeTableViewCell.swift
//  ProjetoIOS1
//
//  Created by Caio Vinicius Pinho Vasconcelos on 29/09/19.
//  Copyright © 2019 akira. All rights reserved.
//

import UIKit

class AtividadeTableViewCell: UITableViewCell {

       @IBOutlet weak var backgroundContentView: UIView!
        
        @IBOutlet weak var atividadeLabel: UILabel!
        @IBOutlet weak var prioridadeSegmentedControl: UISegmentedControl!
        @IBOutlet weak var concluidoSwitch: UISwitch!
        
        var atividade: Atividade?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
  
    
}
