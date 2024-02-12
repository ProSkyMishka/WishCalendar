//
//  AddWishCell.swift
//  maprozorskiyPW2
//
//  Created by Михаил Прозорский on 11.11.2023.
//

import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddCell"
    
    private var btnAdd = UIButton()
    private var txtInput = UITextView()
    
    var delegate: wishDelegate!
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(txtInput)
        
        txtInput.font = .systemFont(ofSize: Constants.textSize, weight: .regular)
        txtInput.textColor = Vars.backColor
        txtInput.backgroundColor = .clear
        txtInput.pinHeight(to: contentView, Constants.diff)
        txtInput.pinHorizontal(to: contentView, Constants.wrapOffsetH)
        
        contentView.addSubview(btnAdd)
        
        btnAdd.pinRight(to: contentView)
        btnAdd.pinWidth(to: contentView)
        btnAdd.pinHeight(to: contentView, Constants.coeff)
        btnAdd.pinCenterX(to: contentView)
        btnAdd.pinBottom(to: contentView)
        
        btnAdd.backgroundColor = Vars.backColor
        btnAdd.setTitle("Add your dream", for: .normal)
        btnAdd.titleLabel?.font = .systemFont(ofSize: Constants.buttonTextSize, weight: .bold)
        btnAdd.setTitleColor(MakeColor.makeColor(), for: .normal)
        
        btnAdd.layer.cornerRadius = Constants.wrapRadius
        
        btnAdd.addTarget(self, action: #selector(onClickAddButton(_:)),
                         for: .touchUpInside)
    }
    
    @objc
    func onClickAddButton(_ sender: Any) {
        if let txt = txtInput.text, !txt.isEmpty {
            delegate.wishAdd(wish: txt)
            txtInput.text = ""
        }
    }
}
