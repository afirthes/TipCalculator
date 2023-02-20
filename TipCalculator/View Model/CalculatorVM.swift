//
//  CalculatorVM.swift
//  TipCalculator
//
//  Created by Afir Thes on 14.02.2023.
//

import Combine
import Foundation

class CalculatorVM {
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewTapPublisher: AnyPublisher<Void, Never>
    }

    struct Output {
        let updateViewPublisher: AnyPublisher<TipResult, Never>
        let resetCalculatorPublisher: AnyPublisher<Void, Never>
    }

    private var cancellables = Set<AnyCancellable>()
    private var audioPlayerService: AudioPlayerService
    
    init(audioPlayerService: AudioPlayerService = DefaultAudoPlayer()) {
        self.audioPlayerService = audioPlayerService
    }

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
                    totalTip: totalTip
                )

                return Just(result)
            }.eraseToAnyPublisher()
        
        let resetCalculatorPublisher = input
            .logoViewTapPublisher
            .handleEvents(receiveOutput:  { [unowned self] _ in
                
            audioPlayerService.playSound()
                
        }).flatMap {
            return Just($0)
        }.eraseToAnyPublisher()

        return Output(updateViewPublisher: updateViewPublisher,
                      resetCalculatorPublisher: resetCalculatorPublisher)
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
        case let .custom(value):
            return Double(value)
        }
    }
}
