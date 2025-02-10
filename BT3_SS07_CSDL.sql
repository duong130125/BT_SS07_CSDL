-- Bảng Categories (Thể loại sách)
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL
);

-- Bảng Books (Sách)
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publication_year INT,
    available_quantity INT DEFAULT 0,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) 
);

-- Bảng Readers (Độc giả)
CREATE TABLE Readers (
    reader_id INT PRIMARY KEY AUTO_INCREMENT,
    reader_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(255) UNIQUE
);

-- Bảng Borrowing (Mượn sách)
CREATE TABLE Borrowing (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    reader_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Bảng Returning (Trả sách)
CREATE TABLE Returning (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    borrow_id INT,
    return_date DATE NOT NULL,
    FOREIGN KEY (borrow_id) REFERENCES Borrowing(borrow_id) 
);

-- Bảng Fines (Khoản phạt)
CREATE TABLE Fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    return_id INT,
    fine_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (return_id) REFERENCES Returning(return_id)
);

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Science'),
(2, 'Literature'),
(3, 'History'),
(4, 'Technology'),
(5, 'Psychology');

INSERT INTO Books (book_id, title, author, publication_year, available_quantity, category_id) VALUES
(1, 'The History of Vietnam', 'John Smith', 2001, 10, 1),
(2, 'Python Programming', 'Jane Doe', 2020, 5, 4),
(3, 'Famous Writers', 'Emily Johnson', 2018, 7, 2),
(4, 'Machine Learning Basics', 'Michael Brown', 2022, 3, 4),
(5, 'Psychology and Behavior', 'Sarah Davis', 2019, 6, 5);

INSERT INTO Readers (reader_id, name, phone_number, email) VALUES
(1, 'Alice Williams', '123-456-7890', 'alice.williams@email.com'),
(2, 'Bob Johnson', '987-654-3210', 'bob.johnson@email.com'),
(3, 'Charlie Brown', '555-123-4567', 'charlie.brown@email.com');

INSERT INTO Borrowing (borrow_id, reader_id, book_id, borrow_date, due_date) VALUES
(1, 1, 1, '2025-02-19', '2025-02-15'),
(2, 2, 2, '2025-02-03', '2025-02-17'),
(3, 3, 3, '2025-02-02', '2025-02-16'),
(4, 1, 2, '2025-03-10', '2025-02-24'),
(5, 2, 3, '2025-05-11', '2025-02-25'),
(6, 2, 3, '2025-02-11', '2025-02-25');

INSERT INTO Returning (return_id, borrow_id, return_date) VALUES
(1, 1, '2025-03-14'),
(2, 2, '2025-02-28'),
(3, 3, '2025-02-15'),
(4, 4, '2025-02-20'),  
(5, 4, '2025-02-20');

INSERT INTO Fines (fine_id, return_id, fine_amount) VALUES
(1, 1, 5.00),
(2, 2, 0.00),
(3, 3, 2.00);

SELECT * FROM Books;

SELECT * FROM Readers;

SELECT Readers.reader_name, Books.title, Borrowing.borrow_date
FROM Borrowing
JOIN Readers ON Borrowing.reader_id = Readers.reader_id
JOIN Books ON Borrowing.book_id = Books.book_id;

SELECT Books.title, Books.author, Categories.category_name
FROM Books
JOIN Categories ON Books.category_id = Categories.category_id;

SELECT Readers.reader_name, Fines.fine_amount, Returning.return_date
FROM Fines
JOIN Returning ON Fines.return_id = Returning.return_id
JOIN Borrowing ON Returning.borrow_id = Borrowing.borrow_id
JOIN Readers ON Borrowing.reader_id = Readers.reader_id;

UPDATE Books 
SET available_quantity = 15 
WHERE book_id = 1;

DELETE FROM Readers 
WHERE reader_id = 2;

INSERT INTO Readers (reader_id, reader_name, phone_number, email) 
VALUES (2, 'Bob Johnson', '987-654-3210', 'bob.johnson@email.com');


