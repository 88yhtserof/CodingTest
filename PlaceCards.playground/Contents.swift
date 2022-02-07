/*
 https://www.acmicpc.net/problem/5568
 카드 놓기
 상근이는 카드 n(4 ≤ n ≤ 10)장을 바닥에 나란히 놓고 놀고있다. 각 카드에는 1이상 99이하의 정수가 적혀져 있다. 상근이는 이 카드 중에서 k(2 ≤ k ≤ 4)장을 선택하고, 가로로 나란히 정수를 만들기로 했다. 상근이가 만들 수 있는 정수는 모두 몇 가지일까?

 예를 들어, 카드가 5장 있고, 카드에 쓰여 있는 수가 1, 2, 3, 13, 21라고 하자. 여기서 3장을 선택해서 정수를 만들려고 한다. 2, 1, 13을 순서대로 나열하면 정수 2113을 만들 수 있다. 또, 21, 1, 3을 순서대로 나열하면 2113을 만들 수 있다. 이렇게 한 정수를 만드는 조합이 여러 가지 일 수 있다.

 n장의 카드에 적힌 숫자가 주어졌을 때, 그 중에서 k개를 선택해서 만들 수 있는 정수의 개수를 구하는 프로그램을 작성하시오.
 */
import Foundation

func getIntegerCombination(length: Int, combination: String) {
    
    if length >= k {//개수가 다 채워졌다면
        results.insert(combination)
        return //재귀 호출 멈추기
    }
    
    for i in 0..<numbers.count {
        if numbers[i].isVisited {//방문한 적이 있다면
            continue //다음으로 넘어가기
        }
        
        //방문한 적이 없다면
        numbers[i].isVisited = true
        getIntegerCombination(length: length + 1,
                              combination: combination + numbers[i].number) //재귀 호출
        numbers[i].isVisited = false //재귀 반복문에서 반환되면 다시 '방문한 적 없다'라고 표시.
    }
}


var n: Int
var k: Int
var numbers: [(number: String, isVisited: Bool)] = [] //방문했던 숫자는 true
var results: Set<String> = [] //Set 타입을 사용해 중복 방지

n = Int(readLine()!)!
k = Int(readLine()!)!

for _ in 0..<n {
    numbers.append((readLine()!, false)) //모든 숫자 방문 false
}

getIntegerCombination(length: 0, combination: "")

print(results.count)
