package com.example.demo.service;

import com.example.demo.dao.BillDAO;
import com.example.demo.model.Bill;
import com.example.demo.model.BillItem;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class BillingService {
    private final BillDAO billDAO = new BillDAO();
    private final ItemService itemService = new ItemService();

    public int createBill(int customerId, List<BillItem> items) throws Exception {
        BigDecimal total = BigDecimal.ZERO;
        for (BillItem it : items) {
            BigDecimal line = it.getUnitPrice().multiply(BigDecimal.valueOf(it.getQty()));
            it.setLineTotal(line);
            total = total.add(line);
        }
        int billId = billDAO.createBill(customerId, total);
        for (BillItem it : items) {
            billDAO.addBillItem(billId, it.getItemId(), it.getQty(), it.getUnitPrice(), it.getLineTotal());
            itemService.reduceStock(it.getItemId(), it.getQty());
        }
        return billId;
    }

    public Bill getBill(int billId){ return billDAO.findByIdWithItems(billId); }

    public List<Bill> recent(int limit){ return billDAO.listRecent(limit); }
}
