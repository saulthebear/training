# Sum two numbers represented by linked lists, where each node contains a single digit
# Digits are stored in reverse order, such that the 1's digit is at the head of the list.
# Write a function that adds the two numbers and returns the sum as a linked list.
from LinkedList import Node, LinkedList


def sum_lists(num1_head, num2_head):
    curr_one = num1_head
    curr_two = num2_head

    carry = 0

    sum_head = None
    sum_tail = None

    while curr_one and curr_two:
        sum = curr_one.val + curr_two.val + carry
        carry = 0

        if sum > 10:
            carry = 1
            sum = sum % 10

        new_node = Node(sum)
        if not sum_head:
            sum_head = new_node
            sum_tail = new_node
        else:
            sum_tail.next = new_node
            sum_tail = new_node
        
        curr_one = curr_one.next
        curr_two = curr_two.next

    remaining = curr_one or curr_two
    while remaining:
        sum = remaining.val + carry
        carry = 0

        if sum > 10:
            carry = 1
            sum = sum % 10

        new_node = Node(sum)
        if not sum_head:
            sum_head = new_node
            sum_tail = new_node
        else:
            sum_tail.next = new_node
            sum_tail = new_node

        remaining = remaining.next

    return sum_head

num_one = LinkedList.from_arr([7, 1, 6])
num_two = LinkedList.from_arr([5, 9, 2])


result = sum_lists(num_one.head, num_two.head)
print(result.as_list())


num_three = LinkedList.from_arr([3, 1, 2])
num_four = LinkedList.from_arr([2, 1])

result = sum_lists(num_three.head, num_four.head)
print(result.as_list())


num_five = LinkedList.from_arr([5, 8])
num_six = LinkedList.from_arr([2, 9, 3])

result = sum_lists(num_five.head, num_six.head)
print(result.as_list())



