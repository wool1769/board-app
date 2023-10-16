package com.board.mvc.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Board {
	private Integer boardId;
	private String title;
	private String content;
	private Date date;
	private String memberId;
	private int views;
	
}