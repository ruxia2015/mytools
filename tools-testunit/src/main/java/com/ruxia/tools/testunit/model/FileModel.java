package com.ruxia.tools.testunit.model;

import java.io.File;
import java.util.List;

/**
 * Created by SEELE on 2016/9/5.
 */
public class FileModel {
    private File file;
    private String fileRealName;
    private String fileName;
    private List<FileModel> childFileModels;
    private boolean isFolder;

    /**
     * 相对路径
     */
    private String parentRelativePath;
    private String uuid;
    private String parentUuid;

    private String filePath;




    public String getParentUuid() {
        return parentUuid;
    }

    public void setParentUuid(String parentUuid) {
        this.parentUuid = parentUuid;
    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }


    public String getFileRealName() {
        return fileRealName;
    }

    public void setFileRealName(String fileRealName) {
        this.fileRealName = fileRealName;
    }



    public String getParentRelativePath() {
        return parentRelativePath;
    }

    public void setParentRelativePath(String parentRelativePath) {
        this.parentRelativePath = parentRelativePath;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public List<FileModel> getChildFileModels() {
        return childFileModels;
    }

    public void setChildFileModels(List<FileModel> childFileModels) {
        this.childFileModels = childFileModels;
    }

    public boolean isFolder() {
        return isFolder;
    }

    public void setIsFolder(boolean isFolder) {
        this.isFolder = isFolder;
    }
}
