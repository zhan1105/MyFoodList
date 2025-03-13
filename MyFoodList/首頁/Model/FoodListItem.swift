//
//  FoodListItem.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/13.
//

import Foundation

struct FoodListItem: Codable {
    let id:             String
    let food:           String
    let price:          String
    let address:        String
    let coordinate:     String
    let link:           String
    let evaluate:       Int
    let picture01:      String
    let picture02:      String
}
