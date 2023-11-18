//
//  TaskAddingViewController.swift
//  eco-app
//
//  Created by Avanti Manjunath on 11/16/23.
//

import UIKit

protocol TaskAddingDelegate: AnyObject {
    func didSelectTasks(_ tasks: [String], fixedTasks: [String])
}



class TaskAddingViewController: UIViewController {
    
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    let fixedTasks = ["Recycled plastics, bottles, cans", "Bought locally", "Conserved energy", "Number of trees planted", "Public transportation or carpooling", "Eco Friendly event(s) attended", "Avoided single use plastics"]
    var selectedTasks: [String] = []
    
    // Declare the delegate property
    weak var delegate: TaskAddingDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Register the cell class
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: "taskCell")

        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        // Call the delegate method to send all selected tasks back along with fixedTasks
        delegate?.didSelectTasks(selectedTasks, fixedTasks: fixedTasks)

        // Dismiss the TaskAddingViewController
        dismiss(animated: true, completion: nil)
    }
    
    
    


}

extension TaskAddingViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixedTasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell\(indexPath.row + 1)", for: indexPath) as? TaskCell else {
            fatalError("Unable to dequeue TaskCell")
        }

        // Assuming the buttons have similar actions, you can use a loop for configuration
        let buttons = [cell.Button1, cell.Button2, cell.Button3, cell.Button4, cell.Button5, cell.Button6, cell.Button7]

        for (index, button) in buttons.compactMap({ $0 }).enumerated() {
            button.setTitle("Custom Title \(index + 1)", for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

            // Set the initial state of the button based on selectedTasks
            let task = fixedTasks[indexPath.row]
            button.isSelected = selectedTasks.contains(task)

            // Toggle images based on the selected state
            if button.isSelected {
                button.setImage(UIImage(named: "circle.fill"), for: .normal)
            } else {
                button.setImage(UIImage(named: "circle"), for: .normal)
            }
        }

        return cell
    }





    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = fixedTasks[indexPath.row]

        if let index = selectedTasks.firstIndex(of: selectedTask) {
            selectedTasks.remove(at: index)
        } else {
            selectedTasks.append(selectedTask)
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Handle button tap here
        guard let cell = sender.superview as? TaskCell,
              let indexPath = tasksTableView.indexPath(for: cell) else {
            return
        }

        let task = fixedTasks[indexPath.row]
        print("Button tapped for task: \(task)")

        // Add or remove the selected task based on the button tap
        if let index = selectedTasks.firstIndex(of: task) {
            selectedTasks.remove(at: index)
        } else {
            selectedTasks.append(task)
        }

        // Print selectedTasks to check its contents
        print("Selected tasks: \(selectedTasks)")

        // Update the UI or perform other actions based on the button tap
        sender.isSelected.toggle()

        // Toggle images based on the selected state
        if sender.isSelected {
            sender.setImage(UIImage(named: "circle.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "circle"), for: .normal)
        }
    }



    
    
}
