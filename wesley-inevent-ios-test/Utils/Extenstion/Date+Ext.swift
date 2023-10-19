//
//  Date+Ext.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 19/10/23.
//

import Foundation

func convertDateFormatter(inputDateString: String, inputFormat: String, outputFormat: String) -> String? {
    let dateFormatterInput = DateFormatter()
    dateFormatterInput.dateFormat = inputFormat

    if let date = dateFormatterInput.date(from: inputDateString) {
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = outputFormat

        return dateFormatterOutput.string(from: date)
    } else {
        return nil
    }
}
