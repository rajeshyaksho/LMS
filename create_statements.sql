-- Table: BOOK
CREATE TABLE BOOK (
    Book_Id INTEGER PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Publisher_name VARCHAR(200),
    FOREIGN KEY (Publisher_name) REFERENCES PUBLISHER(Publisher_Name) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: BOOK_AUTHORS
CREATE TABLE BOOK_AUTHORS (
    Book_Id INTEGER,
    Author_Name VARCHAR(200) NOT NULL,
    PRIMARY KEY (Book_Id, Author_Name),
    FOREIGN KEY (Book_Id) REFERENCES BOOK(Book_Id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: PUBLISHER
CREATE TABLE PUBLISHER (
    Publisher_Name VARCHAR(200) PRIMARY KEY,
    Address VARCHAR(200) NOT NULL,
    Phone VARCHAR(15) NOT NULL
);

-- Table: BOOK_COPIES
CREATE TABLE BOOK_COPIES (
    Book_Id INTEGER,
    Branch_Id INTEGER,
    No_Of_Copies INTEGER NOT NULL,
    PRIMARY KEY (Book_Id, Branch_Id),
    FOREIGN KEY (Book_Id) REFERENCES BOOK(Book_Id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Branch_Id) REFERENCES LIBRARY_BRANCH(Branch_Id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: BOOK_LOANS
CREATE TABLE BOOK_LOANS (
    Book_Id INTEGER,
    Branch_Id INTEGER,
    Card_No INTEGER,
    Date_Out DATE NOT NULL,
    Due_Date DATE NOT NULL,
    Returned_date DATE,
    PRIMARY KEY (Book_Id, Branch_Id, Card_No),
    FOREIGN KEY (Book_Id) REFERENCES BOOK(Book_Id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Branch_Id) REFERENCES LIBRARY_BRANCH(Branch_Id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Card_No) REFERENCES BORROWER(Card_No) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: LIBRARY_BRANCH
CREATE TABLE LIBRARY_BRANCH (
    Branch_Id INTEGER PRIMARY KEY,
    Branch_Name VARCHAR(200) NOT NULL,
    Branch_Address VARCHAR(200) NOT NULL
);

-- Table: BORROWER
CREATE TABLE BORROWER (
    Card_No INTEGER PRIMARY KEY,
    Name VARCHAR(200) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    Phone VARCHAR(15) NOT NULL
);