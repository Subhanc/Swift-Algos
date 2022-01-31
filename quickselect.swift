class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var result: [Int] = nums
        
        // Min Heap 
        var heap: Heap<Int> = Heap { (first, second) -> Bool in 
            return first < second 
        }    
        
        for num in nums { 
            heap.enqueue(num)
            if heap.count > k { 
                heap.dequeue()!
            }
        }
        return heap.dequeue()!
    }
}
  
class Solution { 
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        let left = 0
        let right = nums.count - 1
        let k = nums.count - k // Largest element, change this to k-1 for smallest. 
        return quickSelect(left, right, k, &nums)
    }

    func quickSelect(_ left: Int, _ right: Int, _ k: Int, _ nums: inout [Int]) -> Int {        
        let actualIndex = partition(left, right, &nums)
        if actualIndex == k {
            return nums[k]
        } else if actualIndex < k {
            return quickSelect(actualIndex + 1, right, k, &nums)
        } else {
            return quickSelect(left, actualIndex - 1, k, &nums)
        }
    }

    private func partition(_ left: Int, _ right: Int, _ nums: inout [Int]) -> Int {
        var pivotPoint = left
        for i in left...right {
            if nums[i] < nums[right] { // choose right most value as pivot 
                swap(i, pivotPoint, &nums)
                pivotPoint += 1
            }
        }
        swap(pivotPoint, right, &nums)
        return pivotPoint
    }

    private func swap(_ i: Int, _ j: Int, _ nums: inout [Int]) {
        let temp = nums[i]
        nums[i] = nums[j]
        nums[j] = temp
    }
}
