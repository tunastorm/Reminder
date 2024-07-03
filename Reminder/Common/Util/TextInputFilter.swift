//
//  TextInputFilter.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import Foundation

class TextInputFilter {
    
//    private init() {}
//    
//    static let filter = TextInputFilter()
    
    // 걸러내야 할 케이스를 클로저 내부에 조건으로 설정
    private var spaceFilter = {(text: String) -> Bool in text != (text.trimmingCharacters(in: .whitespacesAndNewlines))
        || (text.filter{ $0.isWhitespace }.count > 1)}
    private var countFilter = {(text: String) -> Bool in text.count < 2 || text.count >= 10}
    private var specialFilter = "@#$%"
    private var serialSpaceFilter = "/ +(?= )/"
    
    func removeSpace(_ inputText: String) -> String? {
        let trimed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        let replaced = trimed.replacingOccurrences(of: serialSpaceFilter, with: "")
        return replaced == " " ? nil : replaced
    }
    
    func filterSerialSpace(_ inputText: String) -> Bool {
        guard let text = removeSpace(inputText), !text.isEmpty else {
            print(#function, "공백텍스트")
            return false
        }
        print(#function, "공백검사 통과", text)
        return true
    }
}
