/*
 https://programmers.co.kr/learn/courses/30/lessons/42583#
 다리를 지나는 트럭
 LinkedList로 풀기
 */
import Foundation

class Node {
    var data: Int
    var pre: Node?
    var next: Node?
    
    init(data: Int) {
        self.data = data
    }
}

//양방향 LinkedList
class DoublyLinkedList {
    private var head: Node?
    private var tail: Node?
    var count = 0
    
    
    func removeLast() -> Int? {
        var data: Int
        
        //빈 리스트일 경우
        if head == nil {return nil}
        
        //head만 있을 경우 - 원소가 한 개
        if head!.next == nil {
            data = head!.data
            head = nil
            tail = nil //tail도 head와 같은 노드를 가리키고 있었을테니 같이 nil처리
            return data
        }
        
        //원소가 두 개 이상일 경우
        data = tail!.data
        tail = tail!.pre //뒤에서 두 번째 노드를 가리키기
        tail!.next?.pre = nil
        tail!.next = nil  //참조만 끊어주면 ARC에 의해 자동으로 메모리에서 해제
        
        return data
    }
    
    func append(data: Int) {
        let newNode = Node(data: data)
        
        //빈 리스트일 경우
        if head == nil {
            head = newNode
            tail = head //처음이지 마지막 노드이므로 tail은 head와 같은 노드를 가리킨다.
        }
        
        //한 개 이상일 경우
        tail?.next = newNode //기존 리스트의 마지막 노드가 새 노드를 가리키게 한 후
        tail?.next?.pre = tail //새 노드가 기존 리스트의 마지막 노드를 가리키게 만든다.
        tail = newNode //그리고 tail이 새 노드를 가리키게 만든다.
        
        count += 1
    }
    
    func insertFirst(data: Int) {
        let newNode = Node(data: data)
        
        //빈 리스트일 경우
        if head == nil {
            head = newNode
            tail = head //처음이지 마지막 노드이므로 tail은 head와 같은 노드를 가리킨다.
        }
        
        //한 개 이상일 경우
        head?.pre = newNode //기존 리스트의 첫 번째 노드가 새 노드를 가리키게 한 후
        head?.pre?.next = head //새 노드가 기존 리스트의 첫 번째 노드를 가리키게 한다.
        head = newNode //그리고 head가 새 노드를 가리키게 만든다.
        
        count += 1
    }
}

//문제 시작
func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    var bridge: DoublyLinkedList = DoublyLinkedList()
    var currentWeight = 0 //현재 다리에 올라간 트럭들의 무게
    var numberOfTruckCrossing = 0 //지나간 트럭 개수
    var time: Int = 0 //경과 시간
    var truckNumber = 0 //트럭 번호
    
    while numberOfTruckCrossing < truck_weights.count { //모든 트럭이 다 지나갈 때까지 반복
        var weightToInsert = 0
        
        //다리를 지날 트럭 무게 빼기
        if bridge.count >= bridge_length {
            let truckWeight = bridge.removeLast()!
            currentWeight -= truckWeight
            //트럭이 지나간 경우 지나간 트럭 개수 더하기
            //0: 트럭 없음, 0< : 트럭 있음
            numberOfTruckCrossing += truckWeight > 0 ? 1 : 0
        }
        
        //다음 트럭이 다리 지날지 말지 정하기
        if truckNumber < truck_weights.count, currentWeight + truck_weights[truckNumber] <= weight {
            weightToInsert = truck_weights[truckNumber]
            truckNumber += 1
        } else {
            weightToInsert = 0
        }
        bridge.insertFirst(data: weightToInsert)
        currentWeight += weightToInsert
        time += 1
    }
    
    return time
}

print(solution(100, 100, [10,10,10,10,10,10,10,10,10,10]))
