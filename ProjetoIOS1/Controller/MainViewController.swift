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
        
        var atividadeSelecionada: Atividade?
        var atividadeSelecionadaPosicao: [Int] = []
        
        var adicionados: Int = 0
        
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
        
      
        @IBAction func unwindSalvar(segue:UIStoryboardSegue) {
            let svc = segue.source as! CriandoAtividadeViewController
            
            if svc.isAlteracao{
                self.atividades[self.atividadeSelecionadaPosicao[0]][self.atividadeSelecionadaPosicao[1]] = svc.atividade!
            }else{
                self.atividades[0].append(svc.atividade!)
            }
            
             
            self.tableView.reloadData()
         }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(segue.identifier == "exibirAtividadeDetalhe"){
                if let atividade = self.atividadeSelecionada {
                    let svc = segue.destination as! CriandoAtividadeViewController
                    
                    svc.atividade = atividade
                    svc.isAlteracao = true
                }
                
                self.atividadeSelecionada = nil
            }
        }
    }
            
    extension MainViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.atividadeSelecionadaPosicao.removeAll()

            self.atividadeSelecionada = atividades[indexPath.section][indexPath.row]
        
            self.atividadeSelecionadaPosicao.append(indexPath.section)
            self.atividadeSelecionadaPosicao.append(indexPath.row)

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
           
            
            if indexPath.row < atividades[indexPath.section].count {
                
                let atividade = atividades[indexPath.section][indexPath.row]
                
                if(indexPath.section == 0  && !atividade.concluida){
                    cell.atividadeLabel?.text  = atividade.nome
                    cell.prioridadeSegmentedControl?.selectedSegmentIndex = atividade.prioridade.rawValue
                    cell.concluidoSwitch?.isOn = atividade.concluida

                    switch atividade.prioridade {
                    case .BAIXA:
                        cell.backgroundContentView?.backgroundColor = UIColor.green
                    case .MEDIA:
                        cell.backgroundContentView?.backgroundColor = UIColor.orange
                    case .ALTA:
                        cell.backgroundContentView?.backgroundColor = UIColor.red
                    }
                }else{
                    cell.atividadeLabel?.text  = atividade.nome
                    cell.prioridadeSegmentedControl?.selectedSegmentIndex = atividade.prioridade.rawValue
                    cell.concluidoSwitch?.isOn = atividade.concluida

                    switch atividade.prioridade {
                    case .BAIXA:
                        cell.backgroundContentView?.backgroundColor = UIColor.green
                    case .MEDIA:
                        cell.backgroundContentView?.backgroundColor = UIColor.orange
                    case .ALTA:
                        cell.backgroundContentView?.backgroundColor = UIColor.red
                    }
                }
            }
            
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
