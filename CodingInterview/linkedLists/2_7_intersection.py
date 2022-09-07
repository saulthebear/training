# Given two linked lists, determine if the two lists intersect.
# Return the intersecting node.

from LinkedList import Node

# O(n) space
def intersecting_one(list_one, list_two):
    seen = set()

    curr = list_one
    while curr:
        seen.add(curr)
        curr = curr.next

    curr = list_two
    while curr:
        if curr in seen:
            return curr

        curr = curr.next

    return None

# O(1) Space
def intersecting_two(list_one, list_two):

    len_one = 0
    len_two = 0

    curr_one = list_one
    curr_two = list_two

    # find first tail
    while curr_one.next:
        len_one += 1
        curr_one = curr_one.next

    # find second tail
    while curr_two.next:
        len_two += 1
        curr_two = curr_two.next


    # check if they intersect (are the tails the same node?)
    if not curr_one == curr_two:
        return None

    # They do intersect. Now find where

    curr_one = list_one
    curr_two = list_two

    # move pointer of longer list so they are equal
    len_diff = abs(len_one - len_two)
    if len_one > len_two:
        for i in range(len_diff):
            curr_one = curr_one.next
    elif len_two > len_one:
        for i in range(len_diff):
            curr_two = curr_two.next

    # Move pointers together, until the intersecting node is found
    while curr_one:
        if curr_one == curr_two:
            return curr_one

        curr_one = curr_one.next
        curr_two = curr_two.next

    # Not found!?
    return None



n1 = Node('a')
n2 = Node('b')
n3 = Node('c')
n4 = Node('d')
n5 = Node('e')

n6 = Node('f')
n7 = Node('g')
n8 = Node('h')
n9 = Node('i')
n10 = Node('j')

list_one_head = n1
list_two_head = n6

n1.next = n2
n2.next = n3
n3.next = n4

n6.next = n7
n7.next = n8
n8.next = n9

# one: a => b => c => d
# two: f => g => h => i
print('-- Test 1 --')
print(list_one_head.as_list())
print(list_two_head.as_list())
print(intersecting_one(list_one_head, list_two_head)) # None
print(intersecting_two(list_one_head, list_two_head)) # None


# one: a => b => c => d
#               /
# two: f => g =/

n7.next = n3

print('-- Test 2 --')
print(list_one_head.as_list())
print(list_two_head.as_list())
print(intersecting_one(list_one_head, list_two_head)) # n3 (<c>)
print(intersecting_two(list_one_head, list_two_head)) # None

# one: a => b => c => d
#               /
# two:      g =/

list_two_head = n7
n7.next = n3

print('-- Test 3 --')
print(list_one_head.as_list())
print(list_two_head.as_list())
print(intersecting_one(list_one_head, list_two_head)) # n3 (<c>)
print(intersecting_two(list_one_head, list_two_head)) # None

