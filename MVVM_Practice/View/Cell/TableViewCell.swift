//
//  TableViewCell.swift
//  MVVM_Practice
//
//  Created by 황홍필 on 2023/05/20.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {

    
    static let identifier = "TableViewCell"
    
    
    let sourceName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    let author: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
    // MARK: - 스택 뷰
    
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [author, sourceName])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(stackView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(20)
            make.top.equalTo(self.snp.top).offset(20)
//            make.trailing.equalTo(self.snp.trailing).offset(0)
//            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
