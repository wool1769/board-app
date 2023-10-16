package com.board.mvc.service;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.mvc.domain.Member;
import com.board.mvc.repository.MemberRepository;
import com.board.mvc.request.MemberUpdateRequest;

@Service
public class MemberService {
	
	@Autowired
	private MemberRepository repository;
	
	public boolean save(Member member) {
		
		boolean checknum =repository.idcheck(member)==0;
		
		
		if(checknum) {
			repository.save(member);
		}
		
		
		return checknum;
	}
	
	public boolean idcheck(Member member,HttpSession session) {
		boolean checknum =repository.idcheck(member)!=0;
		System.out.println(member);
		if (checknum) {
			if (session.getAttribute("id")==null) {
				member = repository.get(member.getId());
				String grade =String.valueOf(member.getUserGrade());
				session.setAttribute("id", member.getId());
				session.setAttribute("grade", grade);
				
			}
		}

		return checknum;
	}
	
	public Member get(String id) {
		return repository.get(id);
	}
	
	public boolean update(MemberUpdateRequest memberUpdate) {
		Member member = new Member();
		member.setId(memberUpdate.getId());
		member.setPassword(memberUpdate.getPassword());
		member.setAddress1(memberUpdate.getAddress1());
		member.setAddress2(memberUpdate.getAddress2());
		member.setEmail(memberUpdate.getEmail());
		member.setNickname(memberUpdate.getNickname());
		boolean checknum =repository.idcheck(member)!=0;
		member.setPassword(memberUpdate.getUpdatepw());
		
		if(checknum) {
			repository.update(member);
		}
		
		return checknum;
		
		
	}
	
	public boolean delete(Member member) {
		boolean checknum =repository.idcheck(member)!=0;
		String id = member.getId();
		if(checknum) {
			repository.delete(id);			
		}		
		
		return checknum;
	}

}
