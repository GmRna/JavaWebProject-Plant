package com.plant.petplantDiary;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PetplantDiaryController {

	@GetMapping("/plant/Diarywrite.do")
	public String write () {
		return "plant/petplantDiary/write";
	}
}
