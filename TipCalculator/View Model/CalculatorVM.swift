//
//  CalculatorVM.swift
//  TipCalculator
//
//  Created by Afir Thes on 14.02.2023.
//

import Foundation
import Combine

class CalculatorVM {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<TipResult, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {

        let updateViewPublisher = Publishers
            .CombineLatest3(input.billPublisher, input.tipPublisher, input.splitPublisher)
            .flatMap { [unowned self] bill, tip, split in
                let totalTip = getTipAmout(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let amountPerPerson = totalBill / Double(split)
                
                let result = TipResult(
                    amountPerPerson: amountPerPerson,
                    totalBill: totalBill,
                    totalTip: totalTip)
                
                return Just(result)
            }.eraseToAnyPublisher()
        
        return Output(updateViewPublisher: updateViewPublisher)
    }
    
    private func getTipAmout(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
    
    
}
