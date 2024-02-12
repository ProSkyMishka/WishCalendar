//
//  WishEventCell.swift
//  maprozorskiyPW2
//
//  Created by Михаил Прозорский on 02.02.2024.
//

import UIKit

class WishEventCell: UICollectionViewCell {
    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    func configureUI() {
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureEndDateLabel()
        configureStartDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEvent) {
        titleLabel.text = event.title
        descriptionLabel.text = event.notes
        startDateLabel.text = "Start Date: \(event.startDate!.shortDate)"
        endDateLabel.text = "End Date: \(event.endDate!.shortDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, Constants.height)
        wrapView.layer.cornerRadius = Constants.wrapRadius
        wrapView.backgroundColor = Vars.backColor
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = MakeColor.makeColor()
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.title)
        
        titleLabel.pinTop(to: wrapView, Constants.descriptionTop)
        titleLabel.pinHorizontal(to: wrapView, Constants.offset)
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.textColor = MakeColor.makeColor()
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.note)
        descriptionLabel.numberOfLines = .zero
        
        descriptionLabel.pinHeight(to: wrapView, Constants.coeff)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.titleTop)
        descriptionLabel.pinHorizontal(to: wrapView, Constants.offset)
    }
    
    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        startDateLabel.textColor = MakeColor.makeColor()
        startDateLabel.font = UIFont.systemFont(ofSize: view?.bounds.width)
        startDateLabel.pinHorizontal(to: wrapView, Constants.two)
        startDateLabel.pinBottom(to: endDateLabel.topAnchor, Constants.two)
    }
    
    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        endDateLabel.textColor = MakeColor.makeColor()
        endDateLabel.font = UIFont.systemFont(ofSize: Constants.date)
        endDateLabel.pinBottom(to: wrapView, Constants.offset)
        endDateLabel.pinHorizontal(to: wrapView, Constants.two)
    }
}
