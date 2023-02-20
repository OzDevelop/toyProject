//
//  TodoList.swift
//  TodoList2
//


import Foundation

struct TodoList {
    var title: String = "" // Todo 제목
    var content: String? // detail, 없을수도 있으므로 옵셔널
    var isComplete: Bool = false // 할일 완료 여부
    
    init (title: String, content: String?, isComplete: Bool = false) {
        self.title = title
        self.content = content
        self.isComplete = isComplete
    }
}

// 데이터에 포함될 정보 (데이터 모델)
