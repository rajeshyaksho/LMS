-- Question 1: Insert yourself as a New Borrower. Do not provide the Card_no in your query.

INSERT INTO BORROWER(Name, Address, Phone) VALUES('Rishabh Mediratta', '5687 Mainland Drive, Arlington, TX 76018', '347-862-4958');
SELECT changes();

-- Question 2: Update your phone number to (837) 721-8965

UPDATE BORROWER 
SET Phone = '837-721-8965' 
WHERE Name = 'Rishabh Mediratta';
SELECT changes();

-- OR

UPDATE BORROWER 
SET Phone = '837-721-8965' 
WHERE Card_No = '<Generated_Card_No>';
SELECT changes();

-- Question 3: Increase the number of book_copies by 1 for the 'East Branch'

UPDATE BOOK_COPIES 
SET No_Of_Copies = No_Of_Copies + 1 
WHERE Branch_Id = (SELECT Branch_Id FROM LIBRARY_BRANCH WHERE Branch_Name = 'East Branch');
SELECT changes();

-- Question 4-a: Insert a new BOOK with the following info: Title: "Harry Potter and the Sorcerer's Stone" ;
-- Book_author: "J.K. Rowling" ; Publisher_name: "Oxford Publisheing"

INSERT INTO BOOK(Title, Publisher_name) VALUES('Harry Potter and the Sorcerer''s Stone', 'Oxford Publishing');
SELECT changes();

-- Question 4-b: You also need to insert the following branches:
-- North Branch 456 NW, Irving, TX 76100
-- UTA Branch 123 Cooper St, Arlington TX 76101

INSERT INTO LIBRARY_BRANCH(Branch_Name, Branch_Address) VALUES('North Branch', '456 NW, Irving, TX 76100');
SELECT changes();
INSERT INTO LIBRARY_BRANCH(Branch_Name, Branch_Address) VALUES('UTA Branch', '123 Cooper St, Arlington TX 76101');
SELECT changes();

-- Question 5: Return all Books that were loaned between March 5, 2022 until March 23, 2022. List Book
-- title and Branch name, and how many days it was borrowed for.

SELECT 
    B.Title,
    LB.Branch_Name,
    BL.Date_Out,
    BL.Due_Date,
    CASE 
        WHEN BL.Returned_date IS NULL THEN julianday(CURRENT_DATE) - julianday(BL.Date_Out)
        ELSE julianday(BL.Returned_date) - julianday(BL.Date_Out)
    END AS DaysBorrowed
FROM 
    BOOK_LOANS BL
JOIN 
    BOOK B ON BL.Book_Id = B.Book_Id
JOIN 
    LIBRARY_BRANCH LB ON BL.Branch_Id = LB.Branch_Id
WHERE 
    BL.Date_Out BETWEEN '2022-03-05' AND '2022-03-23'
ORDER BY 
    BL.Date_Out;

SELECT COUNT(*) AS Rows_Returned FROM ( SELECT 
    B.Title,
    LB.Branch_Name,
    BL.Date_Out,
    BL.Due_Date,
    CASE 
        WHEN BL.Returned_date IS NULL THEN julianday(CURRENT_DATE) - julianday(BL.Date_Out)
        ELSE julianday(BL.Returned_date) - julianday(BL.Date_Out)
    END AS DaysBorrowed
FROM 
    BOOK_LOANS BL
JOIN 
    BOOK B ON BL.Book_Id = B.Book_Id
JOIN 
    LIBRARY_BRANCH LB ON BL.Branch_Id = LB.Branch_Id
WHERE 
    BL.Date_Out BETWEEN '2022-03-05' AND '2022-03-23'
ORDER BY 
    BL.Date_Out; );

-- Question 6: Return a List borrower names, that have books not returned.

SELECT B.Name
FROM BORROWER B, BOOK_LOANS BL
WHERE B.Card_No = BL.Card_No AND BL.Returned_date IS NULL;

SELECT COUNT(*) AS Rows_Returned FROM ( SELECT B.Name
FROM BORROWER B, BOOK_LOANS BL
WHERE B.Card_No = BL.Card_No AND BL.Returned_date IS NULL );

-- Question 7: Create a report that will return all branches with the number of books borrowed per branch
-- separated by if they have been returned, still borrowed, or late.

SELECT 
    LB.Branch_Name,
    COUNT(CASE WHEN BL.Returned_date IS NOT NULL THEN 1 END) AS ReturnedBooks,
    COUNT(CASE WHEN BL.Returned_date IS NULL AND BL.Due_Date >= CURRENT_DATE THEN 1 END) AS BorrowedBooks,
    COUNT(CASE WHEN BL.Returned_date IS NULL AND BL.Due_Date < CURRENT_DATE THEN 1 END) AS LateBooks
FROM 
    LIBRARY_BRANCH LB
LEFT JOIN 
    BOOK_LOANS BL ON LB.Branch_Id = BL.Branch_Id
GROUP BY 
    LB.Branch_Name;

SELECT COUNT(*) AS Rows_Returned FROM ( SELECT 
    LB.Branch_Name,
    COUNT(CASE WHEN BL.Returned_date IS NOT NULL THEN 1 END) AS ReturnedBooks,
    COUNT(CASE WHEN BL.Returned_date IS NULL AND BL.Due_Date >= CURRENT_DATE THEN 1 END) AS BorrowedBooks,
    COUNT(CASE WHEN BL.Returned_date IS NULL AND BL.Due_Date < CURRENT_DATE THEN 1 END) AS LateBooks
FROM 
    LIBRARY_BRANCH LB
LEFT JOIN 
    BOOK_LOANS BL ON LB.Branch_Id = BL.Branch_Id
GROUP BY 
    LB.Branch_Name );

-- Question 8: List all the books (title) and the maximum number of days that they were borrowed.

SELECT 
    B.Title,
    MAX(CASE 
           WHEN BL.Returned_date IS NULL THEN julianday(CURRENT_DATE) - julianday(BL.Date_Out)
           ELSE julianday(BL.Returned_date) - julianday(BL.Date_Out) 
        END) AS MaxDaysBorrowed
FROM 
    BOOK_LOANS BL
JOIN 
    BOOK B ON BL.Book_Id = B.Book_Id
GROUP BY 
    B.Title;

SELECT COUNT(*) AS Rows_Returned FROM ( SELECT 
    B.Title,
    MAX(CASE 
           WHEN BL.Returned_date IS NULL THEN julianday(CURRENT_DATE) - julianday(BL.Date_Out)
           ELSE julianday(BL.Returned_date) - julianday(BL.Date_Out) 
        END) AS MaxDaysBorrowed
FROM 
    BOOK_LOANS BL
JOIN 
    BOOK B ON BL.Book_Id = B.Book_Id
GROUP BY 
    B.Title );

-- Question 9: Create a report for Ethan Martinez with all the books they borrowed. List the book title and
-- author. Also, calculate the number of days each book was borrowed for and if any book is late being
-- returned. Order the results by the date_out.

SELECT 
    B.Title,
    BA.Author_Name,
    BL.Date_Out,
    CASE 
        WHEN BL.Returned_date IS NULL THEN julianday(CURRENT_DATE) - julianday(BL.Date_Out)
        ELSE julianday(BL.Returned_date) - julianday(BL.Date_Out)
    END AS DaysBorrowed,
    CASE 
        WHEN BL.Due_Date < CURRENT_DATE AND BL.Returned_date IS NULL THEN 'Yes'
        ELSE 'No'
    END AS IsLate
FROM 
    BORROWER BR
JOIN 
    BOOK_LOANS BL ON BR.Card_No = BL.Card_No
JOIN 
    BOOK B ON BL.Book_Id = B.Book_Id
JOIN 
    BOOK_AUTHORS BA ON B.Book_Id = BA.Book_Id
WHERE 
    BR.Name = 'Ethan Martinez'
ORDER BY 
    BL.Date_Out;

SELECT COUNT(*) AS Rows_Returned FROM ( SELECT 
    B.Title,
    BA.Author_Name,
    BL.Date_Out,
    CASE 
        WHEN BL.Returned_date IS NULL THEN julianday(CURRENT_DATE) - julianday(BL.Date_Out)
        ELSE julianday(BL.Returned_date) - julianday(BL.Date_Out)
    END AS DaysBorrowed,
    CASE 
        WHEN BL.Due_Date < CURRENT_DATE AND BL.Returned_date IS NULL THEN 'Yes'
        ELSE 'No'
    END AS IsLate
FROM 
    BORROWER BR
JOIN 
    BOOK_LOANS BL ON BR.Card_No = BL.Card_No
JOIN 
    BOOK B ON BL.Book_Id = B.Book_Id
JOIN 
    BOOK_AUTHORS BA ON B.Book_Id = BA.Book_Id
WHERE 
    BR.Name = 'Ethan Martinez'
ORDER BY 
    BL.Date_Out );

-- Question 10: Return the names of all borrowers that borrowed a book from the West Branch include their
-- addresses.

SELECT 
    DISTINCT BR.Name,
    BR.Address
FROM 
    BORROWER BR
JOIN 
    BOOK_LOANS BL ON BR.Card_No = BL.Card_No
JOIN 
    LIBRARY_BRANCH LB ON BL.Branch_Id = LB.Branch_Id
WHERE 
    LB.Branch_Name = 'West Branch';

SELECT COUNT(*) AS Rows_Returned FROM ( SELECT 
    DISTINCT BR.Name,
    BR.Address
FROM 
    BORROWER BR
JOIN 
    BOOK_LOANS BL ON BR.Card_No = BL.Card_No
JOIN 
    LIBRARY_BRANCH LB ON BL.Branch_Id = LB.Branch_Id
WHERE 
    LB.Branch_Name = 'West Branch' );