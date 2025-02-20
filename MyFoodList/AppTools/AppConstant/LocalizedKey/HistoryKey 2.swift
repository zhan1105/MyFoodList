//
//  HistoryKey.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/30.
//

import Foundation

extension LocalizedStringKey {
    enum HistoryKey: String {
        case All_Status                         = "All_Status"
        case Unpaid                             = "Unpaid"
        case Pending                            = "Pending"
        case Funded                             = "Funded"
        case Cancelled                          = "Cancelled"
        case CancRemittance_Infomationelled     = "Remittance_Infomation"
        case Status                             = "Status"
        case Receipt_Method                     = "Receipt_Method"
        case Receipt_Number                     = "Receipt_Number"
        case Remittance_Time                    = "Remittance_Time"
        case Remittance_Amonunt                 = "Remittance_Amonunt"
        case Handling_fee                       = "Handling_fee"
        case Total_Dollars                      = "Total_Dollars"
        case Currency_Code                      = "Currency_Code"
        case Exchange_Rate                      = "Exchange_Rate"
        case Currency_Equivalent                = "Currency_Equivalent"
        case Withdrawal_Country                 = "Withdrawal_Country"
        case Withdrawal_Bank                    = "Withdrawal_Bank"
        case Regenerate_Barcode                 = "Regenerate_Barcode"
    }
}
