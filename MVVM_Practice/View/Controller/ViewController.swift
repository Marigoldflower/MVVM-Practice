//
//  ViewController.swift
//  MVVM_Practice
//
//  Created by 황홍필 on 2023/05/20.
//

import UIKit
import SnapKit


// ViewController에서 해야할 일은 다음과 같다. ⭐️
// 0) ViewModel에게 이벤트가 일어났다고 알려주기
// 1) ViewModel에서 만들어놓은 네트워크 통신 메소드 실행시키기
// 2) 네트워크 통신의 값이 다른 값으로 변경될 때마다, 테이블 뷰에 적용되게끔 bind 해주기

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    let teslaNetworkManager = TeslaNetworkManager.shared
    
    private var teslaViewModel = TeslaViewModel()
    
    var teslaArray: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupLayout()
        setupDelegate()
        registerTableView()
        bind()
        fetchNetwork()
        print("되고 있으면 말 좀 해라?")
        
    }
    
    func setupLayout() {
        
        // 테이블 뷰 오토레이아웃
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(0)
            make.top.equalTo(view.snp.top).offset(0)
            make.trailing.equalTo(view.snp.trailing).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
        }
    }

    func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        
    }
    
    // 1) ViewModel에서 만들어놓은 네트워크 통신 메소드 실행시키기
    // 이 메소드를 통해 value의 값이 변경된다.
    private func fetchNetwork() {
        // teslaViewModel의 인스턴스가 찍히지 않아서 자꾸 nil이 뜨는 문제가 발생하는 것이다. 
        self.teslaViewModel.fetchNetwork()
    }
    
    
    // 2) 네트워크 통신의 값이 다른 값으로 변경될 때마다, 테이블 뷰에 적용되게끔 bind 해주기
    private func bind() {
        teslaViewModel.networkObserver.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("현재 테이블 뷰 셀의 값은 \(teslaViewModel.networkObserver.value?.count ?? 0)")
        return teslaViewModel.networkObserver.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        // 셀을 클릭할 때 아무런 색깔의 변화도 없게 만드는 코드
        cell.sourceName.text = teslaViewModel.networkObserver.value?[indexPath.row].source.name
        cell.author.text = teslaViewModel.networkObserver.value?[indexPath.row].author
        
        return cell
    }
    
    
}
