package com.ruxia.tools.testunit.model;

import java.io.File;
import java.util.List;

/**
 * Created by SEELE on 2016/9/5.
 */
public class FileModel {
    private File file;
    /**
     * 没有文件后缀的文件名称
     */
    private String fileSimpleName;

    /**
     * 文件名称，包含后缀
     */
    private String fileName;

    /**
     * 子文件列表
     */
    private List<FileModel> childFileModels;
    private boolean isFolder;

    /**
     * 相对路径
     */
    private String parentRelativePath;

    /**
     * 文件唯一标示
     */
    private String uuid;

    /**
     * 父级文件标示
     */
    private String parentUuid;
    /**
     * 文件全路径
     */
    private String fileFullPath;




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


    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }



    public String getParentRelativePath() {
        return parentRelativePath;
    }

    public void setParentRelativePath(String parentRelativePath) {
        this.parentRelativePath = parentRelativePath;
    }

    public String getFileFullPath() {
        return fileFullPath;
    }

    public void setFileFullPath(String fileFullPath) {
        this.fileFullPath = fileFullPath;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getFileSimpleName() {
        return fileSimpleName;
    }

    public void setFileSimpleName(String fileSimpleName) {
        this.fileSimpleName = fileSimpleName;
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
