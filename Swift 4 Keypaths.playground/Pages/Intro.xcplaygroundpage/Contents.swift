import Foundation

@objc class Person : NSObject {
    @objc dynamic let name: String
    @objc dynamic var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let bob = Person(name: "Bob", age: 45)
let mary = Person(name: "Mary", age: 28)
let people = [bob, mary]

let nameKeyPath = \Person.name

for person in people {
    person[keyPath: nameKeyPath]
}

func onAgeChange(person: Person) {
    print("Happy birthday, \(person.name)")
}
var observations: [Any] = []
for p in people {
    let keyPath = \Person.age
    let o = p.observe(keyPath, changeHandler: { (person, change) in
        onAgeChange(person: person)
    })
    observations.append(o)
}

let ageKeyPath = \Person.age

for person in people {
    person[keyPath: ageKeyPath] += 1
}

let pathToSecondPerson = \[Person].[1]
dump(people[keyPath: pathToSecondPerson])

let pathTo2ndName = \[Person].[1].name
print(people[keyPath: pathTo2ndName])

struct Baz {
    var value = "Hi there!"
}

struct Bar {
    let baz: Baz = Baz()
}

struct Foo {
    let bar: Bar = Bar()
}

let valueKeyPath = \Foo.bar.baz.value

let foo1 = Foo()
let foo2 = Foo()

foo1[keyPath: valueKeyPath]

class Car {
    @objc let name = "Herbie"
    
    func drive() {
        print("🚗")
    }
}



