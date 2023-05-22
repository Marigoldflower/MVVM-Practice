//
//  ObservableObject.swift
//  MVVM_Practice
//
//  Created by 황홍필 on 2023/05/20.
//

import Foundation

// 바인딩의 순서를 설명하자면
// 1) 먼저 Model에서 


class Observable<T> {
    // 3) value에 값이 들어오면 listener에 해당 값을 전달한다.
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    // 2) 초기화 함수를 통해 값을 입력받고, 그 값을 value에 저장한다.
    init(_ value: T?) {
        self.value = value
    }
    
    // 4) 3)에서 이 listener 클로저가 호출되면 3번에서 받은 그 값을 여기에 저장한다.
    // 즉, 이 listener는 업데이트 된 값을 저장하는 데에 사용된다.
    private var listener: ((T?) -> Void)?
    
    // 5) value라는 값은 추후에 View에서 사용할 때 사후적으로 넘어가서 사용할 수 있다.
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value) // 1) ~ 4) 과정을 통해 들어온 listener 클로저 값을 실행
        self.listener = listener // 특정 값을 나중에 didSet에서도 실행할 수 있도록 클로저 변수에 담아두기 
    }
    
}
