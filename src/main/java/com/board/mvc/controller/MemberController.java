package com.board.mvc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.board.mvc.domain.Member;
import com.board.mvc.request.MemberUpdateRequest;
import com.board.mvc.service.MemberService;
import com.board.passwordHashing.PasswordHashing;

@RestController
public class MemberController {

	@Autowired
	private MemberService service;

	@Autowired
	private PasswordHashing passwordHashing;

	@PostMapping("/memberjoin")
	public boolean save(@RequestBody Member member) {
		String pHashig = passwordHashing.hashPassword(member.getPassword());
		member.setPassword(pHashig);
		
		return service.save(member);
	}

	@PostMapping("/login")
	public boolean idcheck(@RequestBody Member member, HttpSession session) {
		String pHashig = passwordHashing.hashPassword(member.getPassword());
		member.setPassword(pHashig);
		return service.idcheck(member, session);
	}

	@GetMapping("/memberdata")
	public Member get(@RequestParam String id) {

		return service.get(id);
	}

	@PutMapping("/userupdate")
	public boolean update(@RequestBody MemberUpdateRequest memberUpdate) {
		String pHashig = passwordHashing.hashPassword(memberUpdate.getPassword());
		String uppHashig = passwordHashing.hashPassword(memberUpdate.getUpdatepw());
		memberUpdate.setPassword(pHashig);
		memberUpdate.setUpdatepw(uppHashig);
		return service.update(memberUpdate);
	}

	@PostMapping("/userdelete")
	public boolean delete(@RequestBody Member member) {
		String pHashig = passwordHashing.hashPassword(member.getPassword());
		member.setPassword(pHashig);
		return service.delete(member);
	}

}
