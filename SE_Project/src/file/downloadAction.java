package file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/downloadAction")
public class downloadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName=request.getParameter("file");
		String directory=this.getServletContext().getRealPath("/upload/");
		File file=new File(directory+"/"+fileName);
		
		String mimeType=getServletContext().getMimeType(file.toString());
		if(mimeType==null) {
			//응답해야할 데이터가 파일이라는 것을 알려줌
			response.setContentType("application/octet-stream");
		}
		String downloadName=null;
		if(request.getHeader("user-agent").indexOf("MSIE")==-1) {
			downloadName=new String(fileName.getBytes("UTF-8"),"8859_1");
		}else {
			downloadName=new String(fileName.getBytes("EUC-KR"),"8859_1");
		}
		
		response.setHeader("Content-Disposition", "attachment;filename=\""
						+downloadName+"\";");
		
		FileInputStream fileinputstream=new FileInputStream(file);
		ServletOutputStream servletoutputstream=response.getOutputStream();
	
		byte b[]=new byte[1024];//1024바이트 만큼 쪼개서 보냄
		int data=0;
		while((data=(fileinputstream.read(b,0,b.length)))!=-1) {
			servletoutputstream.write(b,0,data);
		}
		servletoutputstream.flush();
		servletoutputstream.close();
		fileinputstream.close();
	}

	
}
