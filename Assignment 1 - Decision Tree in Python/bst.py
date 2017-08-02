class Node:

      def __init__(self,attr,pos,neg): 

          self.attr = attr
          self.pos = pos
          self.neg = neg
          self.level = None
          self.left = None
          self.right= None
          
      def __str__(self):

          return str(self.attr) #return as string


class searchtree:

      def __init__(self): #constructor of class

          self.root = None
          self.count = 0

                  


      def create(self,attr,pos,neg):  #create binary search tree nodes

          if self.root == None:

             self.root = Node(attr,pos,neg)

          else:

             current = self.root

             while 1:

                 if val < current.info:

                   if current.left:
                      current = current.left
                   else:
                      current.left = Node(attr,pos,neg)
                      break;      

                 elif val > current.info:
                 
                    if current.right:
                       current = current.right
                    else:
                       current.right = Node(attr,pos,neg)
                       break;      

                 else:
                    break 

      def bft(self,node): #Breadth-First Traversal

'''          self.root.level = 0 
          queue = [self.root]
          out = []
          current_level = self.root.level

          while len(queue) > 0:
                 
             current_node = queue.pop(0)
 
             if current_node.level > current_level:
                current_level += 1
                out.append("\n")

             out.append(str(current_node.info) + " ")

             if current_node.left:

                current_node.left.level = current_level + 1
                queue.append(current_node.left)
                  

             if current_node.right:

                current_node.right.level = current_level + 1
                queue.append(current_node.right)
                      
                 
          print ("".join(out))'''
            
             if root == None :
                 return
             temp = root
             while len(level)>0:
                 


      def inorder(self,node):
            
           if node is not None:
              
              self.inorder(node.left)
              print (node.info)
              self.inorder(node.right)


      def preorder(self,node):
            
           if node is not None:
              
              print (node.info)
              self.preorder(node.left)
              self.preorder(node.right)


      def postorder(self,node):
            
           if node is not None:
              
              self.postorder(node.left)
              self.postorder(node.right)
              print (node.info)

                        
tree = searchtree()     
arr = [8,3,1,6,4,7,10,14,13]
for i in arr:
    tree.create(i)
print ('Breadth-First Traversal')
tree.bft()
print ('Inorder Traversal')
tree.inorder(tree.root) 
print ('Preorder Traversal')
tree.preorder(tree.root) 
print ('Postorder Traversal')
tree.postorder(tree.root)
