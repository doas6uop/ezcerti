package com.icerti.ezcerti.util;

import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

public class FileUtil {

	private static final int BUFFER_SIZE = 8192;
	private static final String CHARSET = "UTF-8";

    /**
     * Gets file info.
     *
     * @param map the map
     * @param realPath the real path
     * @param savePath the save path
     * @param rename the rename
     * @return the file info
     * @throws IllegalStateException the illegal state exception
     * @throws IllegalStateException the illegal state exception
     */
    public static List<Map<String,Object>> getFileInfo(MultiValueMap<String, MultipartFile> map,String realPath, String savePath, boolean rename) throws IllegalStateException, IOException {

        Date time = Calendar.getInstance().getTime();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String formatDate = formatter.format(time);

        Map<String, Object> returnMap = new HashMap<String, Object>();
        List<Map<String,Object>> fileList = new ArrayList<Map<String, Object>>();

        Iterator<String> iterator = map.keySet().iterator();

        savePath = savePath + File.separator + formatDate.substring(0, 4) + File.separator + formatDate.substring(4, 8) + File.separator;

        String realFilePath = savePath;
        String logicalPath = savePath;
        if(File.separator.equalsIgnoreCase("\\")){
            realFilePath = realPath+savePath;
            logicalPath = savePath.replaceAll("\\\\", "/");
        }

        //System.err.println("realFilePath : "+realFilePath);
        //System.err.println("logicalPath : "+logicalPath);

        while(iterator.hasNext()){

            Map<String, Object> fileMap = new HashMap<String, Object>();

            String key = iterator.next();
            LinkedList<MultipartFile> df = (LinkedList<MultipartFile>) map.get(key);
            CommonsMultipartFile fileInfo = (CommonsMultipartFile) df.getFirst();

            if(fileInfo.getSize()>0){

                fileMap.put("key",key);

                int idx = fileInfo.getOriginalFilename().lastIndexOf(".");

                String extName = "";
                if( idx != -1 ) {
                    extName = fileInfo.getOriginalFilename().substring( idx, fileInfo.getOriginalFilename().length() );
                }

                File fDir = new File(realFilePath);
                if(!fDir.exists()){
                    fDir.mkdirs();
                }

                if(rename){
                    File file1 = new File(realFilePath + formatDate);
                    fileInfo.transferTo(file1);

                    fileMap.put("path", logicalPath + formatDate);
                    fileMap.put("name", fileInfo.getOriginalFilename());
                    fileMap.put("size", ""+fileInfo.getSize());
                    fileMap.put("create_file", realFilePath + formatDate);

                    String imageType = getFileType(file1);
                    int imageWidthSize = 0;
                    int imageHeightSize = 0;

                    if("JPEG".equalsIgnoreCase(imageType)
                            || "BMP".equalsIgnoreCase(imageType)
                            || "GIF".equalsIgnoreCase(imageType)
                            || "JPG".equalsIgnoreCase(imageType)
                            || "PNG".equalsIgnoreCase(imageType))
                    {
                        // Image Size
                        BufferedInputStream bufferedis = null;
                        FileInputStream fileis = null;
                        BufferedImage bufferedimg = null;

                        try {
                            fileis = new FileInputStream(file1);
                            bufferedis = new BufferedInputStream(fileis);
                            bufferedimg = ImageIO.read(bufferedis);

                            imageWidthSize = bufferedimg == null? 0 : bufferedimg.getWidth();
                            imageHeightSize = bufferedimg == null? 0 : bufferedimg.getHeight();

                            fileMap.put("width", imageWidthSize+"");
                            fileMap.put("height", imageHeightSize+"");

                        } catch (Exception e) {
                            e.printStackTrace();
                        }finally{
                            if (fileis != null) try { fileis.close(); } catch (Exception e){}
                            if (bufferedis != null) try { bufferedis.close(); } catch (Exception e){}
                        }
                    }
                }else{

                    File file1 = new File(realFilePath+formatDate+fileInfo.getName()+extName);
                    fileInfo.transferTo(file1);

                    fileMap.put("path", logicalPath + formatDate + fileInfo.getName() + extName);
                    fileMap.put("name", fileInfo.getOriginalFilename());
                    fileMap.put("size", ""+fileInfo.getSize());
                    fileMap.put("create_file", realFilePath+formatDate+fileInfo.getName()+extName);

                    String imageType = getFileType(file1);
                    int imageWidthSize = 0;
                    int imageHeightSize = 0;

                    if("JPEG".equalsIgnoreCase(imageType)
                            || "BMP".equalsIgnoreCase(imageType)
                            || "GIF".equalsIgnoreCase(imageType)
                            || "JPG".equalsIgnoreCase(imageType)
                            || "PNG".equalsIgnoreCase(imageType))
                    {
                        // Image Size
                        BufferedInputStream bufferedis = null;
                        FileInputStream fileis = null;
                        BufferedImage bufferedimg = null;

                        try {
                            fileis = new FileInputStream(file1);
                            bufferedis = new BufferedInputStream(fileis);
                            bufferedimg = ImageIO.read(bufferedis);

                            imageWidthSize = bufferedimg == null? 0 : bufferedimg.getWidth();
                            imageHeightSize = bufferedimg == null? 0 : bufferedimg.getHeight();

                            fileMap.put("width", imageWidthSize+"");
                            fileMap.put("height", imageHeightSize+"");

                        } catch (Exception e) {
                            e.printStackTrace();
                        }finally{
                            if (fileis != null) try { fileis.close(); } catch (Exception e){}
                            if (bufferedis != null) try { bufferedis.close(); } catch (Exception e){}
                        }
                    }

                }

                // for end
                fileList.add(fileMap);
            }
        }

        return fileList;
    }


    /**
     * Gets file info.
     *
     * @param map the map
     * @param filePath the file path
     * @param savePath the save path
     * @return the file info
     * @throws IllegalStateException the illegal state exception
     * @throws IOException the iO exception
     */
    public static List<Map<String,Object>> getFileInfo(MultiValueMap<String, MultipartFile> map,String filePath, String savePath) throws IllegalStateException, IOException{
        return getFileInfo(map,filePath,savePath,false);
    }
    
    /**
     * @param request
     * @param response
     * @param realPath
     * @param fileName
     * @throws ServletException
     * @throws IOException
     */
    public static void download(HttpServletRequest request, HttpServletResponse response, String realPath , String fileName) throws ServletException, IOException {
		try {
			download(request, response, new File(realPath), fileName);
		} catch (Exception e) {}
	}

    
    /**
     * 파일 다운로드
     * 
     * @param request
     * @param response
     * @param file
     * @param fileName
     * @throws ServletException
     * @throws IOException
     */
    public static void download(HttpServletRequest request,
			HttpServletResponse response, File file, String fileName)
			throws ServletException, IOException {

		String mimetype = request.getSession().getServletContext().getMimeType(file.getName());

		if (file == null || !file.exists() || file.length() <= 0 || file.isDirectory()) {
			//System.out.println(file.getAbsolutePath());
			throw new IOException("파일 객체가 Null 혹은 존재하지 않거나 길이가 0, 혹은 파일이 아닌 디렉토리이다.");
		}

		InputStream is = null;

		try {
			is = new FileInputStream(file);
			download(request, response, is, fileName, file.length(), mimetype);
		} finally {
			try {
				is.close();
			} catch (Exception ex) {
			}
		}
	}
	
	/**
	 * 파일다운로드
	 * 
	 * @param request
	 * @param response
	 * @param is
	 * @param filename
	 * @param filesize
	 * @param mimetype
	 * @throws ServletException
	 * @throws IOException
	 */
	public static void download(HttpServletRequest request,
			HttpServletResponse response, InputStream is, String filename,
			long filesize, String mimetype) throws ServletException,
			IOException {
		String mime = mimetype;

		if (mimetype == null || mimetype.length() == 0) {
			mime = "application/octet-stream;";
		}

		byte[] buffer = new byte[BUFFER_SIZE];

		response.setContentType(mime + "; charset=" + CHARSET);

		// 아래 부분에서 euc-kr 을 utf-8 로 바꾸거나 URLEncoding을 안하거나 등의 테스트를
		// 해서 한글이 정상적으로 다운로드 되는 것으로 지정한다.
		String userAgent = request.getHeader("User-Agent");

		if (userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(filename, "UTF-8") + ";");
		} else if (userAgent.indexOf("MSIE") > -1) { // MS IE (보통은 6.x 이상 가정)
			filename=filename.replaceAll(" ","plmkijnhyrtfsdwerg578jh80jhrt56ghb");
			String filename2 = java.net.URLEncoder.encode(filename, "UTF-8");
			filename2=filename2.replaceAll("plmkijnhyrtfsdwerg578jh80jhrt56ghb"," ");
			response.setHeader("Content-Disposition", "attachment; filename=" + filename2 + ";");
		} else { // 모질라나 오페라
			response.setHeader("Content-Disposition", "attachment; filename=" + new String(filename.getBytes(CHARSET), "latin1") + ";");
		}

		// 파일 사이즈가 정확하지 않을때는 아예 지정하지 않는다.
		if (filesize > 0) {
			response.setHeader("Content-Length", "" + filesize);
		}

		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			fin = new BufferedInputStream(is);
			outs = new BufferedOutputStream(response.getOutputStream());
			int read = 0;

			while ((read = fin.read(buffer)) != -1) {
				outs.write(buffer, 0, read);
			}
		} finally {
			try {
				outs.close();
			} catch (Exception ex1) {
			}

			try {
				fin.close();
			} catch (Exception ex2) {

			}
		} // end of try/catch
	}

    /**
     * 파일 타입
     *
     * @param file the file
     * @return file type
     */
    protected static String getFileType (File file) {
        InputStream inputStream = null;
        byte[] buf = new byte[132];
        try {
            inputStream = new FileInputStream(file);
            inputStream.read(buf, 0, 132);
        } catch (IOException ioexception) {
            return "UNKNOWN";
        } finally {
            if (inputStream != null) try { inputStream.close(); } catch (Exception exception) {}
        }

        int b0 = buf[0] & 255;
        int b1 = buf[1] & 255;
        int b2 = buf[2] & 255;
        int b3 = buf[3] & 255;

        if (buf[128] == 68 && buf[129] == 73 && buf[130] == 67 && buf[131] == 77 && ((b0 == 73 && b1 == 73) || (b0 == 77 && b1 == 77)))
            return "TIFF_AND_DICOM";
        if (b0 == 73 && b1 == 73 && b2 == 42 && b3 == 0)
            return "TIFF";
        if (b0 == 77 && b1 == 77 && b2 == 0 && b3 == 42)
            return "TIFF";
        if (b0 == 255 && b1 == 216 && b2 == 255)
            return "JPEG";
        if (b0 == 71 && b1 == 73 && b2 == 70 && b3 == 56)
            return "GIF";
        if (buf[128] == 68 && buf[129] == 73 && buf[130] == 67 && buf[131] == 77)
            return "DICOM";
        if (b0 == 8 && b1 == 0 && b3 == 0)
            return "DICOM";
        if (b0 == 83 && b1 == 73 && b2 == 77 && b3 == 80)
            return "FITS";
        if (b0 == 80 && (b1 == 50 || b1 == 53) && (b2 == 10 || b2 == 13 || b2 == 32 || b2 == 9))
            return "PGM";
        if ( b0 == 66 && b1 == 77)
            return "BMP";
        if (b0 == 73 && b1 == 111)
            return "ROI";
        if (b0 >= 32 && b0 <= 126 && b1 >= 32 && b1 <= 126 && b2 >= 32 && b2 <= 126 && b3 >= 32 && b3 <= 126 && buf[8] >= 32 && buf[8] <= 126)
            return "TEXT";
        if (b0 == 137 && b1 == 80 && b2 == 78 && b3 == 71)
            return "PNG";

        return "UNKNOWN";
    }
}