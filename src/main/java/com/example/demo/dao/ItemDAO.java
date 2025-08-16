package com.example.demo.dao;

import com.example.demo.model.Item;
import java.util.List;

public interface ItemDAO {
    Item getItemById(int id) throws Exception;
    List<Item> getAllItems() throws Exception;
    void saveItem(Item item) throws Exception;
    void updateItem(Item item) throws Exception;
    void deleteItem(int id) throws Exception;
    List<Item> getLowStockItems() throws Exception;
}