# Given a linked list which might contain a loop,
# implement an algorithm that returns the node at the beginning of the loop (if one exists).

from LinkedList import Node, LinkedList

# Time: O(n), Space: O(n)
def loop_start(head):
    seen = set()

    curr = head

    while curr:
        if curr in seen:
            return curr
        seen.add(curr)
        curr = curr.next

    return None

# Time: O(n), Space: O(1)
def loop_start_two(head):
    slow = head.next

    if not slow.next:
        return None

    fast = slow.next

    loop_found = False

    while fast and fast.next:

        if slow == fast:
            loop_found = True
            break
        fast = fast.next.next 
        slow = slow.next

    if not loop_found:
        return None

    # Num nodes before loop = k
    # fast and slow are currently k nodes from start of the loop
    # Move slow to front of list, then move each in sync.
    # Where they meet is the start of the loop

    slow = head
    while slow != fast:
        slow = slow.next
        fast = fast.next

    return slow


# a => b => c => d => f => g => c (the same c)
non_loop = LinkedList.from_arr(['a', 'b', 'c', 'd', 'e', 'f', 'g']).head

# No loop
print("No loop")
print("Approach One")
print(loop_start(non_loop)) # None
print("Approach Two")
print(loop_start_two(non_loop)) # None

na = Node('a')
nb = Node('b')
nc = Node('c')
nd = Node('d')
ne = Node('e')
nf = Node('f')
ng = Node('g')
nh = Node('h')
ni = Node('i')
nj = Node('j')

head = na

na.next = nb
nb.next = nc
nc.next = nd
nd.next = ne
ne.next = nf
nf.next = ng
ng.next = nh
nh.next = ni
ni.next = nj

print("\nNo loop")
print("Approach One")
print(loop_start(head)) # None
print("Approach Two")
print(loop_start_two(head)) # None

nj.next = nc

print("\nLoop starting at <c>")
print("Approach One")
print(loop_start(head)) # <c>
print("Approach Two")
print(loop_start_two(head)) # <c>
