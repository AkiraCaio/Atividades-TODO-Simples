//
//  MainViewController.swift
//  ProjetoIOS1
//
//  Created by Caio Vinicius Pinho Vasconcelos on 29/09/19.
//  Copyright © 2019 akira. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    
    var atividades: [[Atividade]] = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAtviidades()
        
        self.setupTableView()
    }
    
    func setupAtviidades() {
        atividades.append([])
        atividades.append([])
        
        atividades[0].append(Atividade(nome: "Beber Agua", prioridade: .ALTA))
        atividades[0].append(Atividade(nome: "Tomar Whey", prioridade: .MEDIA))
        
        atividades[1].append(Atividade(nome: "Dormir", prioridade: .BAIXA, concluida: true))
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "AtividadeTableViewCell", bundle: nil), forCellReuseIdentifier: "AtividadeTableViewCell")
        
    }
    
    func changeSection(atividade: Atividade, posSection: Int, posRow: Int){
        if atividade.concluida && posSection == 0 {
            self.atividades[0].remove(at: posRow)
            self.atividades[1].append(atividade)
        }else if !atividade.concluida && posSection == 1{
            self.atividades[1].remove(at: posRow)
            self.atividades[0].append(atividade)
        }
    }
    
    @IBAction func unwindSalvar(segue:UIStoryboardSegue) {
        let svc = segue.source as! CriandoAtividadeViewController
        
        if let indexPath = self.tableView.indexPathForSelectedRow{
            
            self.changeSection(atividade: self.atividades[indexPath.section][indexPath.row], posSection: indexPath.section, posRow: indexPath.row)
            
        }else{
            self.atividades[0].append(svc.atividade!)
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "exibirAtividadeDetalhe"){
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let dvc = segue.destination as! CriandoAtividadeViewController
                
                dvc.atividade = atividades[indexPath.section][indexPath.row]
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "exibirAtividadeDetalhe", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.atividades[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.atividades[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AtividadeTableViewCell", for: indexPath) as! AtividadeTableViewCell
        
        let atividade = atividades[indexPath.section][indexPath.row]
        
        if(indexPath.section == 0  && !atividade.concluida){
            cell.bind(atividade: atividade)
        }else{
            cell.bind(atividade: atividade)
        }
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Atividades Abertas"
        case 1:
            return "Atividades Concluidas"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

