//
//  TeslaViewModel.swift
//  MVVM_Practice
//
//  Created by 황홍필 on 2023/05/20.
//

import Foundation


// 테이블 뷰 셀의 ViewModel
class TeslaViewModel {
    
    // 1) fetchNetwork를 통해 [Article]이 초기화된다.
    // 이 Observable 변수는 값의 변화를 계속 관찰하는 역할을 한다. 
    var networkObserver: Observable<[Article]> = Observable([])

    
    func fetchNetwork() {
        TeslaNetworkManager.shared.fetchNetworkData { [weak self] tesla in            
            self?.networkObserver.value = tesla
            
        }
    }
    
    
}
