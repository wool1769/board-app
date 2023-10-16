package com.board.mvc.domain;

import lombok.Data;

@Data
public class Member {
	private Integer memberId;
	private String id;
	private String password;
	private String nickname;
	private String address1;
	private String address2;
	private String email;
	private int userGrade;

}
