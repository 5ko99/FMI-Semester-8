import Foundation

func isDigit(c: Character) -> Bool {
    return c >= "0" && c <= "9"
}

func applyOp(op: String, lhs: Double, rhs: Double) -> Double {
    switch op {
    case "+":
        return lhs + rhs
    case "-":
        return lhs - rhs
    case "*":
        return lhs * rhs
    case "/":
        return lhs / rhs
    case "^":
        return pow(lhs, rhs)
    default:
        return 0.0
    }    
}

func precedence(op: String) -> Int {
    switch op {
    case "+", "-":
        return 1
    case "*", "/":
        return 2
    case "^":
        return 3
    default:
        return 0
    }
}


//function that calculates an equation 
func evaluate(expression: String) -> Double {
    let arr = Array(expression)

    var values = [Double]()

    var ops = [Character]()

    var i = 0

    while i < arr.count {
        if(arr[i] == " ") {
            i+=1
            continue
        }

        if(isDigit(c : arr[i])) {
            var val : Double = 0
            while (i < arr.count && isDigit(c: arr[i])) {
                val = val * 10 + Double(String(arr[i]))!
                i += 1
            }
            values.append(val)
            i -= 1
        } else if (arr[i] == "(") {
            ops.append(arr[i])
        } else if (arr[i] == ")") {
            // pop all the operators until we find a (, then pop the ( and evaluate the expression
            while(values.count >= 2 && i < arr.count && ops.last != "(") {
                let val2 = values.removeLast()
                let val1 = values.removeLast()
                values.append(applyOp(op : String(ops.removeLast()),lhs : val1, rhs:val2))
            }
            //remove the last "("
            ops.removeLast()
        } else {
            // do all evaluation with highest precedence then the current operator.
            while(values.count >= 2 && ops.count > 0  && precedence(op: String(arr[i])) <= precedence(op: String(ops.last!))) {
                let val2 = values.removeLast()
                let val1 = values.removeLast()
                values.append(applyOp(op : String(ops.removeLast()),lhs : val1, rhs: val2))
            }
            // push the operator to the stack
            ops.append(arr[i])
        }
        i+=1
    }

    // pop all the remaining operators and evaluate the expression
    while(values.count >= 2 && ops.count > 0) {
        let val2 = values.removeLast()
        let val1 = values.removeLast()
        values.append(applyOp(op : String(ops.removeLast()),lhs : val1, rhs: val2))
    }

    if(values.count > 0) {
        return values.removeFirst()
    } else {
        return 0.0
    }
}

//let expression = readLine()!
assert(evaluate(expression: " ((23 + 6) * 2)") == 58)
assert(evaluate(expression: "10 + 2 * 6") == 22) // 22
assert(evaluate(expression: "2 + 3 * 4") == 14) 
assert(evaluate(expression: "2 + 3 * 4 + 5") == 19 ) // 19
assert(evaluate(expression: "((2 + 3) * (4 + 5)) ^ 2") == 2025) // 2025
assert(evaluate(expression: "100 * ( 2 + 12 ) / 14") == 100 )
assert(evaluate(expression: "100 * ( 2 + 12 ) / 14 + 10") == 110 )
assert(evaluate(expression: "100 * ( 2 + 12 ) / 14 + 10 - 2") == 108 )
assert(evaluate(expression: "100 * ( 2 + 12 ) / 14 + 10 - 2 * 3") == 104 )
assert(evaluate(expression: "(23^4+3*(3/2)^3*6/20*18*1000^1)/80") == 4181.45 )
assert(evaluate(expression: "((1+2)^3 * (1-2)^4 * 29/8 )^2/3") == 3193.171875 )
assert(evaluate(expression: "(15+(9*11/2))") == 64.5 )
assert(evaluate(expression: " ( ( 20 - 10 ) * ( 30 - 20 ) / 10 + 10 ) * 2") == 40 )
assert(evaluate(expression: "( ( 20 - 10 ) * ( 30 - 20 ) + 10 ) * 2") == 220 )
assert(evaluate(expression: " ( ( 20 - 10 ) * ( 30 - 20 ) + 10 ) * 2 + 10") == 230 )
assert(evaluate(expression: "(2*3+4)") == 10)
print(evaluate(expression: readLine()!))