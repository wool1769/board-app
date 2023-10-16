package com.board.mvc.dto;

import lombok.Data;

@Data
public class BoardQueryParams {
	private int pageNum;
	private String search;
}
