//
//  WishEventCreationView.swift
//  maprozorskiyPW2
//
//  Created by Михаил Прозорский on 07.02.2024.
//

import UIKit

final class WishEventCreationView: UIViewController
{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let defaults = UserDefaults.standard
    private var wishArray: [String] = []
    private let table: UITableView = UITableView(frame: .zero)
    private let text = UITextField()
    private let note = UITextField()
    private let label = UILabel()
    private let dateView = UIView()
    private let startDateLabel = UILabel()
    private let endDateLabel = UILabel()
    private let startDate = UIDatePicker()
    private let endDate = UIDatePicker()
    private let btnAdd = UIButton()
    
    var didAdd: ((_ item: WishEvent) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishArray = (defaults.array(forKey: Constants.wishesKey) as? [String] ?? [])
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Vars.backColor
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
        configureText()
        configureLabel()
        configureTable()
        configureNote()
        configureDateView()
        configureAddBtn()
        table.dataSource = self
        table.delegate = self
    }
    
    private func configureText() {
        text.backgroundColor = .white
        text.layer.cornerRadius = Constants.buttonRadius
        text.returnKeyType = UIReturnKeyType.done
        text.placeholder = "Wish"
        
        text.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.offset, height: Constants.offset))
        text.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.offset, height: Constants.offset))
        text.leftViewMode = .always
        text.rightViewMode = .always
        text.layer.borderWidth = CGFloat(Constants.one)
        text.layer.borderColor = UIColor.black.cgColor
        
        view.addSubview(text)
        
        text.setHeight(Constants.buttonHeight)
        text.pinHorizontal(to: view, Constants.descriptionTop)
        text.pinTop(to: view, Constants.descriptionTop)
    }
    
    private func configureLabel() {
        label.text = "Write a new wish or select it from the table below"
        label.numberOfLines = .zero
        label.textColor = MakeColor.makeColor()
        
        view.addSubview(label)
        
        label.setHeight(Constants.createEventTop)
        label.pinHorizontal(to: view, Constants.descriptionTop)
        label.pinTop(to: text, Constants.createEventTop)
    }
    
    private func configureTable() {
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        
        table.backgroundColor = MakeColor.makeColor()
        table.allowsSelection = true
        table.separatorStyle = .singleLine
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        view.addSubview(table)
        
        table.pinTop(to: label, Constants.createEventTop)
        table.pinHorizontal(to: view, Constants.descriptionTop)
        table.pinHeight(to: view, Double(Constants.coeff))
    }
    
    private func configureNote() {
        note.backgroundColor = .white
        note.layer.cornerRadius = Constants.buttonRadius
        note.returnKeyType = UIReturnKeyType.done
        note.placeholder = "Note"
        
        note.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.offset, height: Constants.offset))
        note.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.offset, height: Constants.offset))
        note.leftViewMode = .always
        note.rightViewMode = .always
        note.layer.borderWidth = CGFloat(Constants.one)
        note.layer.borderColor = UIColor.black.cgColor
        
        view.addSubview(note)
        
        note.setHeight(Constants.buttonHeight)
        note.pinHorizontal(to: view, Constants.descriptionTop)
        note.pinTop(to: table.bottomAnchor, Constants.offset)
    }
    
    private func configureDateView() {
        dateView.backgroundColor = MakeColor.makeColor()
        dateView.layer.cornerRadius = Constants.tableCornerRadius
        
        dateView.addSubview(startDateLabel)
        dateView.addSubview(endDateLabel)
        dateView.addSubview(startDate)
        dateView.addSubview(endDate)
        
        view.addSubview(dateView)
        
        dateView.pinTop(to: note, Constants.createEventTop)
        dateView.pinHorizontal(to: view, Constants.descriptionTop)
        dateView.pinHeight(to: view, Double(Constants.coeff))
        
        configureStartDateLabel()
        configureEndDateLabel()
        configureStartDate()
        configureEndDate()
    }
    
    private func configureStartDateLabel() {
        startDateLabel.text = "Start date:"
        startDateLabel.numberOfLines = .zero
        startDateLabel.textColor = Vars.backColor
        
        startDateLabel.pinLeft(to: dateView, Constants.offset)
        startDateLabel.pinTop(to: dateView, view.bounds.height * Constants.coeff / Constants.height)
        
        startDate.addTarget(self, action: #selector(changeMinDate), for: .editingDidEnd)
    }
    
    private func configureEndDateLabel() {
        endDateLabel.text = "End date:"
        endDateLabel.numberOfLines = .zero
        endDateLabel.textColor = Vars.backColor
        
        endDateLabel.pinLeft(to: dateView, Constants.offset)
        endDateLabel.pinBottom(to: dateView, view.bounds.height * Constants.coeff / Constants.height)
    }
    
    private func configureStartDate() {
        startDate.datePickerMode = .date
        startDate.minimumDate = Date()
        startDate.calendar = .autoupdatingCurrent
        startDate.backgroundColor = .white
        
        startDate.pinVertical(to: startDateLabel)
        startDate.pinRight(to: dateView, Constants.offset)
    }
    
    private func configureEndDate() {
        endDate.datePickerMode = .date
        endDate.minimumDate = Date() + Constants.day
        endDate.calendar = .autoupdatingCurrent
        endDate.backgroundColor = .white
        
        endDate.pinVertical(to: endDateLabel)
        endDate.pinRight(to: dateView, Constants.offset)
    }
    
    private func configureAddBtn() {
        btnAdd.backgroundColor = MakeColor.makeColor()
        btnAdd.setTitle("Add event", for: .normal)
        btnAdd.titleLabel?.font = .systemFont(ofSize: Constants.buttonTextSize, weight: .bold)
        btnAdd.setTitleColor(Vars.backColor, for: .normal)
        
        btnAdd.layer.cornerRadius = Constants.wrapRadius
        
        view.addSubview(btnAdd)
        
        btnAdd.setHeight(Constants.buttonHeight)
        btnAdd.pinHorizontal(to: view, Constants.descriptionTop)
        btnAdd.pinTop(to: dateView.bottomAnchor, Constants.offset)
        
        btnAdd.addTarget(self, action: #selector(btnAddWasPressed), for: .touchUpInside)
    }
    
    private func showAlertInvalidWish() {
        let alert = UIAlertController(title: "invalid wish field", message: "Make sure the wish field (first text box) is filled in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertInvalidSave() {
        let alert = UIAlertController(title: "invalid save", message: "Something wrong with saving event in the calendar", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func changeMinDate() {
        endDate.minimumDate = startDate.date + Constants.day
    }
    
    @objc
    private func btnAddWasPressed() {
        if text.text == nil || text.text?.isEmpty == true {
            showAlertInvalidWish()
            return
        } else {
            let calendar = CalendarEventModel(
                title: text.text!,
                startDate: startDate.date.convertedDate,
                endDate: endDate.date.convertedDate,
                note: note.text
            )
            
            let result = CalendarManager().create(eventModel: calendar)
            
            if !result {
                showAlertInvalidSave()
                return
            }
            let event = WishEvent(context: context)
            event.notes = note.text
            event.title = text.text
            event.startDate = startDate.date.convertedDate
            event.endDate = endDate.date.convertedDate
            didAdd?(event)
            dismiss(animated: true)
        }
    }
}

extension WishEventCreationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.one
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = wishArray[indexPath.row]
        if let noteCell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as? WrittenWishCell {
            noteCell.configure(with: note)
            return noteCell
        }
        return UITableViewCell()
    }
}

extension WishEventCreationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        text.text = wishArray[indexPath.row]
    }
}
