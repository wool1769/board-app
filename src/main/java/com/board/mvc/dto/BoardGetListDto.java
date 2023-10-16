package com.board.mvc.dto;

import java.util.List;

import com.board.mvc.domain.Board;

import lombok.Data;

@Data
public class BoardGetListDto {
	
	private int totalContent;
	
	private List<Board> getlist;
	
}