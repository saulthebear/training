# Write code to partition a linked list around a value x, such taht all nodes less than x come before all nodes greter than or equal to x.
# (IMPORTANT: The partition element x can appear anywhere in the "right partition"; it does not need to appear between the left and right partitions.)

from LinkedList import LinkedList

def partition(input_head, p_val):
    l_head = None
    l_tail = None
    r_head = None

    curr = input_head
    prev = None
    next = None

    while curr:
        next = curr.next

        if curr.val < p_val:
            # add to left list
            if not l_head:
                # If left list hasn't started
                l_head = curr
                l_tail = curr
                curr.next = None
            else:
                # If left list already started
                l_tail.next = curr
                l_tail = curr

            if prev:
                prev.next = next
        else:
            # This node belongs on the right
            prev = curr
            if not r_head:
                # if r_head doesn't exist, this is the start of the right list
                r_head = curr

        # In all cases move curr pointer
        curr = next

    # if no left list, just return right head
    if not l_head:
        return r_head

    # Merge left list and right list
    # by pointing left tail's next to right's head
    l_tail.next = r_head

    # return the start of the new list, which is left head
    print(f'returning left head: {l_head}')
    return l_head

ll = LinkedList.from_arr([3, 5, 8, 5, 10, 2, 1])
ll2 = LinkedList.from_arr([6, 5, 8, 1])

print (ll2)
new_list = partition(ll2.head, 5)
print (new_list.as_list())
