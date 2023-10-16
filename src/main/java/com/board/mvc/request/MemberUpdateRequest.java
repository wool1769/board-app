package com.board.mvc.request;

import lombok.Data;

@Data
public class MemberUpdateRequest {
	
	private String id;
	private String password;
	private String nickname;
	private String address1;
	private String address2;
	private String email;
	private String updatepw;

}
