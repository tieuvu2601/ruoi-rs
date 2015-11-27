package com.banvien.portal.vms.util;

import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.dto.CategoryObjectDTO;
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

    public static List<CategoryObjectDTO> getAllCategoryObjectInSite(List<Category> categories){
        List<CategoryObjectDTO> categorieObjs = new ArrayList<CategoryObjectDTO>();
        categorieObjs = getListChildren(categories, categorieObjs, -1, null);
        return categorieObjs;
    }

    public static List<CategoryObjectDTO> getListCategoryForBuildRightMenuForSite(List<Category> categories, List<CategoryObjectDTO> returnList, Integer nodeLevel, CategoryObjectDTO parent) {
        Integer currentNodeLevel = nodeLevel + 1;
        for(Category children : categories){
            if(children.getDisplayOrder() > 0){
                CategoryObjectDTO categoryObjectDTO = bindCategoryToCategoryObject(children, currentNodeLevel, parent);
                returnList.add(categoryObjectDTO);
                if(children.getChildren() != null && children.getChildren().size() > 0){
                    getListChildren(children.getChildren(), returnList, currentNodeLevel, categoryObjectDTO);
                }
            }

        }
        return returnList;
    }

    public static List<CategoryObjectDTO> getListChildren(List<Category> categories, List<CategoryObjectDTO> returnList, Integer nodeLevel, CategoryObjectDTO parent) {
        Integer currentNodeLevel = nodeLevel + 1;
        for(Category children : categories){
            CategoryObjectDTO categoryObjectDTO = bindCategoryToCategoryObject(children, currentNodeLevel, parent);
            Integer numberOfChildren = 0;
            if(children.getChildren() != null && children.getChildren().size() > 0){
                for(Category chid : children.getChildren()){
                    if(chid.getDisplayOrder() != null && chid.getDisplayOrder() > 0){
                        numberOfChildren += 1;
                    }
                }
            }
            categoryObjectDTO.setChildrenSize(numberOfChildren);
            returnList.add(categoryObjectDTO);
            if(children.getChildren() != null && children.getChildren().size() > 0){
                getListChildren(children.getChildren(), returnList, currentNodeLevel, categoryObjectDTO);
            }
        }
        return returnList;
    }

    public static CategoryObjectDTO bindCategoryToCategoryObject(Category category, Integer nodeLevel, CategoryObjectDTO parent){
        CategoryObjectDTO categoryObjectDTO = new CategoryObjectDTO();
        categoryObjectDTO.setCategoryID(category.getCategoryID());
        categoryObjectDTO.setCode(category.getCode());
        categoryObjectDTO.setName(category.getName());
        categoryObjectDTO.setNodeLevel(nodeLevel);
        categoryObjectDTO.setPrefixUrl(category.getPrefixUrl());
        if(category.getChildren() != null && category.getChildren().size() > 0){
            categoryObjectDTO.setChildrenSize(category.getChildren().size());
        } else {
            categoryObjectDTO.setChildrenSize(0);
        }
        if(parent != null && parent.getCategoryID() != null && parent.getCategoryID() > 0){
            categoryObjectDTO.setParent(parent);
        } else {
            categoryObjectDTO.setParent(null);
        }
        if(category.getParentRootID() != null && category.getParentRootID() > 0){
            categoryObjectDTO.setParentRootId(category.getParentRootID());
        } else {
            if(parent != null && parent.getCategoryID() != null && parent.getCategoryID() > 0){
                categoryObjectDTO.setParentRootId(parent.getCategoryID());
            } else {
                categoryObjectDTO.setParentRootId(-1l);
            }
        }
        categoryObjectDTO.setDisplayOrder(category.getDisplayOrder());
        return categoryObjectDTO;
    }

}
