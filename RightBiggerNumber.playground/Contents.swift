//스택으로 풀기
/*
 https://www.acmicpc.net/problem/17298
 오큰수
 크기가 N인 수열 A = A1, A2, ..., AN이 있다. 수열의 각 원소 Ai에 대해서 오큰수 NGE(i)를 구하려고 한다. Ai의 오큰수는 오른쪽에 있으면서 Ai보다 큰 수 중에서 가장 왼쪽에 있는 수를 의미한다. 그러한 수가 없는 경우에 오큰수는 -1이다.

 예를 들어, A = [3, 5, 2, 7]인 경우 NGE(1) = 5, NGE(2) = 7, NGE(3) = 7, NGE(4) = -1이다. A = [9, 5, 4, 8]인 경우에는 NGE(1) = -1, NGE(2) = 8, NGE(3) = 8, NGE(4) = -1이다.
 */
//NGE(1)을 구할 때, 비교기준 = 3 비교대상들 = 5 2 7
import Foundation

var n: Int
var numbers: [Int] = []
var results: String = "" //오큰수들을 저장할 문자열 변수

n = Int(readLine()!)!
numbers = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
var temp = numbers //한 반복마다 비교기준 값을 지우고 비교할 대상들만 남기기 위해 임시 배열 생성

numbers.forEach{
    comparedNum in
    var stack: [Int] = [] //comparedNum보다 큰 수들을 저장할 stack
    var result: Int = -1 //오큰수를 저장한 변수
    
    temp.removeFirst() //비교기준 값, 즉 comparedNum에 해당하는 값을 지우고 비교 대상들만 남긴다.
    
    if !temp.isEmpty { //비교대상이 남아있다면 true
        for num in temp.reversed(){ //이 반복문이 끝나면 stack의 top은 오큰수.
            if comparedNum < num {
                stack.append(num)
            }
        }
        result = stack.isEmpty ? -1 : stack.last! //stack이 비어있다면, 즉 오큰수가 없다면 -1/ stack이 차있으면 top이 곧 오큰수
    }
    //temp 배열이 Empty 상태라면,즉 비교대상이 없다면 오큰수는 -1, 아니라면 stack의 top이 오큰수
    results.append("\(result) ")
}

print(results.trimmingCharacters(in: .whitespaces)) //오른쪽 끝 공백을 제거하기 위해 사용
