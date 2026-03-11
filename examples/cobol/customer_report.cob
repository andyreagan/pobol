       IDENTIFICATION DIVISION.
       PROGRAM-ID. CUSTOMER-REPORT.
      *> Reads a customer input file, computes a 10% discount for
      *> anyone whose balance > 1000, writes an output report file.
      *> This demonstrates the file I/O pattern pycobol wraps.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE  ASSIGN TO
               WS-INPUT-PATH
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OUTPUT-FILE ASSIGN TO
               WS-OUTPUT-PATH
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD  INPUT-FILE.
       01  INPUT-RECORD.
           05  IN-CUST-ID     PIC 9(6).
           05  IN-CUST-NAME   PIC X(30).
           05  IN-BALANCE     PIC 9(7)V9(2).

       FD  OUTPUT-FILE.
       01  OUTPUT-RECORD.
           05  OUT-CUST-ID    PIC 9(6).
           05  OUT-CUST-NAME  PIC X(30).
           05  OUT-BALANCE    PIC 9(7)V9(2).
           05  OUT-DISCOUNT   PIC 9(7)V9(2).

       WORKING-STORAGE SECTION.
       01  WS-INPUT-PATH      PIC X(256).
       01  WS-OUTPUT-PATH     PIC X(256).
       01  WS-EOF-FLAG        PIC 9 VALUE 0.
       01  WS-DISCOUNT        PIC 9(7)V9(2).
       01  WS-RECORDS-READ    PIC 9(6) VALUE 0.

       PROCEDURE DIVISION.
       MAIN-PARA.
           ACCEPT WS-INPUT-PATH  FROM ENVIRONMENT "DD_INPUT_FILE"
           ACCEPT WS-OUTPUT-PATH FROM ENVIRONMENT "DD_OUTPUT_FILE"

           OPEN INPUT  INPUT-FILE
           OPEN OUTPUT OUTPUT-FILE

           PERFORM READ-PROCESS UNTIL WS-EOF-FLAG = 1

           CLOSE INPUT-FILE
           CLOSE OUTPUT-FILE

           DISPLAY "RECORDS PROCESSED: " WS-RECORDS-READ
           STOP RUN.

       READ-PROCESS.
           READ INPUT-FILE
               AT END
                   MOVE 1 TO WS-EOF-FLAG
               NOT AT END
                   ADD 1 TO WS-RECORDS-READ
                   PERFORM PROCESS-RECORD
           END-READ.

       PROCESS-RECORD.
           MOVE IN-CUST-ID   TO OUT-CUST-ID
           MOVE IN-CUST-NAME TO OUT-CUST-NAME
           MOVE IN-BALANCE   TO OUT-BALANCE

           IF IN-BALANCE > 1000
               COMPUTE WS-DISCOUNT = IN-BALANCE * 0.10
           ELSE
               MOVE 0 TO WS-DISCOUNT
           END-IF

           MOVE WS-DISCOUNT TO OUT-DISCOUNT
           WRITE OUTPUT-RECORD
           .
