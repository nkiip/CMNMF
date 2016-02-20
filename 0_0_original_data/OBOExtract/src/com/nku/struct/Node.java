package com.nku.struct;

 
public class Node {
	

	//属于30类中的哪一类
	private String ancesstor;
	private MP_Node mp;
	private String parent_ids;
	
	public Node()
	{
		
	}

	public Node(MP_Node mp, String parent_ids) {
		this.mp = mp;
		this.parent_ids = parent_ids;

	}

	public String getAncesstor() {
		return ancesstor;
	}

	public void setAncesstor(String ancesstor) {
		this.ancesstor = ancesstor;
	}


	public MP_Node getMp() {
		return mp;
	}
	public void setMp(MP_Node mp) {
		this.mp = mp;
	}
	public String getParent_ids() {
		return parent_ids;
	}
	public void setParent_ids(String parent_ids) {
		this.parent_ids = parent_ids;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Node other = (Node) obj;
		if (mp == null) {
			if (other.mp != null)
				return false;
		} else if (!mp.Id.equals(other.mp.Id))
			return false;
		return true;
	}
	
	

	
}
