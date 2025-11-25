use bank_loan;
CREATE TABLE loans(
    customer_id INT,
    customer_name VARCHAR(100),
    loan_id INT PRIMARY KEY,
    loan_amount INT,
    payment_date INT,
    due_date INT,
    branch VARCHAR(50)
);

-- Insert 20 sample rows
INSERT INTO loans (customer_id, customer_name, loan_id, loan_amount, payment_date, due_date, branch)
VALUES
(101, 'Amit Sharma', 1001, 50000, 20241110, 20241210, 'Mumbai'),
(102, 'Priya Verma', 1002, 75000, 20241112, 20241212, 'Delhi'),
(103, 'Rohit Mehta', 1003, 30000, 20241115, 20241215, 'Pune'),
(104, 'Sneha Kulkarni', 1004, 45000, 20241118, 20241218, 'Nagpur'),
(105, 'Vikas Patil', 1005, 60000, 20241120, 20241220, 'Amravati'),
(106, 'Neha Joshi', 1006, 85000, 20241122, 20241222, 'Bangalore'),
(107, 'Karan Singh', 1007, 40000, 20241125, 20241225, 'Hyderabad'),
(108, 'Meera Desai', 1008, 95000, 20241128, 20241228, 'Chennai'),
(109, 'Suresh Gupta', 1009, 70000, 20241201, 20250101, 'Ahmedabad'),
(110, 'Anjali Nair', 1010, 55000, 20241205, 20250105, 'Kolkata'),
(111, 'Rahul Yadav', 1011, 62000, 20241207, 20250107, 'Lucknow'),
(112, 'Divya Menon', 1012, 48000, 20241209, 20250109, 'Thiruvananthapuram'),
(113, 'Arjun Kapoor', 1013, 90000, 20241211, 20250111, 'Jaipur'),
(114, 'Pooja Rane', 1014, 35000, 20241213, 20250113, 'Surat'),
(115, 'Manish Tiwari', 1015, 80000, 20241215, 20250115, 'Indore'),
(116, 'Shalini Deshmukh', 1016, 72000, 20241217, 20250117, 'Aurangabad'),
(117, 'Deepak Choudhary', 1017, 65000, 20241219, 20250119, 'Patna'),
(118, 'Ritika Jain', 1018, 40000, 20241221, 20250121, 'Bhopal'),
(119, 'Sanjay Rao', 1019, 95000, 20241223, 20250123, 'Visakhapatnam'),
(120, 'Kavita Iyer', 1020, 50000, 20241225, 20250125, 'Coimbatore');

select * from loans;

#1.Total loans per branch

SELECT 
    Branch,
    COUNT(loan_id) AS TotalLoans
FROM loans
GROUP BY Branch
ORDER BY TotalLoans DESC;


# 2.Customers with Overdue Loans
-- Customers with overdue loans
SELECT 
    customer_id,
    customer_name,
    loan_id,
    loan_amount,
    payment_date,
    due_date,
    branch
FROM loans
WHERE payment_date > due_date;


#3. Average loan amount per type
ALTER TABLE loans
ADD loan_type VARCHAR(50);

SELECT 
    loan_type,
    AVG(loan_amount) AS avg_loan_amount
FROM loans
GROUP BY loan_type;

# 4.Defaulted Loan by segments
SELECT 
    branch,
    COUNT(*) AS total_defaulted_loans,
    SUM(loan_amount) AS total_defaulted_amount
FROM loans
WHERE payment_date IS NULL 
   OR payment_date > due_date
GROUP BY branch;


# 5.Rank branches by defaulters:
SELECT 
    branch,
    COUNT(*) AS total_defaulters
FROM loans
WHERE payment_date IS NULL 
   OR payment_date > due_date
GROUP BY branch
ORDER BY total_defaulters DESC;

# 6.counts loan approved vs rejected:
ALTER TABLE loans
ADD status VARCHAR(50);
INSERT INTO loans (customer_id, customer_name, loan_id, loan_amount, payment_date, due_date, branch, status)
VALUES
(101, 'Amit Sharma', 1001, 50000, 20241110, 20241210, 'Mumbai', 'Approved'),
(102, 'Priya Verma', 1002, 75000, 20241112, 20241212, 'Delhi', 'Rejected'),
(103, 'Rohit Mehta', 1003, 30000, 20241115, 20241215, 'Pune', 'Approved'),
(104, 'Sneha Kulkarni', 1004, 45000, 20241118, 20241218, 'Nagpur', 'Rejected');
SELECT 
    status,
    COUNT(*) AS total_loans
FROM loans
GROUP BY status;



