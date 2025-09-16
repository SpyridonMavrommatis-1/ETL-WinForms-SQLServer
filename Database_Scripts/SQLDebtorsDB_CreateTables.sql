USE master;
GO

-- Αν υπάρχει ήδη η βάση DebtorsDB
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'DebtorsDB')
BEGIN
    ALTER DATABASE DebtorsDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DebtorsDB;
END
GO

-- Δημιουργία νέας βάσης δεδομένων με όνομα DebtorsDB
CREATE DATABASE DebtorsDB;
GO

-- Επιλογή της βάσης που μόλις δημιουργήθηκε
USE DebtorsDB;
GO

-- Πίνακας για τις Υποθέσεις (Cases)
CREATE TABLE Cases (
    InternalCaseKey NVARCHAR(100) NOT NULL,         -- Εσωτερικό κλειδί υπόθεσης
    LoanType INT NOT NULL CHECK (LoanType IN (1,2)),-- Τύπος δανείου (1=Δάνειο/Factoring, 2=Κάρτα)
    CaseCode NVARCHAR(100) NULL,                    -- Κωδικός υπόθεσης
    ServiceAccount NVARCHAR(100) NOT NULL,          -- Λογαριασμός εξυπηρέτησης
    ProductCode NVARCHAR(100) NOT NULL,             -- Κωδικός προϊόντος

    LoanAmount DECIMAL(18,2) NOT NULL CHECK (LoanAmount >= 0),    -- Αρχικό ποσό δανείου
    RemainingCapital DECIMAL(18,2) NULL CHECK (RemainingCapital >= 0), -- Υπόλοιπο κεφαλαίου
    InterestRate DECIMAL(5,2) NULL CHECK (InterestRate >= 0 AND InterestRate <= 100), -- Επιτόκιο
    OverdueAmount DECIMAL(18,2) NULL CHECK (OverdueAmount >= 0),  -- Ληξιπρόθεσμο ποσό
    StatementBalance DECIMAL(18,2) NULL CHECK (StatementBalance >= 0), -- Υπόλοιπο κατάστασης
    InterestAmount DECIMAL(18,2) NULL CHECK (InterestAmount >= 0),     -- Τόκοι

    AssignmentDate NVARCHAR(50) NOT NULL,           -- Ημερομηνία ανάθεσης
    CaseStatus NVARCHAR(100) NOT NULL,              -- Κατάσταση υπόθεσης
    LoanMaturityDate NVARCHAR(50) NULL,             -- Ημερομηνία λήξης δανείου
    BranchCode NVARCHAR(100) NULL,                  -- Κωδικός καταστήματος
    AssignmentCode INT NULL,                        -- Κωδικός ανάθεσης

    TotalBalance DECIMAL(18,2) NULL CHECK (TotalBalance >= 0), -- Συνολικό υπόλοιπο
    TotalAssignmentBalance DECIMAL(18,2) NULL CHECK (TotalAssignmentBalance >= 0), -- Υπόλοιπο ανάθεσης
    RemainingAssignmentAmount DECIMAL(18,2) NULL CHECK (RemainingAssignmentAmount >= 0),
    OverdueAssignmentAmount DECIMAL(18,2) NULL CHECK (OverdueAssignmentAmount >= 0),
    AvailableSpendingBalance DECIMAL(18,2) NULL CHECK (AvailableSpendingBalance >= 0),

    RecoveryCode NVARCHAR(100) NULL,                -- Κωδικός ανάκτησης
    Bucket INT NULL CHECK (Bucket BETWEEN 0 AND 7), -- Κλάση καθυστέρησης (0-7)
    DaysOverdue INT NULL CHECK (DaysOverdue >= 0),  -- Ημέρες καθυστέρησης
    LoanPurpose NVARCHAR(200) NULL                  -- Σκοπός δανείου
);

-- Πίνακας για τις Πληρωμές (Payments)
-- Καταγράφει πληρωμές που συνδέονται με υποθέσεις
CREATE TABLE Payments (
    InternalCaseKey NVARCHAR(100) NOT NULL,         -- Σύνδεση με υπόθεση
    InternalPaymentKey NVARCHAR(100) NOT NULL,      -- Εσωτερικό κλειδί πληρωμής
    LoanOrCardCode NVARCHAR(100) NOT NULL,          -- Κωδικός δανείου ή κάρτας
    PaymentDate NVARCHAR(50) NOT NULL,              -- Ημερομηνία πληρωμής
    PaymentAmount DECIMAL(18,2) NOT NULL CHECK (PaymentAmount >= 0), -- Ποσό πληρωμής
    AdditionalInfo NVARCHAR(200) NULL               -- Πρόσθετες πληροφορίες
);

-- Πίνακας για τα Πρόσωπα (Persons)
-- Στοιχεία οφειλετών ή εγγυητών
CREATE TABLE Persons (
    InternalPersonKey NVARCHAR(100) NOT NULL,       -- Εσωτερικό κλειδί προσώπου
    CustomerCode NVARCHAR(100) NOT NULL,            -- Κωδικός πελάτη

    LastName NVARCHAR(100) NOT NULL,                -- Επώνυμο
    FirstName NVARCHAR(100) NOT NULL,               -- Όνομα
    FatherName NVARCHAR(100) NOT NULL,              -- Πατρώνυμο

    IdentityNumber NVARCHAR(100) NOT NULL,          -- Αριθμός ταυτότητας
    BirthDate NVARCHAR(50) NOT NULL,                -- Ημερομηνία γέννησης

    Profession NVARCHAR(200) NOT NULL,              -- Επάγγελμα
    AFM NVARCHAR(100) NOT NULL                      -- ΑΦΜ
);

-- Πίνακας για τα Τηλέφωνα (Phones)
-- Επέκταση του Persons με στοιχεία τηλεφώνων
CREATE TABLE Phones (
    InternalPersonKey NVARCHAR(100) NOT NULL,       -- Σύνδεση με πρόσωπο
    CustomerCode NVARCHAR(100) NOT NULL,            -- Κωδικός πελάτη
    PhoneTypeCode NVARCHAR(100) NOT NULL,           -- Τύπος τηλεφώνου
    PhoneNumber NVARCHAR(100) NOT NULL              -- Αριθμός τηλεφώνου
);

-- Πίνακας για τις Σχέσεις (Relations)
-- Συνδέει πρόσωπα με υποθέσεις (π.χ. οφειλέτης, εγγυητής)
CREATE TABLE Relations (
    InternalCaseKey NVARCHAR(100) NOT NULL,         -- Σύνδεση με υπόθεση
    InternalPersonKey NVARCHAR(100) NOT NULL,       -- Σύνδεση με πρόσωπο
    CaseCode NVARCHAR(100) NOT NULL,                -- Κωδικός υπόθεσης
    CustomerCode NVARCHAR(100) NOT NULL,            -- Κωδικός πελάτη
    RelationCode INT NOT NULL,                      -- Ρόλος (π.χ. οφειλέτης, εγγυητής)
    RelationHierarchy INT NOT NULL                  -- Σειρά/ιεραρχία σχέσης
);
