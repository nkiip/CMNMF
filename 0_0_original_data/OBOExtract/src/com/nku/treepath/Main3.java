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
		
		
	
//		��ȡMPO_parent �ļ�
		OBOExtrator.readNodes("input/mouse_po.txt", list);

//		�����еĸ��ڵ�ȫ���ŵ�trees��ȥ
		ArrayList<TreeNode> tree = new ArrayList<TreeNode>();
		
		//�����ڵ�ŵ�����
		MP_Node mpo = new MP_Node("0000001",null);
		Node node = new Node(mpo, null);
		TreeNode treeNode = new TreeNode();
		treeNode.setRoot(node);
		tree.add(treeNode);
		
		if(OBOExtrator.bulidTree(list, tree))
		{
			System.out.println("�������");
		};
	
		OBOExtrator.callPrint(tree, null,"output/treepath/mouse_mpo_tree.txt");	
	}
}
