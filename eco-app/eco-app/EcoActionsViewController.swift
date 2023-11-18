//
//  EcoActionsViewController.swift
//  eco-app
//
//  Created by Avanti Manjunath on 11/16/23.
//

import UIKit


class EcoActionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TaskAddingDelegate {
    
    var todoItems: [String] = []
    var selectedTasks: [String] = []  // Update to an array of strings
    var numericValue: Int?
    var isToggled: Bool = false
    
    @IBOutlet weak var addTasks: UIButton!

    @IBOutlet weak var todoList: UITableView!
    
    override func viewDidLoad() {
         super.viewDidLoad()

         todoList.delegate = self
         todoList.dataSource = self
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return todoItems.count
     }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ecoCell", for: indexPath) as? EcoCell else {
            fatalError("Unable to dequeue EcoCell")
        }

        // Fetch the selected tasks for the specific cell's index
        let selectedTasksForCell = indexPath.row < selectedTasks.count ? selectedTasks[indexPath.row] : ""

        // Set the selected tasks in the EcoCell
        cell.taskLabel.text = selectedTasksForCell
        cell.numericValueLabel.text = "\(numericValue ?? 0)"
        cell.toggleButton.isSelected = isToggled

        // Set actions for numeric increase/decrease buttons
        cell.increaseButton.addTarget(self, action: #selector(increaseButtonTapped(_:)), for: .touchUpInside)
        cell.decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped(_:)), for: .touchUpInside)

        return cell
    }



    // Handle increase button tap
    @objc func increaseButtonTapped(_ sender: UIButton) {
        // Identify the cell for which the increase button was tapped
        guard let cell = sender.superview?.superview as? EcoCell,
              let indexPath = todoList.indexPath(for: cell) else {
            return
        }

        // Perform the numeric increase logic for the specific cell
        // You can update the numericValue and reload the cell or update as needed
        numericValue! += 1
        todoList.reloadRows(at: [indexPath], with: .none)
    }

    // Handle decrease button tap
    @objc func decreaseButtonTapped(_ sender: UIButton) {
        // Identify the cell for which the decrease button was tapped
        guard let cell = sender.superview?.superview as? EcoCell,
              let indexPath = todoList.indexPath(for: cell) else {
            return
        }

        // Perform the numeric decrease logic for the specific cell
        // You can update the numericValue and reload the cell or update as needed
        numericValue! -= 1
        todoList.reloadRows(at: [indexPath], with: .none)
    }


    // MARK: - TaskAddingDelegate
    func didSelectTasks(_ tasks: [String], fixedTasks: [String]) {
        // Clear the existing items
        todoItems.removeAll()

        // Iterate through selected tasks and find matching task names
        for selectedTask in tasks {
            for fixedTask in fixedTasks {
                if fixedTask.lowercased().contains(selectedTask.lowercased()) {
                    todoItems.append(fixedTask)
                    break
                }
            }
        }

        // Reload the table view
        todoList.reloadData()
    }




     // MARK: - TaskDeleting
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             // Handle the deletion of the selected task
             todoItems.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .fade)
         }
     }

     // MARK: - Navigation
     @IBAction func addTasksButtonPressed(_ sender: UIButton) {
         if let taskAddingViewController = storyboard?.instantiateViewController(withIdentifier: "TaskAddingViewController") as? TaskAddingViewController {
             taskAddingViewController.delegate = self
             present(taskAddingViewController, animated: true, completion: nil)
         }
     }
 }
