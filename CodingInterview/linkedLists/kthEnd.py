import LinkedList

my_list = LinkedList.LinkedList.from_arr(['a', 'b', 'c', 'd', 'e', 'f', 'g'])

def kthFromEnd(l, k):
    j = l.head

    for n in range(k):
        if not j:
            return None
        j = j.next


    i = l.head

    while(j):
        i = i.next
        j = j.next

    return i

print(my_list)

print(kthFromEnd(my_list, 1).val)
print(kthFromEnd(my_list, 2).val)
print(kthFromEnd(my_list, 3).val)
print(kthFromEnd(my_list, 4).val)
print(kthFromEnd(my_list, 5).val)
print(kthFromEnd(my_list, 6).val)
print(kthFromEnd(my_list, 7).val)

