//
//  BudgetViewController.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/12/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {

    @IBOutlet weak var currentBudgetLabel: UILabel!
    @IBOutlet weak var editBudgetButton: UIButton!
    @IBOutlet weak var currentBudgetTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentBudgetTextField.isHidden = true
        // Do any additional setup after loading the view.
        
        let budget = PeriodRepository.getCurrentBudget()
        
        var abc = 0
        
        if let current_budget = budget?.currentBudget {
            abc = Int(exactly:current_budget) ?? 0
            currentBudgetTextField.text = CurrencyFormatter.format(abc)
            currentBudgetLabel.text = CurrencyFormatter.format(abc)
        } else {
            currentBudgetTextField.text = "0"
            currentBudgetLabel.text = "0"
        }
        
    }
    
    @IBAction func editBudgetAction(_ sender: UIButton) {
        currentBudgetLabel.isHidden = true
        currentBudgetTextField.isHidden = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
