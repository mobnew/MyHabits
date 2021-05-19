//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Alexey Kurazhov on 18.05.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    var habitID: Int?
//    var isCloseForm: Bool = false
    
    let cellID = "cellID"
    
    
    let detailTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        if let ID = habitID {
            title = HabitsStore.shared.habits[ID].name
        }
        
        tabBarController?.tabBar.isHidden = false
        
        
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemGray2
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editPress))
        
        
        
        view.addSubview(detailTableView)
        
        
        detailTableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: cellID)
        
        detailTableView.dataSource = self
        detailTableView.delegate = self
        
        
        
        let constraints = [
            detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)

    }
    
    @objc func editPress() {
        guard let editVC = self.storyboard?.instantiateViewController(identifier: "add_edit") as? HabitViewController else { return }
        editVC.habitIDedit = habitID
        editVC.modalPresentationStyle = .fullScreen
        show(editVC, sender: self)

        
    }
    

}


extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! HabitDetailsTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let myHabit = HabitsStore.shared.habits[habitID!]
        let myHabitDate = HabitsStore.shared.dates[indexPath.row]
        
        
        if HabitsStore.shared.habit(myHabit, isTrackedIn: myHabitDate) {
            myCell.accessoryType = .checkmark
            
        } else {
            myCell.accessoryType = .none
            
        }
        
        
        myCell.selectionStyle = .none
        myCell.dayLabel.text = dateFormatter.string(from: HabitsStore.shared.dates[indexPath.row])
        return myCell
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
    
    
}
