//
//  HeroesDetailViewController.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 23/10/23.
//

import UIKit
import MapKit
import Kingfisher
// MARK: Protocol
protocol HeroesDetailViewControllerDelegate {
    var viewState: ((HeroeDetailViewState) -> Void)? {get set }
    func sendToObserver()
}

enum HeroeDetailViewState {
    case loading(_ isLoading: Bool)
    case update(hero: Hero?, locations: HeroLocations)
}

// MARK: Class
class HeroesDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var descriptionHero: UITextView!
    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    // MARK: - IBAction
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    var heroesDetailViewModel: HeroesDetailViewControllerDelegate?
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        observer()
        heroesDetailViewModel?.sendToObserver()
    }
    
    private func initView() {
        mapView.delegate = self
    }
    
    private func observer() {
        heroesDetailViewModel?.viewState = { [weak self] state in
            
            DispatchQueue.main.async {
                switch state {
                case .loading(let isLoading):
                    self?.loadingView.isHidden = !isLoading
                    
                case .update(let hero, let locations):
                    self?.updateViews(
                        hero: hero,
                        heroLocations: locations)
                }
            }
        }
    }
    // MARK: - Private Func
    private func updateViews(hero: Hero?, heroLocations: HeroLocations) {
        print("LLamando a updateView")
        imageHero.kf.setImage(with: URL(string: hero?.photo ?? ""))
        roundPhoto(image: imageHero)
        nameHero.text = hero?.name
        descriptionHero.text = hero?.description
        
        heroLocations.forEach {
            mapView.addAnnotation(
                HeroMap(
                    title: hero?.name,
                    info: hero?.id,
                    coordinate: .init(latitude: Double($0.latitud ?? "") ?? 0.0,
                                      longitude: Double($0.longitud ?? "") ?? 0.0)))
        }
    }
    
    private func roundPhoto(image: UIImageView) {
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.6)
        image.layer.cornerRadius = image.frame.height / 2
        image.layer.masksToBounds = false
        image.clipsToBounds = true
    }
}
// MARK: - Extension
extension HeroesDetailViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}
