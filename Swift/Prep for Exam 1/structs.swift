protocol Printable {
    func print_info()
}

extension Printable {
    func print_info() {
        print("No info!")
    }
}

struct Merchandise {
	var name: String
   	var pricePerUnit: Double {
        willSet {
            print("Сменяме цената с нова \(newValue)")
            print("Старата цена е \(pricePerUnit)")
        }
        didSet(oldPrice) {
            if oldPrice > pricePerUnit {
                print("Намаление!")
            } else {
                print("Всичко поскъпва!")
            }
        }
    }
	var isAvailable: Bool
    
    init(name: String, pricePerUnit: Double, isAvailable:Bool) {
		self.name = name
   	   	self.pricePerUnit = pricePerUnit
   		self.isAvailable = isAvailable 
	}
}

extension Merchandise {
 	//изчислими пропъртита
   	var incomePerUnit:Double {
    		get {
    			return self.pricePerUnit * 0.2
		}
	}
}

extension Merchandise {	
	var realPricePerUnit:Double {
		get {
	    		return self.pricePerUnit * 0.8
	    	}
	        
		set {
	    		//newValue е името на параметъра. Типът е Double
	        	self.pricePerUnit = newValue * 1.25
	    }
	}
}

extension Merchandise : Printable {
    func print_info() {
        print("\(self.name) cost \(self.pricePerUnit) with income per unit \(self.incomePerUnit) and real price \(self.realPricePerUnit)")
    }
}

var macBookPro = Merchandise(name:"MacBook Pro 15\"", pricePerUnit: 3200.0, isAvailable: true)

print("Income per product: \(macBookPro.incomePerUnit)")
print("Real price: \(macBookPro.realPricePerUnit)")

macBookPro.pricePerUnit = 3500

macBookPro.print_info()

struct BasicData : Printable {
    var a = 25
}

let b = BasicData(a:3)
b.print_info()

var printable_var : Printable = b
printable_var.print_info()
printable_var = macBookPro
printable_var.print_info()

func sum(a:Int, b:Int) -> Int {
    return a + b
}

var f : (Int, Int) -> Int = sum

print("\(f(3,5))")

func specialSum(list : [Int], f : ((Int,Int) -> Int),s: Int) -> Int {
    var result = s
    for a in list {
        result = f(result,a)
    }
    return result
}

let l = [1,34,49,2,5,42,8,-3,-1]

print("\(specialSum(list: l,f : { (a,b) in a*b} ,s:1))")

f = {$0 - $1}

print("\(specialSum(list: l,f : f ,s:1))")