# cse3330-project-2

Introduction:
 The Library Management System Database project aims to design and implement a robust
 database system to efficiently manage the operations of a library. This project addresses the
 need for a comprehensive database that integrates book information, borrower details, and
 library branch management, facilitating day-to-day operations and enhancing user
 experience.
 
 Mini-World Description:
 In this mini world, we envision a library setting where books, borrowers, publishers, and
 library branches interact to facilitate the borrowing and return of books. Here's an overview of
 the key components and their interactions within this mini world.
 
 Entities:
 Book
 Represents individual books in the library's collection.
 Each book is uniquely identified by an "IdNo."
 Contains attributes like "Title," "Author," and "Publisher."
 Publisher
 Represents companies or entities that publish books.
 Each publisher has attributes such as "Name," "Phone Number," and "Address."
 LibraryBranch
 Represents physical branches of the library system.
 Each branch is identified by a unique "BranchID" and has attributes like "Name" and
 "Address."
 BookCopy
 Represents physical copies of books available in library branches.
 Associated with a specific "Book" and "LibraryBranch."
 Borrower
 Represents individuals who borrow books from the library.
 Each borrower has a unique "CardNo." and attributes including "Name," "Address," and
 "Phone Number."
 Operations
 In this mini-world, typical library operations include
Borrowing books by "Borrowers."--
 Cataloging books by "Title," "Author," and "Publisher."
 Managing book copies at different "LibraryBranches."
 

Assumed Assumptions and Missing/Incomplete Requirements:
 Based on the requirements, the following are some missing or incomplete requirements:
 ● The requirements do not specify how many copies of a book can be checked out at a
 time.
 ● Therequirements do not specify what happens if a book is not returned on time.
 ● Therequirements do not specify how a borrower can renew a book.
 ● Therequirements do not specify how a borrower can return a book.
 The following are some assumptions that were made that were not part of the requirements:
 ● Eachauthor has a unique name.
 ● Eachpublisher has a unique name.
 ● Eachborrower has a unique card number.
 ● Borrowers can check out multiple copies of books
 ● Library branches have multiple copies of books

EXPLANATIONS:
 Book Authors has been implemented as a separate table so as to make future changes in
 names of authors consistent (using referential triggers on the implementational level).
 Book loans is a table that relates multiple tables to keep track of book copies borrowed- this
 enables one borrower to to borrow multiple copies of books.
