/*
 https://programmers.co.kr/learn/courses/30/lessons/42587#
 프린터
 일반적인 프린터는 인쇄 요청이 들어온 순서대로 인쇄합니다. 그렇기 때문에 중요한 문서가 나중에 인쇄될 수 있습니다. 이런 문제를 보완하기 위해 중요도가 높은 문서를 먼저 인쇄하는 프린터를 개발했습니다. 이 새롭게 개발한 프린터는 아래와 같은 방식으로 인쇄 작업을 수행합니다.
 1. 인쇄 대기목록의 가장 앞에 있는 문서(J)를 대기목록에서 꺼냅니다.
 2. 나머지 인쇄 대기목록에서 J보다 중요도가 높은 문서가 한 개라도 존재하면 J를 대기목록의 가장 마지막에 넣습니다.
 3. 그렇지 않으면 J를 인쇄합니다.
 */
//일부 테스트케이스만 통과. 반례를 찾지 못해 풀이 중지
import Foundation

func solution(_ priorities:[Int], _ location:Int) -> Int {
    var queue: [(priority: Int, location: Int)] = []
    var max: (priority: Int, location: Int) = (0, -1)
    var documents: [(priority: Int, location: Int)] = []
    var index = 0
    
    //우선순위와 location을 묶은 튜플 배열 생성 및 가장 큰 수의 값과 인덱스 구하기
    priorities.enumerated().forEach{
        priority in
        documents.append((priority.element, priority.offset))
        if max.priority < priority.element  { //안정정렬
            max = (priority.element, priority.offset)
        }
    }
    //max.index부터 max.index-1까지 Queue에 정렬. 즉, 2 1 3 2 인 경우 3 2 2 1 순서로 queue에 정렬
    queue.append(documents[max.location])
    index = max.location + 1
    while (index != max.location) { //max.index와 같아지면 한 바퀴를 돌았다는 의미이므로 break
        if index > documents.count - 1 {
            index = 0
        }
        
        if documents[index].priority <= queue.last!.priority {
            queue.append(documents[index])
        } else {//documents[index].priority > queue.last.priority
            let insertIndex = queue.lastIndex(where: {documents[index].priority <= $0.priority})!
            queue.insert(documents[index], at: insertIndex + 1)
        }
        index += 1
    }
    
    let document = queue.firstIndex(where: {$0.location == location})!
    
    return document + 1 //return되는 값은 0번부터 시작하는 location과 다르게 1번부터 시작한다.
}

print(solution([2, 1, 3, 2], 2)) //1
//print(solution([1, 1, 9, 1, 1, 1], 0)) //5
//print(solution([2, 4, 8, 2, 9, 3, 3], 2)) //2
//print(solution([2, 4, 8, 2, 9, 3, 3], 4)) //1
//print(solution([1,2,8,3,4], 4)) //2
//print(solution([3,3,4,2], 3)) //4
//print(solution([2,2,2,1,3,4], 3))  //6
//print(solution([1,2,3,4,5,6,7,8,9,10], 4)) //6
//print(solution([2,3,9,2,3,9], 3)) //5
//print(solution([7, 5, 4, 3, 8, 7, 4, 8, 7, 9, 8, 4, 4, 4, 1, 3, 3, 5, 9, 1, 9, 9, 7, 9, 7, 2, 7, 7, 1, 5, 9, 8, 7, 2, 8, 3, 6, 2], 21)) //4
