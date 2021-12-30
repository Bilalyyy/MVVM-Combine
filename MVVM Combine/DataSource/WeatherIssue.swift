//
//  WeatherIssue.swift
//  MVVM Combine
//
//  Created by bilal on 30/12/2021.
//

import Foundation

enum WeatherIssue: Error {
    case json(desc: String)
    case connection(desc: String)
}
