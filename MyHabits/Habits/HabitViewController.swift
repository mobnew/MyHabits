//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Alexey Kurazhov on 12.05.2021.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    var habitIDedit: Int?
    
//    MARK: Items
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nameTextField: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont.systemFont(ofSize: 17)
        textfield.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        
        return textfield
    }()
    
    
    private let colorLabel: UILabel = {
        let label = UILabel()
         label.text = "ЦВЕТ"
         label.font = UIFont.boldSystemFont(ofSize: 13)
         label.translatesAutoresizingMaskIntoConstraints = false
         
         return label
    }()
    
    private let colorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1).cgColor
        button.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private let timeText: UILabel = {
        let date = UILabel()
        date.text =   "Каждый день в "
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.systemFont(ofSize: 17)
        
        return date
    }()
    
    
     private let timeTextField: UITextField = {
        let time = UITextField()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.font = UIFont.systemFont(ofSize: 17)
        time.textColor = .systemBlue
        
        time.text = "11:00"
        
        return time
    }()
    
    
     private let timeDatePicker: UIDatePicker = {
        let wheel = UIDatePicker()
        wheel.translatesAutoresizingMaskIntoConstraints = false
        wheel.datePickerMode = .time
        wheel.preferredDatePickerStyle = .wheels
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        let date = dateFormatter.date(from: "11:00")
        wheel.date = date!
        
        wheel.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)

        
        return wheel
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.isHidden = true
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        return button
    }()
    
//    MARK: OBJC
    
    @objc func showAlert() {
        
        let alertController = UIAlertController(title: "Удалить привычку", message: "Удалить привычку \"\(HabitsStore.shared.habits[habitIDedit!].name)\"? ", preferredStyle: .alert)
            
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { (action) -> Void in
            }
            
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (action) -> Void in
                
            HabitsStore.shared.habits.remove(at: self.habitIDedit!)
            HabitsStore.shared.save()
            
            self.navigationController?.popToRootViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    @objc func handleDatePicker(sender: UIDatePicker) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                timeTextField.text = dateFormatter.string(from: sender.date)
            }


            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.view.endEditing(true)
            }

    
    
    @objc func colorButtonPressed() {
            let picker = UIColorPickerViewController()
            self.present(picker, animated: true, completion: nil)
            picker.selectedColor = colorButton.backgroundColor!
        
            picker.delegate = self
        }
    
    
    @objc func closeModal() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func saveHabit() {
        let newHabit = Habit(name: nameTextField.text ?? "Просто привычка",
                             date: timeDatePicker.date,
                             color: colorButton.backgroundColor ?? .black)
        let store = HabitsStore.shared
        
        if let ID = habitIDedit {
            store.habits[ID] = newHabit
        } else {
        store.habits.append(newHabit)
        }
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
        
        
    
//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupTab()
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorButton)
        view.addSubview(timeLabel)
        view.addSubview(timeText)
        view.addSubview(timeTextField)
        view.addSubview(timeDatePicker)
        view.addSubview(deleteButton)
        
        
        if let ID = habitIDedit {
            nameTextField.text = HabitsStore.shared.habits[ID].name
            colorButton.backgroundColor = HabitsStore.shared.habits[ID].color
            timeDatePicker.date = HabitsStore.shared.habits[ID].date
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            timeTextField.text = dateFormatter.string(from: timeDatePicker.date)
            deleteButton.isHidden = false
            tabBarController?.tabBar.isHidden = true
        }
        
        setupConstranits()

        
    }
    
//    MARK: Constraints
    func setupConstranits() {
        
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            timeText.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            timeText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            timeTextField.topAnchor.constraint(equalTo: timeText.topAnchor),
            timeTextField.leadingAnchor.constraint(equalTo: timeText.trailingAnchor),
            
            timeDatePicker.topAnchor.constraint(equalTo: timeText.bottomAnchor, constant: 7),
            timeDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18)
            
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    
    func setupTab() {
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabit))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(closeModal))
        self.navigationItem.title = "Создать"
    }
    
    
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
        
    }
    
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
    
    

    
}
