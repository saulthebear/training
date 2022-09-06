class Node:
    def __init__(self, val):
        self.val = val
        self.next = None

    def __str__(self):
        return f'[{self.val}]'
    
    def as_list(self):
        s = ''
        curr = self
        while curr:
            s += f'{curr} => '
            curr = curr.next
        s += 'None'
        return s

class LinkedList:
    def __init__(self):
        self.head = None

    def append(self, val):
        new = Node(val)
        if not self.head:
            self.head = new
        else:
            curr = self.head
            while (curr.next):
                curr = curr.next
            curr.next = new

    @staticmethod
    def from_arr(arr):
        l = LinkedList()

        for el in arr:
            l.append(el)

        return l

    def __str__(self):
        s = ''
        curr = self.head

        while curr:
            s += f'{curr} => '
            curr = curr.next
        s += 'None'
        return s 

