//
//  ViewController.swift
//  NetflixSwift
//
//  Created by Ramon Marbet on 29/03/21.
//

import UIKit

// extenderemos uma UITableViewController para mostrar a lista de collectionView
class FeedMovieViewController: UITableViewController {
    
    //constant criada para evitar ficar reescrevendo a string
    let cellId = "cellId"
    
    var feedMovie: FeedMovie?
    
    // criando loading view
    // no momento que é declarada, torna executavel,
    // já é carrega quando a classe é carregada
    let progressView: UIActivityIndicatorView = {
        let p = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        p.backgroundColor = .black //define a cor do progress para preto
        p.translatesAutoresizingMaskIntoConstraints = false
        p.startAnimating() // já começa animando
        return p
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupIndicatorView()
        
        setupViews()
        
        // pega a unica instancia de NetflixAPI
        let api = NetflixAPI.shared
        
        // aqui tornar essa classe concreta
        api.delegate = self
        
        // e chama o método request()
        api.request()
    }
    
    private func setupViews() {
        // registra o tipo de celula a ser retornado
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    // aplica um indicator sobre a tela
    private func setupIndicatorView() {
        
        // pega a window do SceneDelegate, se tiver nulo retorna sem dar crash no App
        guard let window = SceneDelegate.shared?.window else { return }
        
        // adiciona a progressView por cima
        window.addSubview(progressView)
        
        // trazer a progressView para frente
        window.bringSubviewToFront(progressView)
        
        
        // adiciona as constraints para a window com altura e largura, preenchendo todas as laterais e de cima até embaixo
        window.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : progressView]))
        
        window.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : progressView]))
        
        
        // adiciona constraints para a progressView centralizar na window
        var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(item: progressView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 1))
        
        constraints.append(NSLayoutConstraint(item: progressView, attribute: .centerY, relatedBy: .equal, toItem: window, attribute: .centerY, multiplier: 1, constant: 1))
        
        
        // para funcionar é necessário ativar
        NSLayoutConstraint.activate(constraints)
    }


}

// assinar o FeedMovieDelegate
extension FeedMovieViewController: FeedMovieDelegate {
    
    // quando assinar, deve implementar o corpo do delegate
    func response(status: Int, feed: FeedMovie) {
        progressView.removeFromSuperview() // remove a progressView da tela
        if status == 200 {
            self.feedMovie = feed
        }
    }
}

extension FeedMovieViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //define que o numero de seção será somente 1
        return 1
    }
    
    // numero de linhas em uma seção
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeueReusableCell pega uma célula que ele já criou anteriormente em memória e seta um novo valor pra ela
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        
        // a cada celula nós printamos o valor do indexPath.row
        cell.textLabel?.text = String(indexPath.row)
        
        return cell
    }
    
}
