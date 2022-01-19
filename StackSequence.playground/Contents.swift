//
//  main.swift
//  studyCoding
//
//  Created by limyunhwi on 2022/01/19.
//

import Foundation

var n: Int = 0
var stack: [Int] = []
var operators: [String] = []
var top = 0
var isBreak = false



n = Int(readLine()!)! //n값 받기

for  _ in 1...n { //stack과 연산자 배열 채우기
    let number = Int(readLine()!)!
    if top < number {
        stack.append(contentsOf: top+1...number) //현재 top의 이후 숫자부터 입력된 숫자만큼 stack에 push
        let pushOperators = Array(repeating: "+", count: number - top)
        operators.append(contentsOf: pushOperators)
    }
    
    if stack.last == number{
        let removeValue = stack.removeLast() //top에 있는 값 pop
        operators.append("-")
        top = top > removeValue ? top : removeValue //top의 값을 입력된 값 중 최댓값으로 유지
    }else{
        isBreak = true
        break
    }
}

if !isBreak{
    operators.forEach{print($0)}
}else{
    print("NO")
}
