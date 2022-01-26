/*
 https://www.acmicpc.net/problem/11866
 요세푸스 문제 0
 요세푸스 문제는 다음과 같다.

 1번부터 N번까지 N명의 사람이 원을 이루면서 앉아있고, 양의 정수 K(≤ N)가 주어진다. 이제 순서대로 K번째 사람을 제거한다. 한 사람이 제거되면 남은 사람들로 이루어진 원을 따라 이 과정을 계속해 나간다. 이 과정은 N명의 사람이 모두 제거될 때까지 계속된다. 원에서 사람들이 제거되는 순서를 (N, K)-요세푸스 순열이라고 한다. 예를 들어 (7, 3)-요세푸스 순열은 <3, 6, 2, 7, 5, 1, 4>이다.

 N과 K가 주어지면 (N, K)-요세푸스 순열을 구하는 프로그램을 작성하시오.
 */
import Foundation

var n: Int
var k: Int
var people: [Int] //N명의 사람들
var results: [String] = [] // 요세푸스 순열
var removePerson : Int //제거할 세 번째 사람
var result: String //출력할 문자열


n = Int(readLine()!)!
k = Int(readLine()!)!
people = Array(1...n)

while(!people.isEmpty){
    if people.count < 3 { //원형 순열의 요소 개수가 3개 미만이면
        removePerson = people.removeFirst() //세 번째 사람(숫자)는 무조건 0번 인덱스를 가진다.
    } else {
        people.append(contentsOf: people.prefix(2)) //첫 번째, 두 번째 사람(숫자)를 numbers의 뒤에 붙여 원형 배열과 같은 모습이 되도록 한다.
        people.removeFirst(2) //첫 번째, 두 번째 사람(숫자)제거
        removePerson = people.removeFirst() //첫 번째, 두 번째 사람을 제거했으므로 세 번째 사람은 0번 인덱스에 위치한다.
    }
    results.append(removePerson.description)
}

result = results.joined(separator: ", ")
print("<\(result)>")
