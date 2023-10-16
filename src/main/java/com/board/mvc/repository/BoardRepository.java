package com.board.mvc.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.board.mvc.domain.Board;
import com.board.mvc.dto.BoardQueryParams;

@Repository
public interface BoardRepository {
	
	void save(Board board);
	
	List<Board> getList(BoardQueryParams params);
	
	int totalContent(String searchSql);
	
	Board get(int boardId);
	
	//get 호출하기 전 조회수 
	void viewPlus(int boardId);
	
	void update(Board board);
	
	void delete(int boardId);
	

}
