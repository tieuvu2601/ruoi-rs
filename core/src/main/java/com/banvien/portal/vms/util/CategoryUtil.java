package com.banvien.portal.vms.util;

import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.domain.CategoryObject;
import com.banvien.portal.vms.dto.CategoryDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class CategoryUtil {

    public static List<CategoryDTO> buildTreeCategory(List<Category> listCats, Category parent) {
        List<CategoryDTO> res = new ArrayList<CategoryDTO>();

        Map<Long, Long> mapParent = new HashMap<Long, Long>();

        for(Category category : listCats){
            CategoryDTO addedCat = normalizeFromCategory2CategoryDTO(category);

            if(category.getParentCategory() == null){
                mapParent.put(category.getCategoryID(), category.getCategoryID());
                res.add(addedCat);
            }else{
                long rootParent = -1l;
                Category currentCategory = category;
                List<Long> listLevelParent = new ArrayList<Long>();
                while (currentCategory != null){
                    if(currentCategory.getParentCategory() != null){
                        listLevelParent.add(currentCategory.getParentCategory().getCategoryID());
                    }else{
                        rootParent = currentCategory.getCategoryID();
                        break;
                    }
                    currentCategory = currentCategory.getParentCategory();
                }

                CategoryDTO  parentCategoryDTO = null;

                for(int i = listLevelParent.size() - 1; i >= 0 ; i --){
                    if(i == listLevelParent.size() - 1){
                        parentCategoryDTO = findCategoryInList(res, rootParent);
                    }else{
                        parentCategoryDTO = findCategoryInList(parentCategoryDTO.getChildren(), listLevelParent.get(i)) ;
                    }
                }
                if(parentCategoryDTO.getChildren() == null){
                    parentCategoryDTO.setChildren(new ArrayList<CategoryDTO>());
                }
                parentCategoryDTO.getChildren().add(addedCat);
            }
        }

        return res;
    }

    public  static CategoryDTO findCategoryInList(List<CategoryDTO> list, Long id){
        for(CategoryDTO categoryDTO : list){
            if(categoryDTO.getCategoryID().equals(id)){
                return categoryDTO ;
            }
        }
        return null;
    }

    public static CategoryDTO normalizeFromCategory2CategoryDTO(Category category){
        CategoryDTO categoryDTO = new CategoryDTO();
        categoryDTO.setAuthoringTemplate(category.getAuthoringTemplate());
        categoryDTO.setCategoryID(category.getCategoryID());
        categoryDTO.setCode(category.getCode());
        categoryDTO.setCreatedDate(category.getCreatedDate());
        categoryDTO.setDescription(category.getDescription());
        categoryDTO.setDisplayOrder(category.getDisplayOrder());
        categoryDTO.setKeyword(category.getKeyword());
        categoryDTO.setModifiedDate(category.getModifiedDate());
        categoryDTO.setName(category.getName());
        return categoryDTO;
    }

    public static List<CategoryObject> getAllCategoryObjectInSite(List<Category> categories){
        List<CategoryObject> categorieObjs = new ArrayList<CategoryObject>();
        categorieObjs = getListChildren(categories, categorieObjs, -1, null);
        return categorieObjs;
    }

    public static List<CategoryObject> getListCategoryForBuildRightMenuForSite(List<Category> categories, List<CategoryObject> returnList, Integer nodeLevel, CategoryObject parent) {
        Integer currentNodeLevel = nodeLevel + 1;
        for(Category children : categories){
            if(children.getDisplayOrder() > 0){
                CategoryObject categoryObject = bindCategoryToCategoryObject(children, currentNodeLevel, parent);
                returnList.add(categoryObject);
                if(children.getChildren() != null && children.getChildren().size() > 0){
                    getListChildren(children.getChildren(), returnList, currentNodeLevel, categoryObject);
                }
            }

        }
        return returnList;
    }

    public static List<CategoryObject> getListChildren(List<Category> categories, List<CategoryObject> returnList, Integer nodeLevel, CategoryObject parent) {
        Integer currentNodeLevel = nodeLevel + 1;
        for(Category children : categories){
            CategoryObject categoryObject = bindCategoryToCategoryObject(children, currentNodeLevel, parent);
            Integer numberOfChildren = 0;
            if(children.getChildren() != null && children.getChildren().size() > 0){
                for(Category chid : children.getChildren()){
                    if(chid.getDisplayOrder() != null && chid.getDisplayOrder() > 0){
                        numberOfChildren += 1;
                    }
                }
            }
            categoryObject.setChildrenSize(numberOfChildren);
            returnList.add(categoryObject);
            if(children.getChildren() != null && children.getChildren().size() > 0){
                getListChildren(children.getChildren(), returnList, currentNodeLevel, categoryObject);
            }
        }
        return returnList;
    }

    public static CategoryObject bindCategoryToCategoryObject(Category category, Integer nodeLevel, CategoryObject parent){
        CategoryObject categoryObject = new CategoryObject();
        categoryObject.setCategoryID(category.getCategoryID());
        categoryObject.setCode(category.getCode());
        categoryObject.setName(category.getName());
        categoryObject.setNodeLevel(nodeLevel);
        categoryObject.setPrefixUrl(category.getPrefixUrl());
        if(category.getChildren() != null && category.getChildren().size() > 0){
            categoryObject.setChildrenSize(category.getChildren().size());
        } else {
            categoryObject.setChildrenSize(0);
        }
        if(parent != null && parent.getCategoryID() != null && parent.getCategoryID() > 0){
            categoryObject.setParent(parent);
        } else {
            categoryObject.setParent(null);
        }
        if(category.getParentRootID() != null && category.getParentRootID() > 0){
            categoryObject.setParentRootId(category.getParentRootID());
        } else {
            if(parent != null && parent.getCategoryID() != null && parent.getCategoryID() > 0){
                categoryObject.setParentRootId(parent.getCategoryID());
            } else {
                categoryObject.setParentRootId(-1l);
            }
        }
        categoryObject.setDisplayOrder(category.getDisplayOrder());
        return categoryObject;
    }

}
