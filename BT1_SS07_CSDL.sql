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

-- Thêm dữ liệu vào bảng Categories
INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Văn học'),
(2, 'Khoa học'),
(3, 'Lịch sử');

-- Thêm dữ liệu vào bảng Books
INSERT INTO Books (book_id, title, author, publication_year, available_quantity, category_id) VALUES
(1, 'Những người khốn khổ', 'Victor Hugo', 1862, 5, 1),
(2, 'Vũ trụ trong vỏ hạt dẻ', 'Stephen Hawking', 2001, 3, 2),
(3, 'Lịch sử Việt Nam', 'Nhiều tác giả', 2020, 7, 3);

-- Thêm dữ liệu vào bảng Readers
INSERT INTO Readers (reader_id, reader_name, phone_number, email) VALUES
(1, 'Nguyễn Văn A', '0987654321', 'a.nguyen@example.com'),
(2, 'Trần Thị B', '0912345678', 'b.tran@example.com'),
(3, 'Lê Văn C', '0978123456', 'c.le@example.com');

-- Thêm dữ liệu vào bảng Borrowing
INSERT INTO Borrowing (borrow_id, reader_id, book_id, borrow_date, due_date) VALUES
(1, 1, 1, '2025-02-01', '2025-02-15'),
(2, 2, 2, '2025-02-03', '2025-02-17'),
(3, 3, 3, '2025-02-05', '2025-02-19');

-- Thêm dữ liệu vào bảng Returning
INSERT INTO Returning (return_id, borrow_id, return_date) VALUES
(1, 1, '2025-02-14'),
(2, 2, '2025-02-16'),
(3, 3, '2025-02-18');

-- Thêm dữ liệu vào bảng Fines
INSERT INTO Fines (fine_id, return_id, fine_amount) VALUES
(1, 1, 0.00),
(2, 2, 5000.00),
(3, 3, 10000.00);

UPDATE Readers
SET phone_number = '0909123456', email = 'bbtranemail@example.com'
WHERE reader_id = 2;

DELETE FROM Books
WHERE book_id = 3;

