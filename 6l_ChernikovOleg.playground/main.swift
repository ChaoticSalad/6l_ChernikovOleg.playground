//
//  main.swift
//  6l_ChernikovOleg.playground
//
//  Created by Олег Черников on 10.03.2022.
//

import Foundation


enum CarBrands{
    case mitsubishi, dodge, toyota, lada
}

enum EngineStates{
    case running, off
}

enum WindowsStates{
    case up, down
}

class Car{
    var brand: CarBrands
    var engine: EngineStates
    var windows: WindowsStates
    
    init(brand: CarBrands, engine: EngineStates, windows: WindowsStates){
        self.brand = brand
        self.engine = engine
        self.windows = windows
    }
}

extension Car:CustomStringConvertible{
    var description : String {
            return """
            Brand: \(brand), engine: \(engine), windows: \(windows)
            """
    }
}

struct Queue <T:CustomStringConvertible>{
    var cars: [T] = []
    
    mutating func push(car: T){
        cars.append(car)
    }
    
    mutating func pushCars(cars: [T]){
        for car in cars{
            self.push(car: car)
        }
    }
    
    mutating func pop() -> T? {
        if(!ifEmpty()){
            return cars.removeLast()
        }
        else{
            return nil
        }
    }
    
    func ifEmpty() -> Bool{
        return cars.count == 0
    }
    
    func showStack(){
        for car in cars {
            print(car.description)
        }
    }
}

extension Queue{
    func myFilter(predicate:(T) -> Bool) -> [T] {
        var result = [T]()
        for i in cars {
            if predicate(i) {
                result.append(i)
            }
        }
        return result
    }
}

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}

var cars = Queue<Car>();

print(cars.ifEmpty())

var someCar = cars.pop()
print(someCar)

cars.push(car: .init(brand: .mitsubishi, engine: .off, windows: .up))
cars.push(car: .init(brand: .dodge, engine: .off, windows: .up))
cars.push(car: .init(brand: .lada, engine: .off, windows: .up))
cars.push(car: .init(brand: .toyota, engine: .off, windows: .up))
cars.push(car: .init(brand: .mitsubishi, engine: .running, windows: .down))

print(cars.showStack())

var mitsus = Queue<Car>();
mitsus.pushCars(cars: cars.myFilter(predicate: {$0.brand == .mitsubishi}))

print(mitsus.showStack())

var someMitsu = mitsus.cars[safe: 3]

print(someMitsu)

someMitsu = mitsus.cars[safe: 0]

print(someMitsu)

