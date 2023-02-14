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
        
//        input.billPublisher.sink { bill in
//            print("the bill: \(bill)")
//        }.store(in: &cancellables)
        
        let result = TipResult(
            amountPerPerson: 500,
            totalBill: 1000,
            totalTip: 50.5)
        
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
    
    
}
