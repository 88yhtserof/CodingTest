import Foundation

func solution(_ record: Array<String>) -> Array<Int>{
    var results: [Int] = []
    //먼저 주어진 record의 값을 2차원 배열로 만든다.
    //record의 원소인 문자열을 " "을 기준으로 split하여 배열로 반환 받는다.
    //그후 그 2차원 배열을 FIFO함수와 LIFO함수에 인자로 전달한다.
    let recordArray = record.map{
        Array($0.split(separator: " "))
    }
    
    results.append(FIFO(recordArray)) //선입선출 시 매출원가
    results.append(LIFO(recordArray))
    
    return results
}

func FIFO(_ record: [[Substring]]) -> Int{
    var record = record
    var salesCost = 0
    var saleIndex = -1//판매할 구매수량 인덱스
    var soldOut = 0 //매진된 구매수량 중 끝 인덱스
    for n in 0..<record.count{
        if record[n][0] == "S" {//매출원가 계산
            var sales = Int(record[n][2])! //현재 판매 수량
            for i in 1...n { //현재 판매 전 구매한 활동을 돌아보며 수량 확인 및 판매 n은 현재 판매 인덱스
                if sales > Int(record[saleIndex+i][2])!{ //판매수량이 현재 구매 수량보다 많을 경우,
                  salesCost += Int(record[saleIndex+i][1])! * Int(record[saleIndex+i][2])!
                  sales -= Int(record[saleIndex+i][2])!
                  record[saleIndex+i][2] = "0" //현재 상품(구매수량) 매진
                  soldOut += 1
                }else{ //판매수량이 현재 구매수량보다 적을 경우
                  salesCost += Int(record[saleIndex+i][1])! * sales
                  record[saleIndex+i][2] = "\(Int(record[saleIndex+i][2])! - sales)"
                  sales = 0 //판매수량만큼 판매 완료
                  break
                }
            }
            saleIndex += soldOut //매진된 상품의 인덱스를 기억해 이 다음 상품부터 판매한다.
        }
    }
    return salesCost
}

//두 개의 스택을 생성해 풀이 -> 오답
func LIFO(_ record: [[Substring]]) -> Int {
    var record = record
    var salesCost = 0 //매출원가
    var soldOut = 0 //매진
    var saleIndex = 0
    
    //후입 - 구매활동 배열 : 먼저 구매한 활동이 바닥. 가장 나중에 구매한 활동이 top
    var sale:[(index: Int, price: Int, sales: Int)] = []
    record.enumerated().forEach{
        if $0.element[0] == "S" {
            sale.append(($0.offset, Int($0.element[1])!, Int($0.element[2])!))
        }
    }
    
    saleIndex = sale[0].index - 1
    sale.enumerated().forEach{
        while sale[$0.offset].sales > 0 {
            if saleIndex < 0 {
                saleIndex = sale[$0.offset].index - 1
            }
            if sale[$0.offset].sales > Int(record[saleIndex][2])!{
                sale[$0.offset].sales -= Int(record[saleIndex][2])!
                salesCost += Int(record[saleIndex][1])! * Int(record[saleIndex][2])! //1500
                record[saleIndex][2] = "0"  //상품 매진
                saleIndex -= 1
            }else {
                salesCost += Int(record[saleIndex][1])! * sale[$0.offset].sales // 2100
                record[saleIndex][2] = "\(Int(record[saleIndex][2])! - sale[$0.offset].sales)"
                sale[$0.offset].sales = 0
            }
        }
        saleIndex += soldOut
    }
    
    
    
    return salesCost
}


print(solution(["P 300 6", "P 500 3", "S 1000 4", "P 600 2", "S 1200 1"])) //입출력 예 #1
print(solution(["P 300 6", "P 500 3", "S 1000 4", "P 600 1", "S 1200 2"])) //입출력 예 #2
print(solution(["P 100 4", "P 300 9", "S 1000 7", "P 1000 8", "S 700 7", "S 700 3"])) //입출력 예 #3
