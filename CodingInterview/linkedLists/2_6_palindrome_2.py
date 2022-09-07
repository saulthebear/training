# Check if a linked list is a palindrome
# Solve without knowing the length

from LinkedList import LinkedList

def is_palindrome(list):
    stack = []

    slow = list.head
    fast = list.head

    should_move = False

    size = 0 # Used to check if odd length
    inMiddle = True # Used to skip middle element in odd lenght list

    while slow:
        if fast:
            # print(f'f: {fast.val} s: {slow.val}')
            if should_move:
                stack.append(slow.val)
                slow = slow.next
            should_move = not should_move
            size += 1
            fast = fast.next
        else:
            # Fist half of list pushed to stack. We are in the middle
            if inMiddle:
                if (size % 2 != 0):
                    slow = slow.next
                inMiddle = False
            else:
                # print(f'curr: {slow.val} stack: {stack}')
                match = stack.pop()
                if match != slow.val:
                    return False
                slow = slow.next

    return True



test_one = LinkedList.from_arr(['a', 'b', 'c', 'd'])
print(test_one)
print(is_palindrome(test_one)) # False

test_two = LinkedList.from_arr(['a', 'b', 'b', 'a'])
print(test_two)
print(is_palindrome(test_two)) # True

test_three = LinkedList.from_arr(['a', 'b', 'c', 'd', 'e'])
print(test_three)
print(is_palindrome(test_three)) # False

test_four = LinkedList.from_arr(['a', 'b', 'c', 'b', 'a'])
print(test_four)
print(is_palindrome(test_four)) # True

test_five = LinkedList.from_arr(['a'])
print(test_five)
print(is_palindrome(test_five)) # True
