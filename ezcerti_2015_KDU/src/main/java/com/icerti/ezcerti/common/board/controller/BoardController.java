package com.icerti.ezcerti.common.board.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icerti.ezcerti.common.board.service.BoardService;
import com.icerti.ezcerti.domain.Board;
import com.icerti.ezcerti.domain.BoardFile;
import com.icerti.ezcerti.domain.Comment;
import com.icerti.ezcerti.domain.UserInfo;
import com.icerti.ezcerti.domain.Admin;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.util.FileUtil;

@Controller
public class BoardController {

	@Inject private FileSystemResource fileResource;

	@Autowired
	private BoardService boardService;

	@RequestMapping(value = "comm/board/board_list")
	public String boardList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
								@RequestParam(value="board_type", defaultValue="NOTICE") String board_type,
								@RequestParam(value="board_subtype", defaultValue="") String board_subtype,
								@RequestParam(value="searchItem", defaultValue="") String searchItem, 
								@RequestParam(value="searchValue", defaultValue="") String searchValue, 
								Model model, HttpSession session){
			
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(board_type == null) board_type = "NOTICE";
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
		
		// 공지사항 처음 접속시 기본값 board_subtype = "all"
		if(board_type.equals("NOTICE")){
			
			if(board_subtype == "" || board_subtype.length() <= 0) {
				board_subtype = "all";
			}
		}
		
		map.put("board_type", board_type);
		map.put("board_subtype", board_subtype);
		
		map.put("searchItem", searchItem);
		map.put("searchValue", searchValue);
		map.put("currentPage", currentPage);

	    model.addAttribute("cPage", currentPage);
	    model.addAttribute("board_type", map.get("board_type").toString());
		model.addAttribute("board_subtype", map.get("board_subtype").toString());
		model.addAttribute("user_type", session.getAttribute("USER_TYPE").toString());
		model.addAttribute(boardService.getBoardList(map));
		
		return "common/board/board_list";
	}
	
	@RequestMapping(value = "comm/board/board_view")
	public String boardInfoView(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
									@RequestParam(value="board_type", defaultValue="NOTICE") String board_type,
									@RequestParam(value="board_subtype", defaultValue="") String board_subtype,
									@RequestParam(value="searchItem", defaultValue="") String searchItem, 
									@RequestParam(value="searchValue", defaultValue="") String searchValue,
									String board_no, 
									Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//System.out.println("currentPage:["+currentPage+"],board_type:["+board_type+"],searchItem:["+searchItem+"],searchValue:["+searchValue+"]");
		//System.out.println("board_no:["+board_no+"]");
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
		
		map.put("board_type", board_type);
		map.put("board_subtype", board_subtype);
		map.put("board_no", board_no);
		
		map.put("searchItem", searchItem);
		map.put("searchValue", searchValue);
		map.put("currentPage", currentPage); 
		
		map = boardService.getBoardView(map);

		UserInfo userInfo = getUserInfo(session);

		model.addAttribute("board_type", map.get("board_type").toString());
		model.addAttribute("board_subtype", map.get("board_subtype").toString());
		model.addAttribute("user_no", userInfo.getUser_no());
		model.addAttribute("user_type", session.getAttribute("USER_TYPE").toString());
		model.addAttribute("board", map.get("board"));
				
		return "common/board/board_view";
	}
	
	@RequestMapping(value = "comm/board/board_form")
	public String boardInfoForm(Board board, Model model, HttpSession session){
		
		model.addAttribute("user_type", session.getAttribute("USER_TYPE").toString());
		model.addAttribute("board_type", board.getBoard_type());
		model.addAttribute("board_subtype", board.getBoard_subtype());
		model.addAttribute("board", board);
		
		return "common/board/board_form";
	}
	
	@RequestMapping(value = "comm/board/board_form_submit")
	public String boardInfoFormSubmit(MultipartHttpServletRequest request, 
										Board board, Model model, HttpSession session){

		String msg = "";
		//String boardNo = "";
		boolean bModEnable = false;
		boolean bFileProc = true;

		//System.out.println("board:["+board.getBoard_type()+"],title:["+board.getTitle()+"],contents:["+board.getContents()+"]");

		// 권한 체크 //////
		bModEnable = getAuthCheck(board.getBoard_type(), session);
		///////////////////
		
		if(bModEnable){
			try {
				
				// 신규 번호 조회 /////
				board.setBoard_no(boardService.selectBoardNo());
				///////////////////////
				
				// 파일 업로드 처리 ///
				bFileProc = uploadFileProc(request, board);
				///////////////////////
				
				if(bFileProc) {
			        // 게시물 정보 등록 /////
					UserInfo userInfo = getUserInfo(session);
					
					board.setUniv_cd(session.getAttribute("UNIV_CD").toString());
					board.setBoard_type(board.getBoard_type());
					board.setBoard_subtype(board.getBoard_subtype());
					board.setReg_user_no(userInfo.getUser_no());
					board.setReg_user_name(userInfo.getUser_name());

					boardService.insertBoardInfo(board);
			        /////////////////////////

					msg="정상 처리되었습니다.";
				} else {
					msg="파일첨부 시 오류가 발생했습니다.";
				}
			} catch(Exception e){
				msg="오류가 발생했습니다.";
				e.printStackTrace();
			}			
		} else {
			msg = "등록권한이 없습니다.";
		}
			
		model.addAttribute("message", msg);
		return "msg";
	}
	
	@RequestMapping(value = "comm/board/board_modify_view")
	public String boardInfoModifyView(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
										@RequestParam(value="board_type", defaultValue="NOTICE") String board_type,
										@RequestParam(value="board_subtype", defaultValue="") String board_subtype,
										@RequestParam(value="searchItem", defaultValue="") String searchItem, 
										@RequestParam(value="searchValue", defaultValue="") String searchValue,			
										String board_no, 
										Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
		
		map.put("board_type", board_type);
		map.put("board_subtype", board_subtype);
		map.put("board_no", board_no);
		
		map.put("searchItem", searchItem);
		map.put("searchValue", searchValue);
		map.put("currentPage", currentPage);
		
		map = boardService.getBoardView(map);
		
		UserInfo userInfo = getUserInfo(session);
		
		model.addAttribute("board", map.get("board"));
		model.addAttribute("board_subtype", map.get("board_subtype").toString());
		model.addAttribute("user_no", userInfo.getUser_no());
		model.addAttribute("user_type", session.getAttribute("USER_TYPE").toString());
		
		return "common/board/board_modify_view";
	}
	
	@RequestMapping(value = "comm/board/board_modify")
	public String boardInfoModify(MultipartHttpServletRequest request,
									Board board, Model model, HttpSession session){
	  
		String msg = "";
		boolean bModEnable = false;
		boolean bFileProc = true;
	  
		// 권한 체크 //////
		bModEnable = getAuthCheck(board.getBoard_type(), session);
		///////////////////
	  
		if(bModEnable) {
			UserInfo userInfo = getUserInfo(session);
		  
			//System.out.println("user_info:["+userInfo.getUser_no()+"]["+userInfo.getUser_name()+"]");
		  
			board.setUniv_cd(session.getAttribute("UNIV_CD").toString());
			board.setMod_user_no(userInfo.getUser_no());
			board.setMod_user_name(userInfo.getUser_name());
		  
			try {
				// 파일 업로드 처리 ///
				bFileProc = uploadFileProc(request, board);
				///////////////////////

				if(bFileProc) {
					boardService.updateBoardInfo(board);
					
					msg="정상 처리되었습니다.";
				} else {
					msg="파일첨부 시 오류가 발생했습니다.";
				}
			} catch(Exception e){
				msg="오류가 발생했습니다.";
				e.printStackTrace();
			}
		} else {
			msg = "수정권한이 없습니다.";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	@RequestMapping(value = "comm/board/board_delete")
	public String boardInfoDelete(Board board, Model model, HttpSession session){
	  
		String msg = "";
		boolean bModEnable = false;
		
		// 권한 체크 //////
		bModEnable = getAuthCheck(board.getBoard_type(), session);
		///////////////////
		
		if(bModEnable) {
			board.setUniv_cd(session.getAttribute("UNIV_CD").toString());
	    
			try {
				boardService.deleteBoardInfo(board);
				
				msg="정상 처리되었습니다.";
			}catch(Exception e){
				msg="오류가 발생했습니다.";
				e.printStackTrace();
			}
		} else {
			msg = "권한이 없습니다.";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	@RequestMapping(value = "comm/board/board_cmmt_insert")
	public String boardCommentInsert(Board board, Model model, HttpSession session){

		String msg = "";
		boolean bModEnable = false;

		//System.out.println("board:["+board.getBoard_type()+"],title:["+board.getTitle()+"],contents:["+board.getContents()+"]");
		//System.out.println("board_no:["+board.getBoard_no()+"]");

		// 권한 체크 //////
		bModEnable = getAuthCheck(board.getBoard_type(), session);
		///////////////////
		
		if(bModEnable){
			try {
				UserInfo userInfo = getUserInfo(session);
				
				Comment cmmt = new Comment();
				
				cmmt.setBoard_no(board.getBoard_no());
				cmmt.setCmmt(board.getCmmt());
				cmmt.setReg_user_no(userInfo.getUser_no());
				cmmt.setReg_user_name(userInfo.getUser_name());
				
				boardService.insertCommentInfo(cmmt);
				
				msg="정상 처리되었습니다.";
			} catch(Exception e){
				msg="오류가 발생했습니다.";
				e.printStackTrace();
			}			
		} else {
			msg = "등록권한이 없습니다.";
		}
			
		model.addAttribute("message", msg);
		return "msg";
	}	
	
	@RequestMapping(value = "comm/board/board_cmmt_delete")
	public String boardCommentDelete(Board board, Model model, HttpSession session){
	  
		String msg = "";
		boolean bModEnable = false;
		
		// 권한 체크 //////
		bModEnable = getAuthCheck(board.getBoard_type(), session);
		///////////////////
		
		if(bModEnable) {
			board.setUniv_cd(session.getAttribute("UNIV_CD").toString());
	    
			try {
				boardService.deleteCommentInfo(board);
				
				msg="정상 처리되었습니다.";
			}catch(Exception e){
				msg="오류가 발생했습니다.";
				e.printStackTrace();
			}
		} else {
			msg = "권한이 없습니다.";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	@RequestMapping(value = "comm/board/board_file_delete")
	public String boardFileInfoDelete(@RequestParam(value="file_no", defaultValue="") String file_no,
										Board board, Model model, HttpSession session){
	  
		String msg = "";
		boolean bModEnable = false;
		
		// 권한 체크 //////
		bModEnable = getAuthCheck(board.getBoard_type(), session);
		///////////////////
		
		if(bModEnable) {
			BoardFile boardFile = new BoardFile();
	    
			try {
				boardFile.setBoard_no(board.getBoard_no());
				boardFile.setFile_no(file_no);
				
				boardService.deleteBoardFileInfo(boardFile);
				
				msg="정상 처리되었습니다.";
			}catch(Exception e){
				msg="오류가 발생했습니다.";
				e.printStackTrace();
			}
		} else {
			msg = "권한이 없습니다.";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	@RequestMapping(value="/comm/board/board_file_download")
	public void downloadFile(HttpServletRequest request, HttpServletResponse response, 
							@RequestParam(value = "file_no") String file_no,
							Board board, Model model, HttpSession session) throws Exception{

		// 파일 조회 ///////////
		Map<String, Object> map = new HashMap<String, Object>();
		
		//System.out.println("file_no:["+file_no+"]");
		
		map.put("file_no", file_no);
		
		List<BoardFile> boardFiles = (List<BoardFile>)boardService.getBoardFileList(map);
		BoardFile boardFile = null;
		File downFile = null;
		
		if(boardFiles != null && boardFiles.size() > 0) {
			boardFile = (BoardFile)boardFiles.get(0);
			downFile = new File(boardFile.getFile_path() + boardFile.getSaved_file_name());
			
			if(downFile.isFile() && downFile.exists()) {
		        //String root_path = session.getServletContext().getRealPath(""); // 웹서비스 root 경로
		        
				//System.out.println("root_path:["+root_path+"]");
		        
				//String filePath = root_path+ boardFile.getFile_path();
				
				//System.out.println("filePath:["+boardFile.getFile_path()+"]");
				//System.out.println("getSaved_file_name:["+boardFile.getSaved_file_name()+"]");
				
				FileUtil.download(request, response, boardFile.getFile_path() + boardFile.getSaved_file_name(), boardFile.getSaved_file_name());
			}
		}
		////////////////////////
		
	}
	
	public UserInfo getUserInfo(HttpSession session) {
		
		String user_type = session.getAttribute("USER_TYPE").toString();
		UserInfo userInfo = new UserInfo();
		
		if(user_type.equals("[ROLE_SYSTEM]") || user_type.equals("[ROLE_ADMIN]")) {
			Admin admin = (Admin)session.getAttribute("ADMIN_INFO");
			
			userInfo.setUser_no(admin.getAdmin_no());
			userInfo.setUser_name(admin.getAdmin_name());
		} else if(user_type.equals("[ROLE_PROF]")) {
			Prof prof = (Prof)session.getAttribute("PROF_INFO");
			
			userInfo.setUser_no(prof.getProf_no());
			userInfo.setUser_name(prof.getProf_name());
		} else if(user_type.equals("[ROLE_STUDENT]")) {
			Student student = (Student)session.getAttribute("STUDENT_INFO");
			
			userInfo.setUser_no(student.getStudent_no());
			userInfo.setUser_name(student.getStudent_name());
		}
	
		//System.out.println("user_type:["+user_type+"],user_no:["+userInfo.getUser_no()+"]["+userInfo.getUser_name()+"]");		
		
		return userInfo;
	}
	
	public boolean getAuthCheck(String board_type, HttpSession session) {
		
		String user_type = session.getAttribute("USER_TYPE").toString();
		boolean bAuth = false;
		
		if(board_type.equals("NOTICE")) {
			if(user_type.equals("[ROLE_SYSTEM]") || user_type.equals("[ROLE_ADMIN]") || user_type.equals("[ROLE_PROF]")){
				bAuth = true;
			}
		} else {
			bAuth = true;
		}
		
		//System.out.println("board_type:["+board_type+"],bAuth:["+bAuth+"]");		
	
		return bAuth;
	}	
	
	public boolean uploadFileProc(MultipartHttpServletRequest request, Board board){
		boolean bResult = true;
		
		// 업로드 폴더 확인 ///
		File dir = new File(fileResource.getPath());
			if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		///////////////////////
		
		//System.out.println("fileResource.toString():["+fileResource.getPath()+"]");
		
		List<MultipartFile> files = request.getFiles("uploadFile");
		
		MultipartFile uploadFile = null;
		BoardFile boardFile = null;

		try {
			if(files != null && files.size() > 0) {
				//System.out.println("files.size():["+files.size()+"]");
				
				String filepath = fileResource.getPath();
				String orgFileName = "";
				String savedFilename = "";
				String fileExt = "";
				String fileName = "";
				
				for(int i = 0; i < files.size(); i++) {
					// 파일 업로드 /////////
					uploadFile = (MultipartFile)files.get(i);
					
					//System.out.println("["+i+"]uploadFile:["+(uploadFile != null)+"]["+uploadFile.getSize()+"]");
				
					if(uploadFile.getSize() <= 0) {
						//System.out.println("["+i+"]continue");
						continue;
					}

					if(uploadFile.getSize() >= 1000000) {
						//System.out.println("["+i+"]size error");
						bResult = false;
						break;
					}
					
					orgFileName = uploadFile.getOriginalFilename();
					//System.out.println("orgFileName:["+orgFileName+"]");
					fileExt = orgFileName.substring(orgFileName.lastIndexOf(".") + 1, orgFileName.length());
					//System.out.println("fileExt:["+fileExt+"]");
					fileName = orgFileName.substring(0, orgFileName.indexOf("."));
					//System.out.println("fileName:["+fileName+"]");
					savedFilename = fileName + "_" + System.currentTimeMillis() + "." + fileExt; 
					
					//System.out.println("savedFilename:["+savedFilename+"]");
					
					File saveFile = new File(filepath + savedFilename);
					
					uploadFile.transferTo(saveFile);
					////////////////////////
					
					// 파일 정보 등록 //////
					boardFile = new BoardFile();
					
					boardFile.setBoard_no(board.getBoard_no());
					boardFile.setOrg_file_name(orgFileName);
					boardFile.setSaved_file_name(savedFilename);
					boardFile.setFile_path(filepath);
					
					boardService.insertBoardFileInfo(boardFile);
					////////////////////////		        		
				}
			}
		} catch(Exception e){
			bResult = false;
			e.printStackTrace();
		}		
		
		return bResult;
	}
		
}
