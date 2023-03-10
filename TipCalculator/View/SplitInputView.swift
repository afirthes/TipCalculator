//
//  SplitInputView.swift
//  TipCalculator
//
//  Created by Afir Thes on 13.02.2023.
//

import Combine
import CombineCocoa
import UIKit

class SplitInputView: UIView {
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Split", bottomText: "the total")
        return view
    }()

    private lazy var decrementButton: UIButton = {
        let button = buildButton(text: "-",
                                 corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])

        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)

        return button
    }()

    private lazy var incrementButton: UIButton = {
        let button = buildButton(text: "+",
                                 corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])

        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value + 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)

        return button
    }()

    private lazy var quantityLablel: UILabel = {
        let label = LabelFactory.build(text: "1",
                                       font: ThemeFont.bold(ofSize: 20),
                                       backgroundColor: .white)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLablel,
            incrementButton,
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()

    private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
    var valuePublisher: AnyPublisher<Int, Never> {
        splitSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    private var cancellables = Set<AnyCancellable>()
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }

    private func observe() {
        splitSubject.sink { [unowned self] quantity in
            quantityLablel.text = quantity.stringValue
        }.store(in: &cancellables)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        splitSubject.send(1)
    }

    private func layout() {
        [headerView, stackView].forEach(addSubview(_:))

        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }

        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }

        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(stackView.snp.centerY)
            make.trailing.equalTo(stackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
    }

    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()

        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addRoundecCornerds(corners: corners, radius: 8.0)
        button.backgroundColor = ThemeColor.primary
        return button
    }
}
