package com.nku.ancesstor;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;

import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;

import com.nku.struct.MP_Node;
/**
 * 
 * @author 
 *用于构建MPO的层次关系，通过该文件提取出了mpo的所有祖先节点。
 */
public class Main2 {
	public static int TERM_START = 1;
	public static int FIELDS_OF_TERM = 2;
	public static int TERM_END = 3;
	public static int NULL = -1;

	public static void main(String[] args)
	{
		ArrayList<MP_Node> alHierarchy = new ArrayList<MP_Node>(); 
		ArrayList<String> alMPO = new ArrayList<String>();
		
		try{
		String fnIn = "input/mouse_po.txt";
		BufferedReader br = new BufferedReader(new FileReader(new File(fnIn)));
		
		String line = "";
		while (line != null) {
			line = br.readLine();
			if (line == null){
				continue;
			}
			alHierarchy.add(new MP_Node(line.substring(3, 10), line.substring(16)));
		}
		br.close();
		
//		获取所有的mpo节点，放在alMPO中
		for ( int i = 0 ; i < alHierarchy.size() ; i ++ ){
			String MP_id = alHierarchy.get(i).Id;
			int flag = -1;
			for ( int j = 0 ; j < alMPO.size() ; j ++ ){
				if (alMPO.get(j).equals(MP_id)){
					flag = 1;
					break;
				}
			}
			if (flag == -1){
				alMPO.add(MP_id);
			}
		}
		
		String fnOut = "output/ancesstor/mouse_po_hierarchy.txt";
		BufferedWriter bw = new BufferedWriter(new FileWriter(new File(fnOut)));
		for ( int i = 0 ; i < alMPO.size() ; i ++ ){

			ArrayList<String> alAncestor = getAncestors(alMPO.get(i), alHierarchy);
			bw.write(alMPO.get(i) + "\t");
			for ( int j = 0 ; j < alAncestor.size(); j ++ ){
				bw.write( alAncestor.get(j) + "\t" );
			}
			for ( int j = alAncestor.size() ; j <= 40 ; j ++ ){
				bw.write( "0\t" );
			}
			bw.write("\r\n");
		}
		bw.close();
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public static ArrayList<String> getAncestors(String Id, ArrayList<MP_Node> alHierarchy){
		ArrayList<String> parents = new ArrayList<String>();
		for ( int i = 0 ; i < alHierarchy.size() ; i ++ ){
			MP_Node curr_is_a = alHierarchy.get(i);
			if ( curr_is_a.Id.equals(Id) )
			{
				if ( parents.contains(curr_is_a.Parent) == false )
				{
					parents.add(curr_is_a.Parent);
					ArrayList<String> grandfather = getAncestors(curr_is_a.Parent, alHierarchy);
					mergeArray(parents, grandfather);
				}
			}
		}
		return parents;
	}
	
	public static void mergeArray(ArrayList<String> dest , ArrayList<String> source){
		for ( int i = 0 ; i < source.size() ; i ++ ){
			if ( dest.contains(source.get(i)) == false ){
				dest.add(source.get(i));
			}
		}
	}
	
	
}
