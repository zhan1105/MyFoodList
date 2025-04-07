//
//  FoodListViewModel.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/21.
//

import UIKit
import Foundation

class FoodListViewModel {
    
    private let foodItem: FoodListItem

    var picture: String? {
        return foodItem.picture01
    }
    
    var title: String? {
        return foodItem.food
    }
    
    var price: String? {
        return foodItem.price
    }
    
    var address: String? {
        return foodItem.address
    }
    
    var evaluate: Int {
        return foodItem.evaluate
    }
    
    init (foodItem: FoodListItem) {
        self.foodItem = foodItem
    }
}
