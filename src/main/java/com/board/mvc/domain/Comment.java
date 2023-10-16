package com.board.mvc.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Comment {
	private Integer commentId;
	private String content;
	private Integer boardId;
	private Integer cCommentId;
	private String memberId;
	private Date date;

}
