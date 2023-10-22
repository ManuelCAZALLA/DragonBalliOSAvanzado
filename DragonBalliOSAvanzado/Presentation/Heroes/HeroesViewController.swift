//
//  HeroesViewController.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 20/10/23.
//

import UIKit

// MARK: - Protocol
protocol HeroesViewControllerDelegate {
    var heroesCount: Int { get }
    var viewState: ((HeroesViewState) -> Void)? {get set}
    
    func sendToObserver()
    func findHero(index: Int) -> Hero?
}

enum HeroesViewState {
    case loading(_ loading: Bool)
    case updateData
}
// MARK: - CLASS
class HeroesViewController: UIViewController {
    // MARK: - IBOutlets
   
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Public Properties
    var heroesViewModel: HeroesViewControllerDelegate?
    
    // MARK: - Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        Observer()
        heroesViewModel?.sendToObserver()
        
    }
    // MARK: - Private Func
    private func initView() {
        tableView.register(
                    UINib(nibName: HeoreViewCell.identifier, bundle: nil),
                    forCellReuseIdentifier: HeoreViewCell.identifier
        )
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func Observer() {
        heroesViewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading(let isLoading):
                    self?.loadingView.isHidden = !isLoading
                
                case .updateData:
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
// MARK: Extension
extension HeroesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroesViewModel?.heroesCount ?? 0
     }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(HeoreViewCell.height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeoreViewCell.identifier, for: indexPath) as? HeoreViewCell else {
            
            return UITableViewCell()
            
        }
        
        if let hero = heroesViewModel?.findHero(index: indexPath.row) {
            cell.updateView(
                name: hero.name,
                image: hero.photo,
                description: hero.description)
        }
        return cell
    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Navegar a detalle
    }
}

