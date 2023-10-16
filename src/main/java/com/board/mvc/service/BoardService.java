package com.board.mvc.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.board.mvc.domain.Board;
import com.board.mvc.domain.Member;
import com.board.mvc.dto.BoardGetListDto;
import com.board.mvc.dto.BoardQueryParams;
import com.board.mvc.repository.BoardRepository;
import com.board.mvc.repository.MemberRepository;

@Service
public class BoardService {

	@Autowired
	private BoardRepository repository;
	@Autowired
	private MemberRepository memberRepository;

	public int save(Board board) {
		repository.save(board);
		return board.getBoardId();
	}

	public BoardGetListDto getList(int pageNum, int category, String search, int scrap,HttpSession session) {
		BoardGetListDto dto = new BoardGetListDto();
		String searchSql = "";
		String id = (String) session.getAttribute("id");
		if (scrap != 1) {
			if (category == 0) {
				searchSql = "";
			}
			// 제목+내용
			else if (category == 1) {
				searchSql = "WHERE title LIKE'%" + search + "%' OR content LIKE '%" + search + "%'";
			} else if (category == 2) {
				searchSql = "WHERE title LIKE '%" + search + "%'";
			} else if (category == 3) {
				searchSql = "WHERE content LIKE '%" + search + "%'";
			} else if (category == 4) {
				searchSql = "WHERE member_id = '" + search + "'";
			}
		}else {
//			System.out.println(id);
			searchSql = " WHERE board_id IN (SELECT f_board_id FROM favorites WHERE f_userid = '" + id + "') ";
			
		}
		BoardQueryParams params = new BoardQueryParams();
		params.setPageNum((pageNum - 1) * 10);
		params.setSearch(searchSql);

		dto.setTotalContent(repository.totalContent(searchSql));
		dto.setGetlist(repository.getList(params));
		return dto;
	}

	public Board get(int boardId, int plus) {
		if (plus != 0) {
			repository.viewPlus(boardId);
		}
		return repository.get(boardId);
	}

	public void update(Board board) {
		repository.update(board);
	}

	public boolean delete(int boardId, String memberPw) {
		String memberId = repository.get(boardId).getMemberId();
		Member member = new Member();
		member.setId(memberId);
		member.setPassword(memberPw);
		boolean check = memberRepository.idcheck(member) != 0;

		if (check) {
			repository.delete(boardId);
		}

		return check;
	}

}
