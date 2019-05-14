import Foundation

struct Operations {
    let all = [
        "+/-" : Operation.unaryOperation({ -$0 }),
        "%" : Operation.unaryOperation({ $0 / 100 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "×" : Operation.binaryOperation({ $0 * $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "=" : Operation.equals
    ]
}

enum Operation {
    case unaryOperation((Double) -> Double)
    case binaryOperation((Double, Double) -> Double)
    case equals
}

