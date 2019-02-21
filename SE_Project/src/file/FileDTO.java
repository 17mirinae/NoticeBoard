package file;
//File테이블 관련 DTO(Database Transfer Object)를 작성합니다.
public class FileDTO {
	String fileName;
	String fileRealName;
	String name;
	String title;
	String content;
	String date_month;
	String date_day;
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate_month() {
		return date_month;
	}
	public void setDate_month(String date_month) {
		this.date_month = date_month;
	}
	public String getDate_day() {
		return date_day;
	}
	public void setDate_day(String date_day) {
		this.date_day = date_day;
	}
	public FileDTO(String name, String title, String content, String fileName, String fileRealName,String date_month, String date_day) {
		super();
		this.fileName = fileName;
		this.fileRealName = fileRealName;
		this.name = name;
		this.title = title;
		this.content = content;
		this.date_month = date_month;
		this.date_day = date_day;
	}
	
}
