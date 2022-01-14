import Foundation

/*
 https://programmers.co.kr/learn/courses/30/lessons/42746?language=java
 0 또는 양의 정수가 주어졌을 때, 정수를 이어 붙여 만들 수 있는 가장 큰 수를 알아내 주세요.
 예를 들어, 주어진 정수가 [6, 10, 2]라면 [6102, 6210, 1062, 1026, 2610, 2106]를 만들 수 있고, 이중 가장 큰 수는 6210입니다.
 0 또는 양의 정수가 담긴 배열 numbers가 매개변수로 주어질 때, 순서를 재배치하여 만들 수 있는 가장 큰 수를 문자열로 바꾸어 return 하도록 solution 함수를 작성해주세요.
 numbers    return
 [6, 10, 2]    "6210"
 */
func solution(_ numbers:[Int]) -> String {
    //주어진 매개변수에 해당 배열의 원소들을 인자로 하여 주어진 predicate를 진행
    //주어진 predicate의 결과에 따라 정렬된 배열 반환
    //두 숫자 조합의 크기가 큰 조합의 순서에 따라 정렬
    let sortedNumbers = numbers.sorted{
        Int("\($0)\($1)")! > Int("\($1)\($0)")!
    }
    
    //numbers의 모든 원소가 0일 때, 결과값은 "0"이어야 한다.
    let stringNum = sortedNumbers[0] == 0 ? "0" : sortedNumbers.map{String($0)}.joined()//배열의 모든 원소들을 문자열로 형변환 후  모아 하나로 만들기
    
    return stringNum
}

solution([2,10,6])
