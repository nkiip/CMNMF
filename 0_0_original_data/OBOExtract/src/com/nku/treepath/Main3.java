package com.nku.treepath;

import java.io.IOException;
import java.util.ArrayList;

import com.nku.struct.MP_Node;
import com.nku.struct.Node;
import com.nku.struct.TreeNode;


public class Main3 {

	public static void main(String[] args) throws IOException
	{

		
		ArrayList<Node> list = new ArrayList<Node>();
		
		
	
//		读取MPO_parent 文件
		OBOExtrator.readNodes("input/mouse_po.txt", list);

//		将所有的根节点全都放到trees中去
		ArrayList<TreeNode> tree = new ArrayList<TreeNode>();
		
		//将根节点放到树种
		MP_Node mpo = new MP_Node("0000001",null);
		Node node = new Node(mpo, null);
		TreeNode treeNode = new TreeNode();
		treeNode.setRoot(node);
		tree.add(treeNode);
		
		if(OBOExtrator.bulidTree(list, tree))
		{
			System.out.println("构建完成");
		};
	
		OBOExtrator.callPrint(tree, null,"output/treepath/mouse_mpo_tree.txt");	
	}
}
