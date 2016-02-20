package com.nku.treepath;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Stack;

import com.nku.struct.MP_Node;
import com.nku.struct.Node;
import com.nku.struct.TreeNode;


public class OBOExtrator {


	public static void readNodes(String node_file,ArrayList<Node> list)
	{
		BufferedReader in=null;
		try {
			in = new BufferedReader(new FileReader(new File(node_file)));

			String line="";
			while(null!=(line=in.readLine()))
			{

				MP_Node mp =new MP_Node(line.substring(3, 10), line.substring(16));
				Node n = new Node(mp,mp.Parent);
				list.add(n);
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		finally
		{
			try {
				in.close();

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static boolean bulidTree(ArrayList<Node> list,ArrayList<TreeNode> trees)
	{
		ArrayList<Node> used = new ArrayList<Node>();
		//第一步先将所有根节点放到树林中
		for (Node node : list)
		{
			if(node.getParent_ids()==null)
			{
				TreeNode tn=new TreeNode();
				tn.setRoot(node);
				trees.add(tn);
				used.add(node);
			}
		}
		//将已经添加到树林中的节点删掉
		list.removeAll(used);
		used.removeAll(used);

		while(list.size()>0)
		{
			System.out.println("剩余节点数："+list.size());
			for (Node n : list)
			{
				for (TreeNode t : trees)
				{
					String temp=n.getParent_ids();
					if(t.addNode(n, temp))
					{
						used.add(n);
					}
				}
			}
			list.removeAll(used);
			used.removeAll(used);
		}
		return true;
	}
	
	
	public static Stack<Node> stack = new Stack<Node>();
	public static void callPrint(ArrayList<TreeNode>  trees,String ancesstor,String output)throws IOException
	{
		BufferedWriter writer = new BufferedWriter(new FileWriter(new File(output)));
		stack.clear();
		stack.push(trees.get(0).getRoot());
		printTree(trees.get(0),writer);
		
		writer.close();
		System.out.println("finished");
	}
	public static void printTree(TreeNode parent,BufferedWriter out)throws IOException
	{
		int len = parent.getChilds().size();
		for (int i=0;i<len;i++)
		{
			TreeNode childs= parent.getChilds().get(i);
			stack.push(childs.getRoot());
			if(childs.getChilds()!=null)
			{
				printTree(childs, out);
			}
			else
			{
				printStack(stack,out);
				stack.pop();
			}
		}
		//没有孩子了。则把parent也出栈
		stack.pop();
	}
	
	public static void printStack(Stack<Node> stack,BufferedWriter out) throws IOException
	{
		for (Node node : stack) {
			out.write(node.getMp().Id+"\t");
		}
		out.write("\r\n");
	}
}
