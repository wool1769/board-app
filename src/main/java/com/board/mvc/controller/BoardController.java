package com.board.mvc.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.board.mvc.domain.Board;
import com.board.mvc.dto.BoardGetListDto;
import com.board.mvc.service.BoardService;
import com.board.passwordHashing.PasswordHashing;

@RestController
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService service;
	@Autowired
	private PasswordHashing passwordHashing;
	
	@PostMapping("/save")
	public int save(@RequestBody Board board) {
		return service.save(board);
	}
	
	@GetMapping("/getlist")
	public BoardGetListDto getList(@RequestParam(defaultValue = "1")int page,
									@RequestParam(defaultValue = "0")int category,
									@RequestParam(defaultValue = "")String search,
									@RequestParam(defaultValue = "0")int scrap,
									 HttpSession session
									){
		return service.getList(page, category, search,scrap,session);
	}
	
	@GetMapping("/get")
	public Board get(@RequestParam int boardId,@RequestParam(defaultValue = "0") int plus) {
		return service.get(boardId,plus);
	}
	
	@PutMapping("/update")
	public void update(@RequestBody Board board) {
		service.update(board);
	}
	
	@DeleteMapping("/delete")
	public boolean delete(int boardId, String memberPw) {
		memberPw = passwordHashing.hashPassword(memberPw);
		return service.delete(boardId, memberPw);
	}
	
	
	
}
