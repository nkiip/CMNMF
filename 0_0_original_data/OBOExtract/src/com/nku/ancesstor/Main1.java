package com.nku.ancesstor;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;


/**
 * 
 * 从MP_OBO文件中提取节点以及父亲节点信息
 * 输入：原始的OBO文件
 * 输出：mpo_term：parent_term
 *
 */
public class Main1 {
	public static int TERM_START = 1;
	public static int FIELDS_OF_TERM = 2;
	public static int TERM_END = 3;
	public static int NULL = -1;
	
	public static void main(String[] args) throws IOException{

		String fnIn = "input/MPheno_OBO.ontology.txt";
		BufferedReader br = new BufferedReader(new FileReader(new File(fnIn)));
		String fnOut = "input/mouse_po.txt";
		BufferedWriter bw = new BufferedWriter(new FileWriter(new File(fnOut)));
		String line = "";
		String CurrMPId = "";
		String Ancestors = ""; 
	
		while (line != null) {
			line = br.readLine();
			if (line == null){
				continue;
			}
			if (line.equals("")){
				continue;
			}
			line = line.trim();
			System.out.println(line.substring(0, 3) + " " + line.substring(0, 5));
			if (line.substring(0, 3).equals("id:")){
				CurrMPId = line.substring(4);
			}

			if (line.substring(0, 5).equals("is_a:")){
				String temp = line.substring(6);
				int endIndex = temp.indexOf("!");
				Ancestors = temp.substring(0, endIndex - 1);
				bw.write(CurrMPId + " : " + Ancestors + "\r\n");
			}
		}
		bw.close();
		br.close();
	}
}
