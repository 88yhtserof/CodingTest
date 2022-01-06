import Foundation

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
                break
            }
        }
        
        //하루 끝, 배포 가능 개수 확인
        if returnValue > 0 {
            releases.append(returnValue)
            
            //pop : 배포 완료한 기능을 작업 진도란에서 제거
            results.removeSubrange(0..<returnValue)
            resultsSpeed.removeSubrange(0..<returnValue)
        }
        
        if results.isEmpty { //더 이상 배포할 기능이 없다면 기능 작업 종료
            break
        }
    }
    
    return releases
}

solution([40,93,30,55,60,65], [60,1,30,5,10,7])
