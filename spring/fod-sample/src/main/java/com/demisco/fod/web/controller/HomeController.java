package com.demisco.fod.web.controller;

import com.demisco.fod.exception.EntityNotFound;
import com.demisco.fod.model.AvailableLanguages;
import com.demisco.fod.model.dto.Order;
import com.demisco.fod.service.repository.AvailableLanguagesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.EntityNotFoundException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Optional;

@Controller
@RequestMapping("/index")
@SessionAttributes("availableLanguages")
public class HomeController {

    private AvailableLanguagesRepository repository;

    @Autowired
    public HomeController(AvailableLanguagesRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/qc")
    public String showTile(ModelMap modelMap) {
        modelMap.addAttribute("name", "Hosein");
        modelMap.addAttribute("title", "Hosein");
        return "pagetest";
    }

    @GetMapping(value = "/findById/{id}")
    @ResponseBody
    public AvailableLanguages findById(@PathVariable String id) {
        return repository.findById(id).orElseThrow(EntityNotFoundException::new);
    }


    @GetMapping(value = "/findById2/{id}")
    public String findByIdHtml(@PathVariable String id, ModelMap modelMap) throws EntityNotFound {
        Optional<AvailableLanguages> optionalLanguages = repository.findById(id);
        if (!optionalLanguages.isPresent()) {
            throw new EntityNotFound("id not found " + id);
        }
        AvailableLanguages languages = optionalLanguages.get();
        modelMap.addAttribute("language", languages);
        return "page2";
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ModelAndView handleError(HttpServletRequest req, Exception ex) {
        ModelAndView modelMap = new ModelAndView("handler");
        modelMap.addObject("exception", ex);
        modelMap.addObject("url", req.getRequestURL());
        return modelMap;
    }


    @PostMapping("/save2")
    @ResponseBody
    public Boolean saveData(@RequestBody AvailableLanguages availableLanguages) {
        System.out.println(availableLanguages);
        return true;
    }

    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "home";
    }

    @GetMapping("/home")
    public HttpHeaders showInformation1() {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add(HttpHeaders.ACCEPT_CHARSET, "UTF-8");
        return httpHeaders;
    }

    @GetMapping("/show")
    public String showInformation(
            AvailableLanguages availableLanguages
            , ModelMap modelMap
            , @ModelAttribute("key") String key) {
        modelMap.addAttribute("test", availableLanguages);
        availableLanguages.setLastUpdatedBy("HASANI");
        System.out.println(key);
        return "home";
    }

    @RequestMapping(method = RequestMethod.GET
            , value = "/p2")
    public String page2(java.util.Map<String, Object> map) {
        map.put("p1", "SALAM");
        return "page2";
    }

    @GetMapping("/save")
    public String save(AvailableLanguages availableLanguages, RedirectAttributes redirectAttrs) {
        System.out.println(availableLanguages);
        redirectAttrs.addFlashAttribute("key", "value");
        return "redirect:/index/show";
    }

    @GetMapping("/save-order")
    public String save2(@Valid Order order
            , BindingResult bindingResult, ModelMap modelMap) {
        if (bindingResult.hasErrors()) {
            modelMap.addAttribute("result", bindingResult.getAllErrors());
            modelMap.addAttribute("order", order);
            return "page2";
        }
        return "page3";
    }

}
