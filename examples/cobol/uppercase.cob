       IDENTIFICATION DIVISION.
       PROGRAM-ID. UPPERCASE.
      *> Reads records from input file, converts name field to
      *> uppercase, writes to output file.
      *> Demonstrates a simple transformation pattern.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE  ASSIGN TO WS-INPUT-PATH
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OUTPUT-FILE ASSIGN TO WS-OUTPUT-PATH
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD  INPUT-FILE.
       01  INPUT-RECORD.
           05  IN-ID          PIC 9(4).
           05  IN-NAME        PIC X(20).

       FD  OUTPUT-FILE.
       01  OUTPUT-RECORD.
           05  OUT-ID         PIC 9(4).
           05  OUT-NAME       PIC X(20).

       WORKING-STORAGE SECTION.
       01  WS-INPUT-PATH      PIC X(256).
       01  WS-OUTPUT-PATH     PIC X(256).
       01  WS-EOF-FLAG        PIC 9 VALUE 0.

       PROCEDURE DIVISION.
       MAIN-PARA.
           ACCEPT WS-INPUT-PATH  FROM ENVIRONMENT "DD_INPUT_FILE"
           ACCEPT WS-OUTPUT-PATH FROM ENVIRONMENT "DD_OUTPUT_FILE"

           OPEN INPUT  INPUT-FILE
           OPEN OUTPUT OUTPUT-FILE

           PERFORM READ-PROCESS UNTIL WS-EOF-FLAG = 1

           CLOSE INPUT-FILE
           CLOSE OUTPUT-FILE
           STOP RUN.

       READ-PROCESS.
           READ INPUT-FILE
               AT END
                   MOVE 1 TO WS-EOF-FLAG
               NOT AT END
                   PERFORM PROCESS-RECORD
           END-READ.

       PROCESS-RECORD.
           MOVE IN-ID TO OUT-ID
           MOVE FUNCTION UPPER-CASE(IN-NAME) TO OUT-NAME
           WRITE OUTPUT-RECORD
           .
