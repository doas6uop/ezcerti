package com.icerti.ezcerti.common.board.service;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.common.board.dao.BoardMapper;
import com.icerti.ezcerti.domain.Board;
import com.icerti.ezcerti.domain.BoardFile;
import com.icerti.ezcerti.domain.Comment;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;

@Transactional
@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper boardMapper = null;

	@Override
	public PageBean<Board> getBoardList(Map<String, Object> map) {
		PageBean<Board> pageBean = new PageBean<Board>();

		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = boardMapper.getBoardListCount(map);
				
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(boardMapper.getBoardList(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}

	@Override
	public Collection<Comment> getCommentList(Map<String, Object> map) {
		return boardMapper.getCommentList(map);
	}

	@Override
	public Collection<BoardFile> getBoardFileList(Map<String, Object> map) {
		return boardMapper.getBoardFileList(map);
	}
	
	@Override
	public Map<String, Object> getBoardView(Map<String, Object> map) {
		
		Board board = boardMapper.getBoardView(map);
		
		board.setCommentList(boardMapper.getCommentList(map));
		board.setBoardFileList(boardMapper.getBoardFileList(map));
		
		map.put("board", board);
		
		return map;
	}	

	@Override
	public void updateBoardInfo(Board board) {
		boardMapper.updateBoardInfo(board);
	}

	@Override
	public void deleteBoardInfo(Board board) {
		boardMapper.deleteBoardInfo(board);
		boardMapper.deleteCommentInfo(board);
		
		BoardFile boardFile = new BoardFile();
		boardFile.setBoard_no(board.getBoard_no());
		
		deleteBoardFileInfo(boardFile);		
	}

	@Override
	public void insertBoardInfo(Board board) {
		boardMapper.insertBoardInfo(board);
	}

	@Override
	public void insertCommentInfo(Comment cmmt) {
		boardMapper.insertCommentInfo(cmmt);
	}
	
	@Override
	public void deleteCommentInfo(Board board) {
		boardMapper.deleteCommentInfo(board);
	}

	@Override
	public void deleteBoardFileInfo(BoardFile boardFile) {
		
		List<BoardFile> boardFiles = (List<BoardFile>)boardMapper.getBoardFileList(boardFile);
		
		if(boardFiles != null && boardFiles.size() > 0) {
			for(int i = 0; i < boardFiles.size(); i++) {
				String targetFile = boardFiles.get(i).getFile_path() + boardFiles.get(i).getSaved_file_name();
				File delTargetFile = new File(targetFile);
				
				if(delTargetFile.exists()) {
					delTargetFile.delete();
				}
			}
		}
		
		boardMapper.deleteBoardFileInfo(boardFile);		
	}

	@Override
	public void insertBoardFileInfo(BoardFile boardFile) {
		boardMapper.insertBoardFileInfo(boardFile);
	}
	
	@Override
	public String selectBoardNo() {
		return boardMapper.selectBoardNo();
	}
	
}