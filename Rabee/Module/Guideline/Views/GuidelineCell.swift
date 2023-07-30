//
//  GuidelineTableViewCell.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 27/07/23.
//

import UIKit

enum GuidelineState {
    case notFinished
    case finished
    case current
}

class GuidelineCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "GuidelineTableViewCell"
    var guidelineState: GuidelineState = .notFinished {
        didSet {
            switch guidelineState {
            case .notFinished:
                print("state")
                circleIndicator.image = UIImage(named: "ProgressCircleNotDone")
                stepLabel.isHidden = false
                spacerHStack.isHidden = true
                guidelineTitle.isHidden = false
                insideStackView.isHidden = true
                separator.isHidden = false
                
                contentView.backgroundColor = .whiteColor
            case .finished:
                print("state")
                circleIndicator.image = UIImage(named: "ProgressCircleDone")
                stepLabel.isHidden = true
                spacerHStack.isHidden = false
                guidelineTitle.isHidden = false
                insideStackView.isHidden = true
                separator.isHidden = true
                
                contentView.backgroundColor = .whiteColor
            case .current:
                print("state")
                circleIndicator.image = UIImage(named: "ProgressCircleCurrent")
                stepLabel.isHidden = false
                spacerHStack.isHidden = true
                guidelineTitle.isHidden = true
                insideStackView.isHidden = false
                separator.isHidden = true
                
                //Handling bg
//                contentView.backgroundColor = .whiteColor
//                contentView.layer.backgroundColor = UIColor.whiteColor.cgColor
                contentView.layer.insertSublayer(CAGradientLayer.getLinearPeach(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40, height: 170)), at: 0)
                contentView.layer.cornerRadius = 20
                contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                contentView.clipsToBounds = true
                
            }
            
        }
    }
    var circleIndicatorTopConstraint: NSLayoutConstraint?
    var circleIndicatorBottomConstraint: NSLayoutConstraint?
    var currentStep: Int?
    
    // MARK: - UI Components
    
    var dashedLineLayer: CAShapeLayer! = {
        let line = CAShapeLayer()
        line.strokeColor = UIColor.black.cgColor
        line.lineWidth = 1
        line.lineDashPattern = [4, 4] // Customize the pattern as needed
        line.lineCap = .round
        return line
    }()
    
    private let circleIndicator: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "ProgressCircleDone")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let stepLabel: UILabel = {
        let label = UILabel()
        label.text = "Step 1/4"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor.textBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let guidelineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let spacerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let spacerHStack: UIStackView = {
        let hs = UIStackView()
        hs.alignment = .fill
        hs.distribution = .fill
        return hs
    }()
    
    let insideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.backgroundColor = .whiteColor.withAlphaComponent(0.2)
        stackView.layer.cornerRadius = 12
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        stackView.layer.borderColor = UIColor(red:255/255, green:225/255, blue:255/255, alpha: 0.3).cgColor

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let guidelineTitle: UILabel = {
        let label = UILabel()
        label.text = "Pilih Tema Wedding"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor.textBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let guidelineInsideTitle: UILabel = {
        let label = UILabel()
        label.text = "Pilih Tema Wedding"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor.textBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let guidelineDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "Konsep atau gaya yang menjadi panduan dalam merancang seluruh acara pernikahan."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.textBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doneLabel: UILabel = {
        let label = UILabel()
        label.text = "Selesai"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor.textTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red:255/255, green:237/255, blue:238/255, alpha: 1)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        
        return label
    }()
    
    private let separator: UIView = {
       let line = UIView()
        line.backgroundColor = UIColor(red:255/255, green:237/255, blue:238/255, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashedLineLayer.path = createDashedLinePath().cgPath
    }
    
    
    // MARK: - UI Set Up
    private func setupUI() {
        
        contentView.layer.addSublayer(dashedLineLayer)
        contentView.addSubview(circleIndicator)
        
        insideStackView.addArrangedSubview(guidelineInsideTitle)
        insideStackView.addArrangedSubview(guidelineDescription)
        
        spacerHStack.addArrangedSubview(doneLabel)
        spacerHStack.addArrangedSubview(spacerView)
        
        guidelineStackView.addArrangedSubview(spacerHStack)
        guidelineStackView.addArrangedSubview(stepLabel)
        guidelineStackView.addArrangedSubview(guidelineTitle)
        guidelineStackView.addArrangedSubview(insideStackView)
        
        contentView.addSubview(guidelineStackView)
        contentView.addSubview(separator)
        
        
        NSLayoutConstraint.activate([
            
            circleIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            circleIndicator.widthAnchor.constraint(equalToConstant: 32),
            circleIndicator.heightAnchor.constraint(equalToConstant: 32),
            
            guidelineStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            guidelineStackView.leadingAnchor.constraint(equalTo: circleIndicator.trailingAnchor, constant: 12),
            guidelineStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            separator.topAnchor.constraint(equalTo: guidelineStackView.bottomAnchor, constant: 12),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            separator.leadingAnchor.constraint(equalTo: guidelineStackView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: guidelineStackView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            doneLabel.heightAnchor.constraint(equalToConstant: 26),
            doneLabel.widthAnchor.constraint(equalToConstant: 80),
            
            
        ])
    }
    
    private func createDashedLinePath() -> UIBezierPath {
        let path = UIBezierPath()
        let startPoint = CGPoint(x: 33, y: 0)
        let endPoint = CGPoint(x: 33, y: bounds.height)
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path
    }
    
    func configure(with guidelineData: GuidelineModel, index: Int) {
        
        guidelineState = guidelineData.state
        stepLabel.text = "Step \(guidelineData.step)/4"
        guidelineTitle.text = guidelineData.title
        guidelineInsideTitle.text = guidelineData.title
        guidelineDescription.text = guidelineData.description
        
        if index == 0 {
            // for first row, put circle indicator to top of tableview
            circleIndicatorTopConstraint = circleIndicator.topAnchor.constraint(equalTo: contentView.topAnchor)
            circleIndicatorTopConstraint?.isActive = true
            
        } else if index == 3 {
            // for last row, circle indicator place at bottom of cell
            circleIndicatorBottomConstraint = circleIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 2)
            circleIndicatorTopConstraint?.isActive = false
            circleIndicatorBottomConstraint?.isActive = true
            
        } else {
            // Beside first and last row, give 15 margin to circleIndicator top anchor
            circleIndicatorTopConstraint = circleIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
            circleIndicatorTopConstraint?.isActive = true
            
        }
    }

}


