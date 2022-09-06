# Write code to partition a linked list around a value x, such taht all nodes less than x come before all nodes greter than or equal to x.
# (IMPORTANT: The partition element x can appear anywhere in the "right partition"; it does not need to appear between the left and right partitions.)

# Simpler implementation, not keeping relative order
# If it belongs on the left, just make it the new head

from LinkedList import LinkedList

def partition(input_head, p_val):
    head = input_head
    prev = input_head
    curr = input_head.next

    while curr:
        if curr.val < p_val:
            next = curr.next
            curr.next = head
            head = curr

            # increment
            prev.next = next
            curr = next
        else:
            # increment
            prev = curr
            curr = prev.next

    return head



ll = LinkedList.from_arr([3, 5, 8, 5, 10, 2, 1])
ll2 = LinkedList.from_arr([6, 5, 8, 1])

print (ll)
new_list = partition(ll.head, 5)
print (new_list.as_list())
