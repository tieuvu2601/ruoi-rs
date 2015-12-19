package com.banvien.portal.vms.util;

import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.dto.CategoryObjectDTO;
import com.banvien.portal.vms.dto.CategoryDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CategoryUtil {

    public static List<CategoryDTO> buildTreeCategory(List<CategoryEntity> listCats, CategoryEntity parent) {
        List<CategoryDTO> res = new ArrayList<CategoryDTO>();

        Map<Long, Long> mapParent = new HashMap<Long, Long>();

        for(CategoryEntity categoryEntity : listCats){
            CategoryDTO addedCat = normalizeFromCategory2CategoryDTO(categoryEntity);

            if(categoryEntity.getParent() == null){
                mapParent.put(categoryEntity.getCategoryId(), categoryEntity.getCategoryId());
                res.add(addedCat);
            }else{
                long rootParent = -1l;
                CategoryEntity currentCategoryEntity = categoryEntity;
                List<Long> listLevelParent = new ArrayList<Long>();
                while (currentCategoryEntity != null){
                    if(currentCategoryEntity.getParent() != null){
                        listLevelParent.add(currentCategoryEntity.getParent().getCategoryId());
                    }else{
                        rootParent = currentCategoryEntity.getCategoryId();
                        break;
                    }
                    currentCategoryEntity = currentCategoryEntity.getParent();
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

    public static CategoryDTO normalizeFromCategory2CategoryDTO(CategoryEntity categoryEntity){
        CategoryDTO categoryDTO = new CategoryDTO();
        categoryDTO.setAuthoringTemplateEntity(categoryEntity.getAuthoringTemplate());
        categoryDTO.setCategoryID(categoryEntity.getCategoryId());
        categoryDTO.setCode(categoryEntity.getCode());
        categoryDTO.setCreatedDate(categoryEntity.getCreatedDate());
        categoryDTO.setDescription(categoryEntity.getDescription());
        categoryDTO.setDisplayOrder(categoryEntity.getDisplayOrder());
        categoryDTO.setModifiedDate(categoryEntity.getModifiedDate());
        categoryDTO.setName(categoryEntity.getName());
        return categoryDTO;
    }

    public static List<CategoryObjectDTO> getAllCategoryObjectInSite(List<CategoryEntity> categories){
        List<CategoryObjectDTO> categoriesObj = new ArrayList<CategoryObjectDTO>();
        categoriesObj = getListChildren(categories, categoriesObj, -1, null);
        return categoriesObj;
    }

    public static List<CategoryObjectDTO> getListChildren(List<CategoryEntity> categories, List<CategoryObjectDTO> returnList, Integer nodeLevel, CategoryObjectDTO parent) {

        Integer currentNodeLevel = nodeLevel + 1;
        for(CategoryEntity children : categories){
            CategoryObjectDTO categoryObjectDTO = bindCategoryToCategoryObject(children, currentNodeLevel, parent);
            returnList.add(categoryObjectDTO);
            if(children.getChildren() != null && children.getChildren().size() > 0){
                getListChildren(children.getChildren(), returnList, currentNodeLevel, categoryObjectDTO);
            }
        }
        return returnList;
    }

    public static CategoryObjectDTO bindCategoryToCategoryObject(CategoryEntity categoryEntity, Integer nodeLevel, CategoryObjectDTO parent){
        CategoryObjectDTO categoryObjectDTO = new CategoryObjectDTO();
        categoryObjectDTO.setCategoryId(categoryEntity.getCategoryId());
        categoryObjectDTO.setCode(categoryEntity.getCode());
        categoryObjectDTO.setName(categoryEntity.getName());
        categoryObjectDTO.setTitle(categoryEntity.getTitle());
        categoryObjectDTO.setKeyword(categoryEntity.getKeyword());
        categoryObjectDTO.setDescription(categoryEntity.getDescription());
        categoryObjectDTO.setPrefixUrl(categoryEntity.getPrefixUrl());
        categoryObjectDTO.setDisplayOrder(categoryEntity.getDisplayOrder());

        categoryObjectDTO.setNodeLevel(nodeLevel);
        categoryObjectDTO.setAuthoringTemplate(categoryEntity.getAuthoringTemplate());

        if(parent != null && parent.getCategoryId() != null && parent.getCategoryId() > 0){
            categoryObjectDTO.setParent(parent);
        } else {
            categoryObjectDTO.setParent(null);
        }

        return categoryObjectDTO;
    }

}
