package com.ruxia.tools.testunit.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ruxia.tools.testunit.model.FileModel;
import com.ruxia.tools.testunit.model.TestUnitModel;
import com.ruxia.tools.testunit.service.TestUnitManagerService;
import com.ruxia.tools.testunit.utils.HttpUtil;
import com.ruxia.tools.testunit.utils.PropertiesUtil;

/**
 * Created by SEELE on 2016/9/6.
 */
@Controller
@RequestMapping("/testUnit")
public class TestUnitController {
    private String root_path = TestUnitManagerService.ROOT_PATH;
    
    @Resource
    private TestUnitManagerService testUnitManagerService;
    
    @RequestMapping("/toSendDatagram")
    public String toSendDatagram(
            @RequestParam(value = "filePath", required = false) String filePath,
            ModelMap modelMap) {
        String parentPath = "01_机构用户/01-测试开户";
        String name = "开户正常测试";
        filePath = "01_机构用户/01-测试开户/开户正常测试";
        String fileRealPath = root_path + "/" + filePath + ".properties";
        Properties properties = PropertiesUtil.getProperties(fileRealPath);
        
        TestUnitModel testUnitModel = TestUnitModel.getByProperties(properties);
        testUnitModel.setParentPath(parentPath);
        testUnitModel.setName(name);
        modelMap.put("testUnitModel", testUnitModel);
        
        return "sendTestUnit";
        
    }
    
    @RequestMapping("/toSendDatagramByUuid")
    public String toSendDatagramByUuid(

            @RequestParam(value = "uuid", required = false) String uuid,
            ModelMap modelMap) {
        FileModel fileModel = ShowMenuController.fileModelMap.get(uuid);
        if (fileModel != null) {
            String fileRealPath = fileModel.getFileFullPath();
            Properties properties = PropertiesUtil.getProperties(fileRealPath);
            TestUnitModel testUnitModel = TestUnitModel
                    .getByProperties(properties);
            modelMap.put("testUnitModel", testUnitModel);
            modelMap.put("fileModel",fileModel);
            
        } else {
            modelMap.put("testUnitModel", new TestUnitModel());
        }
        return "sendTestUnit";
        
    }
    
    @ResponseBody
    @RequestMapping("/getSendDatagram")
    public TestUnitModel getSendDatagram(
            @RequestParam(value = "filePath", required = false) String filePath) {
        String parentPath = "01_机构用户/01-测试开户";
        String name = "开户正常测试";
        filePath = "01_机构用户/01-测试开户/开户正常测试";
        String fileRealPath = root_path + "/" + filePath + ".properties";
        Properties properties = PropertiesUtil.getProperties(fileRealPath);
        
        TestUnitModel testUnitModel = TestUnitModel.getByProperties(properties);
        testUnitModel.setParentPath(parentPath);
        testUnitModel.setName(name);
        
        return testUnitModel;
        
    }
    
    @RequestMapping("sendDatagram")
    @ResponseBody
    public Map<String, Object> sendDatagram(TestUnitModel testUnitModel,
            @RequestParam(value = "save", required = false) Boolean save) {
        if (save != null && save) {
            testUnitManagerService.saveOrUpdate(testUnitModel);
        }
        Map<String, Object> map = new HashMap<>();
        String respose = "失败";
        try {
            String requestServer = testUnitModel.getRequestServer();
            if (requestServer.endsWith("/")) {
                requestServer = requestServer.substring(0,
                        requestServer.length() - 1);
            }
            String requestPath = testUnitModel.getRequestPath();
            if (requestPath.startsWith("/")) {
                requestPath = requestPath.substring(1);
            }
            String url = requestServer + "/" + requestPath;
            
            map.putAll(HttpUtil.sendXmlData(url,
                    testUnitModel.getRequestDatagram()));
            
            map.put("code", 0);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("code", 1);
            
        } finally {
            map.put("message", respose);
            return map;
        }
    }
    
}
