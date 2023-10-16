package com.board.mvc.repository;

import org.springframework.stereotype.Repository;

import com.board.mvc.domain.Member;

@Repository
public interface MemberRepository {
	
	void save(Member member);
	
	int idcheck(Member member);
	
	Member get(String id);
	
	void update(Member member);
	
	void delete(String id);
	
}
