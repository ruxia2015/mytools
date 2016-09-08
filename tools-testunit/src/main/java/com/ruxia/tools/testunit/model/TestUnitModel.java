package com.ruxia.tools.testunit.model;

import java.util.Properties;

/**
 * 测试报文
 * Created by SEELE on 2016/9/5.
 */
public class TestUnitModel {
    private String id;
    private String parentPath;
    
    private String name;

    /**
     * 请求的服务端
     */
    private String requestServer;

    /**
     * 路径
     */
    private String requestPath;

    /**
     * 发送报文
     */
    private String requestDatagram;
    
    private String lastResponseDatagram;
    
    private boolean isFolder;
    
    public static TestUnitModel getByProperties(Properties properties) {
        TestUnitModel testUnitModel = new TestUnitModel();

       // testUnitModel.setId(properties.getProperty("id"));
        testUnitModel.setRequestServer(properties.getProperty("requestServer"));
        testUnitModel.setRequestPath(properties.getProperty("requestPath"));
        testUnitModel.setRequestDatagram(properties.getProperty("requestDatagram"));

        testUnitModel.setLastResponseDatagram(properties.getProperty("lastResponseDatagram"));
        
        return testUnitModel;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public boolean isFolder() {
        return isFolder;
    }
    
    public void setIsFolder(boolean isFolder) {
        this.isFolder = isFolder;
    }
    
    public String getParentPath() {
        return parentPath;
    }
    
    public void setParentPath(String parentPath) {
        this.parentPath = parentPath;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getRequestServer() {
        return requestServer;
    }
    
    public void setRequestServer(String requestServer) {
        this.requestServer = requestServer;
    }
    
    public String getRequestPath() {
        return requestPath;
    }
    
    public void setRequestPath(String requestPath) {
        this.requestPath = requestPath;
    }
    
    public String getRequestDatagram() {
        return requestDatagram;
    }
    
    public void setRequestDatagram(String requestDatagram) {
        this.requestDatagram = requestDatagram;
    }
    
    public String getLastResponseDatagram() {
        return lastResponseDatagram;
    }
    
    public void setLastResponseDatagram(String lastResponseDatagram) {
        this.lastResponseDatagram = lastResponseDatagram;
    }
    
}
