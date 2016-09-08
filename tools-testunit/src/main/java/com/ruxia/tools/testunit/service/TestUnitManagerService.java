package com.ruxia.tools.testunit.service;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Logger;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.ruxia.tools.testunit.model.TestUnitModel;
import com.ruxia.tools.testunit.utils.PropertiesUtil;

/**
 * Created by SEELE on 2016/9/7.
 */

@Service
public class TestUnitManagerService {
    public static final String ROOT_PATH = "d:/_testFiles";
    public static Map<String, TestUnitModel> testUnitModelMap = new HashMap<>();

    Logger logger = Logger.getLogger(TestUnitManagerService.class.getName());
    
    @PostConstruct
    public void init() {
        logger.info("加载文件。。。");
        loadTestUnitMode(null);
    }
    
    public void loadTestUnitMode(File file) {
        if (file == null) {
            file = new File(ROOT_PATH);
            testUnitModelMap.clear();
        }
        
        if (file.isDirectory()) {
            File[] files = file.listFiles();
            for (File tempFile : files) {
                if (tempFile.isDirectory()) {
                    loadTestUnitMode(tempFile);
                } else {
                    Properties properties = PropertiesUtil
                            .getProperties(tempFile);
                    TestUnitModel testUnitModel = TestUnitModel
                            .getByProperties(properties);
                    testUnitModelMap.put(testUnitModel.getId(), testUnitModel);
                }
            }
        }
        
    }
    
    public void saveOrUpdate(TestUnitModel testUnitModel) {
        String filePath = ROOT_PATH + "/" + testUnitModel.getParentPath() + "/"
                + testUnitModel.getName() + ".properties";
        File file = new File(filePath);
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        Properties properties = convertToProperties(testUnitModel);
        PropertiesUtil.saveProperties(properties, filePath);
    }
    
    private Properties convertToProperties(TestUnitModel testUnitModel) {
        String id = testUnitModel.getId();
        if (StringUtils.isEmpty(id)) {
            id = UUID.randomUUID().toString();
            testUnitModel.setId(id);
        }
        Properties properties = new Properties();
        properties.put("id", testUnitModel.getId());
        properties.put("requestServer", testUnitModel.getRequestServer());
        properties.put("requestPath", testUnitModel.getRequestPath());
        properties.put("requestDatagram",
                testUnitModel.getRequestDatagram() == null ? ""
                        : testUnitModel.getRequestDatagram());
        properties.put("lastResponseDatagram",
                testUnitModel.getLastResponseDatagram() == null ? ""
                        : testUnitModel.getLastResponseDatagram());
        return properties;
    }
    
}
