package com.Ex.dto;

public class MemberVO {
	private int num;
	private String title;
	private String writer_name;
	private String first_date;
	private String update_date;
	private String type;
	private String content;
	private String filename;
	private String fileupname;

	// get num
	public int getNum() {
		return num;
	}

	// set num
	public void setNum(int num) {
		this.num = num;
	}

	// get title
	public String getTitle() {
		return title;
	}

	// set title
	public void setTitle(String title) {
		this.title = title;
	}

	// get writer_name
	public String getWriter_name() {
		return writer_name;
	}

	// set writer_name
	public void setWriter_name(String writer_name) {
		this.writer_name = writer_name;
	}

	// get first_date
	public String getFirst_date() {
		return first_date;
	}

	// set first_date
	public void setFirst_date(String first_date) {
		this.first_date = first_date;
	}

	// get update_date
	public String getUpdate_date() {
		return update_date;
	}

	// set update_date
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

	// get type 분류
	public String getType() {
		return type;
	}

	// set type 분류
	public void setType(String type) {
		this.type = type;
	}

	// get content
	public String getContent() {
		return content;
	}

	// set content
	public void setContent(String content) {
		this.content = content;
	}

	// get filename
	public String getFilename() {
		return filename;
	}

	// set filename
	public void setFilename(String filename) {
		this.filename = filename;
	}

	// get fileupname
	public String getFileupname() {
		return fileupname;
	}

	// set fileupname
	public void setFileupname(String fileupname) {
		this.fileupname = fileupname;
	}
}
