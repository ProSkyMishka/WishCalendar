//
//  WishCalendarViewController.swift
//  maprozorskiyPW2
//
//  Created by Михаил Прозорский on 02.02.2024.
//

import UIKit
import CoreData

class WishCalendarViewController: UIViewController, UICollectionViewDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let btn = UIButton()
    private var events: [WishEvent] = []
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWishEvents()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = Vars.backColor
        configureBtn()
        configureCollection()
    }
    
    private func configureBtn() {
        let largeFont = UIFont.systemFont(ofSize: Constants.buttonTextSize, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "plus", withConfiguration: configuration)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(btnWasPressed))
        navigationItem.rightBarButtonItem?.tintColor = MakeColor.makeColor()
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = MakeColor.makeColor()
        collectionView.layer.cornerRadius = Constants.wrapRadius
        
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = .zero
            layout.minimumLineSpacing = .zero
            layout.invalidateLayout()
        }
        
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.collectionTop)
    }
    
// Потом
//    private func handleDelete(indexPath: IndexPath) {
//        if !events.isEmpty {
//            events.remove(at: indexPath.row)
//            collectionView.reloadData()
//        }
//    }
    
    @objc
    private func btnWasPressed() {
        let vc = WishEventCreationView()
        present(vc, animated: true, completion: nil)
        vc.didAdd = { [weak self] (item) in
            self?.events.append(item)
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        let event: WishEvent = events[indexPath.row]
        wishEventCell.configure(with: event)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
// Потом доделаю
//    func collectionView(_ collectionView: UICollectionView, performPrimaryActionForItemAt indexPath: IndexPath) {
//        let deleteAction = UIContextualAction(
//            style: .destructive,
//            title: .none
//        ) { [weak self] (action, view, completion) in
//            self?.handleDelete(indexPath: indexPath)
//            completion(true)
//        }
//        
//        deleteAction.image = UIImage(
//            systemName: "trash.fill",
//            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
//        )?.withTintColor(.white)
//        deleteAction.backgroundColor = .red
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(view.bounds.width) - Constants.coeff3 * Int(Constants.spacing)) / Int(Constants.two)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
    }
}

// MARK: - Core Data Requests
extension WishCalendarViewController {
    func getWishEvents() {
        let fetchRequest: NSFetchRequest<WishEvent> = WishEvent.fetchRequest()
        do {
            let items = try context.fetch(fetchRequest)
            events = items
        } catch {
            showAlertSmthGoneWrong()
        }
    }
    
//  Потом
//    func deleteEvent() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = WishEvent.fetchRequest()
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        do {
//            try context.execute(batchDeleteRequest)
//        } catch {
//            showAlertSmthGoneWrong()
//        }
//    }
    
    private func showAlertSmthGoneWrong() {
        let alert = UIAlertController(title: "invalid", message: "Something's gone wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
