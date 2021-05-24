//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Alexey Kurazhov on 18.05.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    var habitID: Int?

    
    let cellID = "cellID"
    
    
    let detailTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let ID = habitID {
            title = HabitsStore.shared.habits[ID].name
        } else { navigationController?.popViewController(animated: true) }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray2
        navigationController?.navigationBar.prefersLargeTitles = false
        
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController{
                   if let historyVC = navVC.viewControllers[0] as? HabitViewController{
                    historyVC.habitIDedit = habitID
                   
               }
           }
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
        

        let myHabit = HabitsStore.shared.habits[habitID ?? 0]
        let myHabitDate = HabitsStore.shared.dates[indexPath.row]
        
        
        if HabitsStore.shared.habit(myHabit, isTrackedIn: myHabitDate) {
            myCell.accessoryType = .checkmark
            
        } else {
            myCell.accessoryType = .none
            
        }
        
        
        myCell.selectionStyle = .none
        myCell.dayLabel.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)

        return myCell
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
    
    
}
