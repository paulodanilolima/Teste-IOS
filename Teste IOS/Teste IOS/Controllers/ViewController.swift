//
//  ViewController.swift
//  Teste IOS
//
//  Created by Paulo Danilo Conceição Lima on 08/08/21.
//

import UIKit

class ViewController: UIViewController, APIManagerDelegate {
   
    var apiManager = APIManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    /*var ids: [String] = ["01", "02", "03", "04", "05", "05", "06", "07", "08", "09", "10", "11", "12"]
    var read:[Bool] = [false, true, false, false, true, false, true, true, false, true, false, false, true]
    var conteudo: [String] = ["O seu pedido foi enviado!", "Seu pedido saiu para entrega!", "O seu pedido foi enviado!", "Você já viu as novas promoções?", "Promoção Pague 1 leve 2!", "Atualize o seu cadastro.", "Pedido em separação", "Nota fiscal emitida!", "Recebemos o pagamento do seu boleto!", "O seu pedido foi enviado!", "Nota fiscal emitida!", "Pedido em separação", "Pagamento aprovado!!"]*/
    
    var newNotification:[String] = []
    var ids:[String] = []
    var read:[Bool] = []
    var conteudo: [String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.fetchAPI()
        tableView.dataSource = self
        apiManager.delegate = self
        apiManager.fetchAPI()
    }
    func didUpdateApi(_ APIManager: APIManager, api: APIModel){
        passaValor(ids2: api.ID, content: api.content, isread: api.isRead)
    }
    
    func didFaildWithError(error: Error) {
        print(error)
    }
    
    func passaValor(ids2: [String], content: [String], isread: [Bool]){
        ids = ids2
        read = isread
        conteudo = content
        separaNotification()
    }
    
    func separaNotification(){
        
        for n in 0...ids.count - 1 {
            if read[n] == true{
                newNotification.append(conteudo[n])
            }
            
    }
        for n in 0...ids.count - 1 {
            if read[n] == false{
                newNotification.append(conteudo[n])
            }
        
    }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newNotification.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = newNotification[indexPath.item]
        return cell
    }
    
    
}
