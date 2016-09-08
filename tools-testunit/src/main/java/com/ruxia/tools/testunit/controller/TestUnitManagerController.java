package com.ruxia.tools.testunit.controller;

import java.io.File;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ruxia.tools.testunit.model.FileModel;
import com.ruxia.tools.testunit.model.TestUnitModel;
import com.ruxia.tools.testunit.service.TestUnitManagerService;
import com.ruxia.tools.testunit.utils.PropertiesUtil;

/**
 * 但远程而是管理
 * Created by SEELE on 2016/9/5.
 */

@Controller
@RequestMapping("/manager")
public class TestUnitManagerController {
    @Resource
    private TestUnitManagerService testUnitManagerService;
    
    public static void main(String[] args) {
        Map<String, List<String>> a = new TestUnitManagerController()
                .getFolderDirectorys();
        
    }
    
    @ResponseBody
    @RequestMapping("addFolder")
    public Boolean addFolder(String path) {
        File file = new File(path);
        if (!file.exists()) {
            file.mkdirs();
        }
        return true;
    }
    
    @ResponseBody
    @RequestMapping("/getFolderDirectorys")
    public Map<String, List<String>> getFolderDirectorys() {
        Map<String, List<String>> map = new HashMap<>();
        File file = new File(TestUnitManagerService.ROOT_PATH);
        File[] fileList = file.listFiles();
        for (File tempFile : fileList) {
            List<String> child = new ArrayList<>();
            if (tempFile.isDirectory()) {
                for (File childTempFile : tempFile.listFiles()) {
                    if (tempFile.isDirectory()) {
                        child.add(childTempFile.getName());
                    }
                }
                map.put(tempFile.getName(), child);
            }
        }
        return map;
    }
    
    @RequestMapping("/toAddTestUnit")
    public String toAddTestUnit(ModelMap modelMap,
            @RequestParam(value = "hideHead", required = false) Boolean hideHead,
            @RequestParam(value = "uuid", required = false) String uuid) {
        String parentPath = null;
        TestUnitModel testUnitModel = new TestUnitModel();
        if (uuid != null) {
            FileModel fileModel = ShowMenuController.fileModelMap.get(uuid);
            if (fileModel != null) {
                String fileRealPath = fileModel.getFilePath();
                Properties properties = PropertiesUtil
                        .getProperties(fileRealPath);
                testUnitModel = TestUnitModel.getByProperties(properties);
            }
        }
        Map<String, List<String>> folderDirectorys = getFolderDirectorys();
        modelMap.put("testUnitModel", testUnitModel);
        modelMap.put("hideHead", hideHead);
        modelMap.put("uuid", uuid);
        modelMap.put("folderDirectorys", folderDirectorys);
        return "/addTestUnit";
    }

    
    @RequestMapping("/toUpdateTestUnitBody")
    public String toUpdateTestUnitBody(ModelMap modelMap,
            @RequestParam(value = "oneLevelUuid", required = false) String oneLevelUuid,
            @RequestParam(value = "twoLevelUuid", required = false) String twoLevelUuid,
            @RequestParam(value = "uuid", required = false) String uuid) {

        TestUnitModel testUnitModel = new TestUnitModel();
        FileModel fileModel = new FileModel();
        if (uuid != null) {
             fileModel = ShowMenuController.fileModelMap.get(uuid);
            if (fileModel != null) {
                String fileRealPath = fileModel.getFilePath();
                Properties properties = PropertiesUtil
                        .getProperties(fileRealPath);
                testUnitModel = TestUnitModel.getByProperties(properties);
                testUnitModel.setName(fileModel.getFileName());
            }
        }
        Map<String, List<String>> folderDirectorys = getFolderDirectorys();
        modelMap.put("testUnitModel", testUnitModel);
        modelMap.put("uuid", uuid);
        modelMap.put("folderDirectorys", folderDirectorys);
        modelMap.put("fileModel",fileModel);

        String levelOne = null;
        String levelTwo = null;
        String paarenRelativePath = fileModel.getParentRelativePath();
        String[] strings = paarenRelativePath.split("\\\\");
        for(int i=0;i<strings.length;i++){
            if(strings[i].trim().equals("")){
                continue;
            }else if(levelOne==null){
                levelOne = strings[i];
            }else if(levelTwo==null){
                levelTwo = strings[i];
            }
        }

        modelMap.put("levelOne",levelOne);
        modelMap.put("levelTwo",levelTwo);
        return "/updateTestUnitBody";
    }
    
    @RequestMapping("/toUpdateTestUnit")
    public String toUpdateTestUnit(ModelMap modelMap) {
        Map<String, List<String>> folderDirectorys = getFolderDirectorys();
        modelMap.put("testUnitModel", new TestUnitModel());
        modelMap.put("folderDirectorys", folderDirectorys);
        return "/updateTestUnitMain";
    }
    
    @RequestMapping("/addTestUnit")
    public String addTestUnit(HttpSession session, HttpServletRequest request,
            TestUnitModel testUnitModel,
            @RequestParam(value = "levelOne", required = false) String levelOne,
            @RequestParam(value = "levelTwo", required = false) String levelTwo,
            ModelMap modelMap) {
        
        String parentPath = levelOne + "/" + levelTwo;
        testUnitModel.setParentPath(parentPath);
        testUnitManagerService.saveOrUpdate(testUnitModel);
        
        modelMap.put("testUnitModel", testUnitModel);
        
        return "/addTestUnit";
    }
    
    @ResponseBody
    @RequestMapping("/addTestUnitAjax")
    public Map<String, Object> addTestUnitAjax(HttpSession session,
            HttpServletRequest request, TestUnitModel testUnitModel,
            @RequestParam(value = "levelOne", required = false) String levelOne,
            @RequestParam(value = "levelTwo", required = false) String levelTwo,
            ModelMap modelMap) {
        
        String parentPath = levelOne + "/" + levelTwo;
        testUnitModel.setParentPath(parentPath);
        testUnitManagerService.saveOrUpdate(testUnitModel);
        
        Map<String, Object> map = new HashMap<>();
        map.put("code", 0);
        
        return map;
    }
}
