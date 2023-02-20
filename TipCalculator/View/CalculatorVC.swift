//
//  ViewController.swift
//  TipCalculator
//
//  Created by Afir Thes on 12.02.2023.
//

import Combine
import SnapKit
import UIKit

class CalculatorVC: UIViewController {
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillingInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView,
        ])
        stackView.axis = .vertical
        stackView.spacing = 36
        stackView.alignment = .fill

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        return stackView
    }()

    private lazy var vScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(vStackView)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let vm = CalculatorVM()
    private var canncelables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutViews()
        bind()
    }

    private func bind() {
        let input = CalculatorVM.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: splitInputView.valuePublisher
        )

        let output = vm.transform(input: input)

        output.updateViewPublisher.sink { [unowned self] result in
            resultView.configure(result: result)
        }.store(in: &canncelables)
    }

    private func layoutViews() {
        view.backgroundColor = ThemeColor.bg
        view.addSubview(vScrollView)

        vScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide) // .inset(16)
        }

        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(vScrollView.snp.width)
        }

        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }

        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }

        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(56 + 56 + 16)
        }

        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
}
