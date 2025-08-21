package com.example.demo.service;

import com.example.demo.dao.ItemDAO;
import com.example.demo.model.Item;

import java.util.List;

public class ItemService {
    private final ItemDAO dao = new ItemDAO() {
        @Override
        public Item getItemById(int id) throws Exception {
            return null;
        }

        @Override
        public List<Item> getAllItems() throws Exception {
            return List.of();
        }

        @Override
        public void saveItem(Item item) throws Exception {

        }

        @Override
        public void updateItem(Item item) throws Exception {

        }

        @Override
        public void deleteItem(int id) throws Exception {

        }

        @Override
        public List<Item> getLowStockItems() throws Exception {
            return List.of();
        }
    };

    public List<Item> list(String q){ return dao.findAll(q); }
    public Item get(int id){ return dao.findById(id); }
    public void save(Item i){ if(i.getId()==0) dao.create(i); else dao.update(i); }
    public void delete(int id){ dao.delete(id); }
    public void reduceStock(int itemId, int qty){ dao.decreaseStock(itemId, qty); }
}
