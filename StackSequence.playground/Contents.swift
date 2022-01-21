/*
 https://www.acmicpc.net/problem/1874
 스택수열
 스택 (stack)은 기본적인 자료구조 중 하나로, 컴퓨터 프로그램을 작성할 때 자주 이용되는 개념이다. 스택은 자료를 넣는 (push) 입구와 자료를 뽑는 (pop) 입구가 같아 제일 나중에 들어간 자료가 제일 먼저 나오는 (LIFO, Last in First out) 특성을 가지고 있다.

 1부터 n까지의 수를 스택에 넣었다가 뽑아 늘어놓음으로써, 하나의 수열을 만들 수 있다. 이때, 스택에 push하는 순서는 반드시 오름차순을 지키도록 한다고 하자. 임의의 수열이 주어졌을 때 스택을 이용해 그 수열을 만들 수 있는지 없는지, 있다면 어떤 순서로 push와 pop 연산을 수행해야 하는지를 알아낼 수 있다. 이를 계산하는 프로그램을 작성하라.
 */

import Foundation

var n: Int = 0
var stack: [Int] = [] //새 수열을 만들기 전 담는 stack
var operators: [String] = [] //push+ pop- 연산자를 담을 배열
var top = 0 //stack의 top을 담을 변수
var isBreak = false
//stack의 top과 입력받은 수열의 숫자와 같지 않다면 새 수열을 만들 수 없으니 break. 따라서 isBreak이 true이면 "NO"

n = Int(readLine()!)! //n값 받기

for  _ in 1...n { //stack과 연산자 배열 채우기
    let number = Int(readLine()!)! //수열의 숫자 입력받기
    if top < number { //stack의 top보다 입력받은 숫자가 큰가? -> 그렇다면 top 다음 숫자부터 number숫자까지 stack에 채우기
        stack.append(contentsOf: top+1...number) //현재 top의 이후 숫자부터 입력된 숫자만큼 stack에 push
        let pushOperators = Array(repeating: "+", count: number - top) //push한 만큼 +연산자 추가
        operators.append(contentsOf: pushOperators)
    }
    
    if stack.last == number{ //stack의 top 수열의 숫자가 같은가? -> top pop
        let removeValue = stack.removeLast() //top에 있는 값 pop
        operators.append("-") //pop한 만큼 - 연산자 추가
        top = top > removeValue ? top : removeValue //top의 값을 입력된(push된) 값 중 최댓값으로 유지
    }else{ //stack의 top이랑 같지 않으면 원본과 동일한 새 수열을 만들 수 없으니 "NO"출력
        isBreak = true
        break
    }
}

if !isBreak{
    operators.forEach{print($0)}
}else{
    print("NO")
}
