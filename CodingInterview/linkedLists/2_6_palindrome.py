# Check if a linked list is a palindrome

from LinkedList import LinkedList

def linked_list_len(list):
    curr = list.head
    size = 0
    while curr:
        size += 1
        curr = curr.next

    return size

def is_palindrome(list):
    size = linked_list_len(list)

    half = size // 2

    diff = []

    curr = list.head
    i = 0

    while curr:
        if i < half:
            diff.append(curr.val)
        elif i > half or (size % 2 == 0 and i == half):
            match = diff.pop()
            if match != curr.val:

                return False

        curr = curr.next
        i += 1

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
