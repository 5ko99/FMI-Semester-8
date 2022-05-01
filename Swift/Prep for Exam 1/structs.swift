struct LazyStruct {
	var count: Int
	init (count:Int) {
		print("\(LazyStruct.self) се конструира чрез -> \(#function)")
		self.count = count
	}
}

struct NormalStruct {
	var count: Int
	init (count:Int) {
		print("\(NormalStruct.self) се конструира чрез -> \(#function)")
		self.count = count
	}
}
	
struct ExampleLazyProperty {
	lazy var s:LazyStruct = LazyStruct(count: 5)
	var normal:NormalStruct = NormalStruct(count: 10)
	var regularInt = 5
	    
	init() {
		print("\(ExampleLazyProperty.self) се конструира чрез -> \(#function)")
	}
}
	
var lazyPropExample = ExampleLazyProperty()
lazyPropExample.regularInt = 15
print("Стойноста в нормалното пропърти 'regularInt' e \(lazyPropExample.regularInt)")
print("Стойноста в нормалното пропърти 'normal' e \(lazyPropExample.normal.count)")
print("Стойноста на мързеливото пропърти е \(lazyPropExample.s.count)")
print("Стойноста в нормалното пропърти 'regularInt' е \(lazyPropExample.regularInt)")