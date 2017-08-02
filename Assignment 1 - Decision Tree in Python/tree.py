class BinaryTree():

    def __init__(self,attr):
      self.left = None
      self.right = None
      self.attr = attr
      #self.pos = pos
      #self.neg = neg

    def getLeftChild(self):
        return self.left
    def getRightChild(self):
        return self.right
    def setNodeValue(self,value):
        self.attr = value
    def getNodeValue(self):
        return self.attr

    def insertRight(self,newNode):
        if self.right == None:
            self.right = BinaryTree(newNode)
        else:
            tree = BinaryTree(newNode)
            tree.right = self.right
            self.right = tree
        
    def insertLeft(self,newNode):
        if self.left == None:
            self.left = BinaryTree(newNode)
        else:
            tree = BinaryTree(newNode)
            self.left = tree
            tree.left = self.left

def printTree(tree):
        if tree != None:
            printTree(tree.getLeftChild())
            print(tree.getNodeValue())
            printTree(tree.getRightChild())