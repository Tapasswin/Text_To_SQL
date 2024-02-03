use data;

#What is the average transaction amount for each denomination?
SELECT denomination_type, AVG(transaction_amount) AS average_amount FROM master_table GROUP BY denomination_type;

#Analyze the relationship between denomination type and average transaction amount.
SELECT denomination_type, AVG(transaction_amount) FROM master_table GROUP BY denomination_type;

#Which transaction has a higher number of denomination type 10?
SELECT transaction_type, COUNT(transaction_id) FROM master_table WHERE denomination_type = 10 GROUP BY transaction_type ORDER BY transaction_type DESC LIMIT 1;

#Examine the relationship between denomination type and transaction amount to determine if higher denomination result in greater transaction amount.
SELECT denomination_type, transaction_amount FROM master_table ORDER BY transaction_amount DESC LIMIT 1;

#Show me which transactions are having highest denominations.
SELECT transaction_type, denomination_type FROM master_table ORDER BY denomination_type DESC LIMIT 1;

#Which date has more number of transactions.
SELECT Date, COUNT(Date) FROM master_table GROUP BY Date ORDER BY COUNT(Date) DESC LIMIT 1;

#Can you please display the date and transaction type that has more than $20 denominations?
SELECT Date, transaction_type FROM master_table WHERE denomination_type > 20;

#Can you please tell me the total number of transactions that have taken place with a 50 denomination?
SELECT denomination_type, COUNT(*) FROM master_table WHERE denomination_type = 50 GROUP BY denomination_type;

#Which ATM model has more number of transactions
SELECT atm_model_name, COUNT(*) AS total_amount FROM master_table GROUP BY atm_model_name ORDER BY total_amount DESC LIMIT 1;

#what is the Highest denomination?
SELECT denomination_type FROM master_table ORDER BY denomination_type DESC LIMIT 1;

#Could you please let me know the count of unique ATM models name present in the system?
SELECT atm_model_name, COUNT(atm_model_name) FROM master_table GROUP BY atm_model_name ORDER BY atm_model_name;

#Could you please provide me with information regarding the total amount of withdrawals on 2023-12-01?
SELECT date, SUM(transaction_amount) FROM master_table WHERE transaction_type = 'withdrawals' AND date = '2023-12-01';

#List the top 5 ATMs with the highest transaction amounts?
SELECT atm_model_name, transaction_amount FROM master_table ORDER BY transaction_amount DESC LIMIT 5;

#Find the average transaction amount for a ATM model name ATMITM111?
SELECT AVG(transaction_amount) AS average_amount FROM master_table WHERE atm_model_name = 'ATMITM111';

#Identify the dates with more than 100 transactions.
SELECT Date, COUNT(Date) FROM master_table GROUP BY Date HAVING COUNT(*) > 100;

#Calculate the average transaction amount per day?
SELECT Date, AVG(transaction_amount) AS average_amount FROM master_table GROUP BY date ORDER BY date DESC;

#What is the total number of unique account number in the system?
SELECT account_number, COUNT(Account_number) FROM master_table GROUP BY account_number;

#What is the total number of unique account number in the ATM model ATMITM111?
SELECT COUNT(DISTINCT account_number) FROM master_table WHERE atm_model_name = 'ATMITM111';

#Find the total transaction amount of cash withdrawn by each account number?
SELECT account_number, SUM(transaction_amount) FROM master_table WHERE transaction_type = 'withdrawals' GROUP BY account_number;

#List the top 3 account numbers with the highest transaction amounts?
SELECT account_number, transaction_type FROM master_table ORDER BY transaction_amount DESC LIMIT 3;

#Find the average transaction amount for a account number 123456?
SELECT AVG(transaction_amount) AS average_amount FROM master_table WHERE account_number = 123456;

#Identify the account numbers with more than 50 transactions.
SELECT account_number FROM master_table GROUP BY account_number HAVING COUNT(*) > 50;

#Identify the ATM models with more than 50 transactions.
SELECT atm_model_name FROM master_table GROUP BY atm_model_name HAVING COUNT(*) > 50;

#Find the total transaction amount of transaction type deposits on weekdays.
SELECT date, SUM(transaction_amount) FROM master_table WHERE transaction_type = 'deposits' GROUP BY date;

#Calculate the average transaction amount per account number.
SELECT account_number, AVG(transaction_amount) AS average_amount FROM master_table GROUP BY account_number;

#Find the total amount of transaction type withdrawals for each denomination?
SELECT denomination_type, SUM(transaction_amount) FROM master_table WHERE transaction_type = 'withdrawals' GROUP BY denomination_type;

#List the top 3 denominations with the highest transaction amount.
SELECT denomination_type, transaction_amount FROM master_table ORDER BY transaction_amount DESC LIMIT 3;

#How many transactions occurred in the last 48 hours?
SELECT date, COUNT(transaction_number) FROM master_table WHERE transaction_type = 'Date' AND date = '48 hours';

#Identify the denominations with more than 200 transactions.
SELECT denomination_type FROM master_table GROUP BY denomination_type HAVING COUNT(*) > 200;

#Calculate the average transaction amount per denomination.
SELECT denomination_type, AVG(transaction_amount) AS average_amount FROM master_table GROUP BY denomination_type;

#List the top 3 records of the highest total transaction amounts.
SELECT transaction_type, transaction_amount FROM master_table ORDER BY transaction_amount DESC LIMIT 3;

SELECT transaction_type, SUM(transaction_number) FROM master_table WHERE transaction_type = 'deposit' GROUP BY transaction_type;
SELECT denomination_type, AVG(transaction_amount) AS average_amount FROM master_table GROUP BY denomination_type;

SELECT COUNT(DISTINCT account_number) FROM master_table WHERE atm_model_name = 'ATMITM111';

SELECT Date, MAX(transaction_amount) FROM master_table GROUP BY Date ORDER BY transaction_amount DESC LIMIT 1;


