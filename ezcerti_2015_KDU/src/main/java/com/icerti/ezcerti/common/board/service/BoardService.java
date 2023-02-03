package com.icerti.ezcerti.common.board.service;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Board;
import com.icerti.ezcerti.domain.BoardFile;
import com.icerti.ezcerti.domain.Comment;
import com.icerti.ezcerti.util.PageBean;

public interface BoardService {
	
	PageBean<Board> getBoardList(Map<String, Object> map);
	Collection<Comment> getCommentList(Map<String, Object> map);
	Collection<BoardFile> getBoardFileList(Map<String, Object> map);
	Map<String, Object> getBoardView(Map<String, Object> map);
	
	void updateBoardInfo(Board board);
	void deleteBoardInfo(Board board);
	void deleteCommentInfo(Board board);
	void insertBoardInfo(Board board);
	void insertCommentInfo(Comment cmmt);
	
	void insertBoardFileInfo(BoardFile boardFile);
	void deleteBoardFileInfo(BoardFile boardFile);

	String selectBoardNo();

}
