import Foundation

func solution(_ numbers:[Int]) -> String {
    //주어진 매개변수에 해당 배열의 원소들을 인자로 하여 주어진 predicate를 진행
    //주어진 predicate의 결과에 따라 정렬된 배열 반환
    //두 숫자 조합의 크기가 큰 조합의 순서에 따라 정렬
    let sortedNumbers = numbers.sorted{
        Int("\($0)\($1)")! > Int("\($1)\($0)")!
    }
    
    //모든 원소가 0일 때, 결과값은 "0"이어야 한다.
    let stringNum = sortedNumbers[0] == 0 ? "0" : sortedNumbers.map{String($0)}.joined()//배열의 모든 원소들을 문자열로 형변환 후  모아 하나로 만들기
    
    return stringNum
}

solution([2,10,6])
