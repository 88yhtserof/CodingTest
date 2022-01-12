import Foundation

/*
 가장 큰 수 구하기
 퀵 정렬을 사용하여 내림차순으로 정렬
 swift에서 배열은 값타입.
 */
func solution(_ numbers:[Int]) -> String {
    var str: String = ""
    var result : Array<Int> = []
    
    //한 자리 수의 원소를 가진 배열로 만들기
    str = numbers.map{String($0)}.joined() //배열의 모든 원소를 하나의 문자열로 만든다.
    result = str.compactMap{$0.wholeNumberValue} //문자열의 각 원소를 가진 배열을 만든다.
    
    result = qickSort(result, 0, result.count-1) //퀵 정렬
    let resultString = result.map{String($0)}.joined() //배열을 문자열로 형변환
    
    return resultString
}

func qickSort(_ numbers: Array<Int>,
              _ startIndex: Int,
              _ endIndex: Int) -> Array<Int> {//내림차순 정렬
    var numberString = numbers
    var pivot: Int
    
    if(startIndex < endIndex){//numberString의 원소가 2개 이상이어야 정렬 가능.
        (numberString, pivot) = partition(numberString, startIndex, endIndex)// 튜플을 사용해 정렬한 배열과 기준 인덱스 반환받기
        numberString = qickSort(numberString, startIndex, pivot-1) // 앞 부분 정렬
        numberString = qickSort(numberString, pivot+1, endIndex) // 뒷 부분 정렬
    }
    
    return numberString
}

func partition(_ numbers: Array<Int>,
               _ startIndex: Int,
               _ endIndex: Int) -> (Array<Int>, Int) {
    var numberString = numbers
    let x = numberString[endIndex]
    var i = startIndex - 1  //1구역의 끝. 1구역: pivot 이상의 수들의 모임
    
    for j in startIndex...endIndex-1 {
        if numberString[j] >= x {//기준 값 이상이라면 1구역으로 값 이동
            i += 1
            let temp = numberString[i]
            numberString[i] = numberString[j]
            numberString[j] = temp
        }
    }
    //기준 이상 값과 미만 값 사이에 기준값 이동
    let temp = numberString[i+1]
    numberString[i+1] = numberString[endIndex]
    numberString[endIndex] = temp
    
    return (numberString, i+1)
}



print(solution([3,30,34,5,9]))
