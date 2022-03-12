var temperature = 32
    if temperature <= 0 {
    	print("Много е студено. Облечете се топло.")
    } else if temperature >= 30 {
    	print("Жега е. Да не забравите да си сложите слънцезащитен крем.")
    } else {
    	print("Не е чак толкова студено. Защо не облечете тениска?")
    }

 let someNumber: Int = 3
    switch someNumber {
    case 1,2:
        print("Едно или две")
    case 3:
        print("Три")
        //fallthrough
    default:
        print("Някакво друго число")
    }


let count = 34
    let things = "ябълки"
    var expression: String
    switch count {
    case 0:
        expression = "николко"
    case 1..<10:
        expression = "няколко"
    case 10..<100:
        expression = "десетки"
    case 100..<1000:
        expression = "стотици"
    default:
        expression = "много"
    }
print("\(count) са \(expression) \(things)")

let point = (1, 1)
    switch point {    
    case (0, 0):
        print("точка (0, 0) е в началото на координатната система")
    case (_, 0):
        print("точка (\(point.0), 0) се намира на абсциса х")
    case (0, _):
        print("точка (0, \(point.1)) се намира на абсциса у")
    case (-2...2, -2...2):
        print("точка (\(point.0), \(point.1)) е в квадрата")
    default:    
        print("точка (\(point.0), \(point.1)) е извън квадрата")
    }

    switch point {
    case (let x, 0):
        print("точка (\(x), 0) се намира на абсциса х")
    case (0, let y):
        print("точка (0, \(y)) се намира на ордината у")
    case let (x, y):
        print("точка (\(x), \(y)) е някъде другаде")
    }

for index in 1...5 {
        print("\(index) по 5 е \(index * 5)")
    }
     


let base = 3
    let power = 10
    var answer = 1
    for _ in 1...power {
        answer *= base
    }
    print("\(base) на степен \(power) е \(answer)")

let names = ["Емил", "Спас", "Иван", "Гошо"]
    for name in names {
        print("Здравей, \(name)!")
    }

let numberOfLegs = ["паяци": 8, "мравки": 6, "котки": 4]
    for (animalName, legCount) in numberOfLegs {
        print("\(animalName) има \(legCount) крака")
    }

//While
var flag = false
while !flag {
    print("Не е прекъснато")
    flag = true
}

// Repeat while
repeat {
    print("Не е прекъснато")
    flag = true
} while !flag