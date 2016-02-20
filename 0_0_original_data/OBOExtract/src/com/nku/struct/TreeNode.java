package com.nku.struct;

import java.util.ArrayList;
import java.util.HashSet;

public class TreeNode {

	private Node root;
	private ArrayList<TreeNode> childs;

//	返回叶节点
	public HashSet<Node> getleaves()
	{
		HashSet<Node> t_leaves = new HashSet<Node>();
		if(childs==null)
		{
			if(!t_leaves.contains(root))
			{
				t_leaves.add(root);
			}
		}
		else
		{
			for (TreeNode child : childs)
			{
				t_leaves.addAll(child.getleaves());
			}
		}
		return t_leaves;
	}
	//	返回这个树上的所有节点
	public ArrayList<Node> getNodes()
	{
		ArrayList<Node> t_nodes = new ArrayList<Node>();
		t_nodes.add(root);
		if(childs!=null)
		{
			for (TreeNode child : childs) {
				if(child!=null)
				{
					t_nodes.addAll(child.getNodes());
				}
			}
		}
		return t_nodes;
	}

	//这棵树的所有子节点的id
	public String getChild_ids(){
		StringBuilder str= new StringBuilder();
		str.append(root.getMp().Id).append("|");
		if(null!=childs)
		{
			for (TreeNode child : childs)
			{
				str.append(child.getChild_ids()).append("|");
			}
		}
		return str.substring(0, str.length()-1);
	}

	public Node getRoot() {
		return root;
	}
	public void setRoot(Node root) {
		this.root = root;
	}
	public ArrayList<TreeNode> getChilds() {
		return childs;
	}
	public void setChilds(ArrayList<TreeNode> childs) {
		this.childs = childs;
	}

	//id:该节点的父节点
	public boolean addNode(Node n,String id)
	{
		//如果这个节点的父节点在这棵树里
		if(getChild_ids().contains(id))
		{
			//如果当前树没有孩子，则这个节点是树的第一个孩子
			if(null==childs)
			{
				childs = new ArrayList<TreeNode>();
				TreeNode tr= new TreeNode();
				tr.setRoot(n);
				childs.add(tr);
				return true;
			}
			for (TreeNode tr : childs)
			{
				if(tr.addNode(n,id))
				{
					return true;
				}
			}
			TreeNode tr= new TreeNode();
			tr.setRoot(n);
			childs.add(tr);
			return true;
		}
		return false;
	}
	
	@Override
	public boolean equals(Object obj) {
		
		if(obj instanceof TreeNode)
		{
			TreeNode other = (TreeNode)obj;
			
			if(this.getRoot().getMp().Id.equals(other.getRoot().getMp().Id))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			return false;
		}
	}

}
