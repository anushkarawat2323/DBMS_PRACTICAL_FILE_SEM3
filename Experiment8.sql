--AIM: To implement banking-style transactions using BEGIN, COMMIT, ROLLBACK and SAVEPOINT, simulate partial failures, and demonstrate isolation levels and 
-- concurrency anomalies using two sessions.

CREATE TABLE Account(
    acc_no INT PRIMARY KEY,
    name VARCHAR(30),
    balance DECIMAL(10,2)
);
INSERT INTO Account VALUES
(101,'Aarav',10000),(102,'Riya',5000);
-- Transaction with COMMIT
START TRANSACTION;
UPDATE Account SET balance=balance-2000 WHERE acc_no=101;
UPDATE Account SET balance=balance+2000 WHERE acc_no=102;
COMMIT;

-- SAVEPOINT and partial rollback
START TRANSACTION;
UPDATE Account SET balance=balance-1000 WHERE acc_no=101;
SAVEPOINT sp1;
UPDATE Account SET balance=balance+1000 WHERE acc_no=102;
ROLLBACK TO sp1;
COMMIT;
-- Complete rollback
START TRANSACTION;
UPDATE Account SET balance=balance-5000 WHERE acc_no=101;
ROLLBACK;
SELECT * FROM Account;
-- Isolation level
SET SESSION TRANSACTION ISOLATION LEVEL
READ COMMITTED;
START TRANSACTION;
SELECT * FROM Account;
COMMIT;
-- Check current isolation level
SELECT @@transaction_isolation;

START TRANSACTION;
UPDATE Account SET balance=7000 WHERE acc_no=101;

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT * FROM Account WHERE acc_no=101;
COMMIT;
