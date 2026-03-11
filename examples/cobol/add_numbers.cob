       IDENTIFICATION DIVISION.
       PROGRAM-ID. ADD-NUMBERS.
      *> Reads two numbers from ACCEPT (stdin), adds them,
      *> and DISPLAYs the result to stdout.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-INPUT.
           05  WS-NUM-A       PIC 9(5).
           05  WS-NUM-B       PIC 9(5).
       01  WS-RESULT           PIC 9(6).

       PROCEDURE DIVISION.
           ACCEPT WS-INPUT
           ADD WS-NUM-A TO WS-NUM-B GIVING WS-RESULT
           DISPLAY WS-RESULT
           STOP RUN.
