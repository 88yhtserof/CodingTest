import Foundation

/*
 https://programmers.co.kr/learn/courses/30/lessons/42586
 프로그래머스 팀에서는 기능 개선 작업을 수행 중입니다. 각 기능은 진도가 100%일 때 서비스에 반영할 수 있습니다.
 또, 각 기능의 개발속도는 모두 다르기 때문에 뒤에 있는 기능이 앞에 있는 기능보다 먼저 개발될 수 있고, 이때 뒤에 있는 기능은 앞에 있는 기능이 배포될 때 함께 배포됩니다.
 먼저 배포되어야 하는 순서대로 작업의 진도가 적힌 정수 배열 progresses와 각 작업의 개발 속도가 적힌 정수 배열 speeds가 주어질 때 각 배포마다 몇 개의 기능이 배포되는지를 return 하도록 solution 함수를 완성하세요.
 progresses    speeds    return
 [93, 30, 55]    [1, 30, 5]    [2, 1]
 */
func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    var results = progresses
    var resultsSpeed = speeds
    
    var releases: [Int] = [] //배포한 기능의 개수를 저장할 배열
    var returnValue: Int
    
    while true {//하루를 의미하는 반복문
        returnValue = 0
        
        for n in 0..<results.count { //하루동안 개발함을 의미
            results[n] += resultsSpeed[n]
        }
        
        for n in 0..<results.count {//배포 가능여부 확인
            if results[n] >= 100 {
                returnValue += 1
            }else {
                //100이하인 progressess는 출시되지 못하며, 앞 기능이 출시되지 않는다면 뒤 기능도 출시 불가능하므로 배포 가능여부 확인을 중단한다.
                break
            }
        }
        
        //하루 끝, 배포 가능 개수 확인
        if returnValue > 0 {
            releases.append(returnValue)
            
            //pop : 배포 완료한 기능을 작업 진도란에서 제거
            results.removeSubrange(0..<returnValue)
            resultsSpeed.removeSubrange(0..<returnValue) //result의 인덱스와 통일시키기 위해서 speed에서도 배포 완료한 기능의 speed를 pop한다.
        }
        
        if results.isEmpty { //더 이상 배포할 기능이 없다면 기능 작업 종료
            break
        }
    }
    
    return releases
}

solution([40,93,30,55,60,65], [60,1,30,5,10,7])
