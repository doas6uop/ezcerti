package com.icerti.ezcerti.common.board.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Board;
import com.icerti.ezcerti.domain.BoardFile;
import com.icerti.ezcerti.domain.Comment;

public interface BoardMapper {

	int getBoardListCount(Map<String, Object> map);
	Collection<Board> getBoardList(Map<String, Object> map);
	Collection<Comment> getCommentList(Map<String, Object> map);
	Collection<BoardFile> getBoardFileList(Map<String, Object> map);
	Collection<BoardFile> getBoardFileList(BoardFile boardFile);
	Board getBoardView(Map<String, Object> map);
	
	void updateBoardInfo(Board board);
	void deleteBoardInfo(Board board);
	void deleteCommentInfo(Board board);
	void insertBoardInfo(Board board);
	void insertCommentInfo(Comment cmmt);
	
	void insertBoardFileInfo(BoardFile boardFile);
	void deleteBoardFileInfo(BoardFile boardFile);
	
	String selectBoardNo();
}
