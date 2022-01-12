import Foundation

/*
 가장 큰 수 구하기
 퀵 정렬을 사용하여 내림차순으로 정렬
 */
func solution(_ numbers:[Int]) -> String {
    var str: String = ""
    var result : Array<Int> = []
    
    for number in numbers { //배열의 모든 원소를 모아 하나의 문자열로 만듦
        str += String(number)
    }
    for char in str {
        result.append(char.wholeNumberValue!)
    }
    
    result = qickSort(result, 0, numbers.count-1) //퀵 정렬
    let resultString = result.map{String($0)}.joined()
    
    return resultString
}

func qickSort(_ numbers: Array<Int>,
              _ startIndex: Int,
              _ endIndex: Int) -> Array<Int> {//내림차순 정렬
    var numberString = numbers
    var pivot = numberString.count-1
    
    if(startIndex < endIndex){//numberString의 원소가 2개 이상이어야 정렬 가능.
        pivot = partition(numberString, startIndex, endIndex) //중앙(기준)값의 인덱스
        numberString = qickSort(numberString, startIndex, pivot-1) // 앞 부분 정렬
        numberString = qickSort(numberString, pivot+1, endIndex) // 뒷 부분 정렬
    }
    
    return numberString
}

func partition(_ numbers: Array<Int>,
               _ startIndex: Int,
               _ endIndex: Int) -> Int {
    var numberString = numbers
    let x = numberString[endIndex]
    var i = startIndex - 1  //1구역의 끝. 1구역: pivot 이상의 수들의 모임
    
    for j in startIndex...endIndex {
        var temp: Int
        
        
        if Int(numberString[j]) >= x {//기준 값 이상이라면 1구역으로 값 이동
            i += 1
            temp = numberString[i]
            numberString[i] = numberString[j]
            numberString[j] = temp
        }
    }
    
    let temp = numberString[i+1]
    numberString[i+1] = numberString[endIndex]
    numberString[endIndex] = temp
    
    return i+1
}



solution([1,2,3])
