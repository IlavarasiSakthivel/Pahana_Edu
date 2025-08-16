package com.example.demo.dao;

import com.example.demo.model.Bill;
import java.util.List;
import java.sql.Date; // Add this import

public interface BillDAO {
    Bill getBillById(int id) throws Exception;
    List<Bill> getAllBills() throws Exception;
    int saveBill(Bill bill) throws Exception;
    List<Bill> getBillsByCustomer(String accountNumber) throws Exception;
    List<Bill> getBillsByDateRange(Date startDate, Date endDate) throws Exception;
}