import LinkedList

my_list = LinkedList.LinkedList.from_arr(['a', 'b', 'c', 'd', 'e', 'f', 'g'])

mid_node = my_list.head.next.next


def delete_mid_node(node):
    curr = node
    while curr.next.next:
        curr.val = curr.next.val
        curr = curr.next

    curr.val = curr.next.val
    curr.next = None

print("Original List:")
print(my_list)

print(f'Deleting {mid_node}')

delete_mid_node(mid_node)

print("After delete:")
print(my_list)
