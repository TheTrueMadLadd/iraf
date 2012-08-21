      SUBROUTINE TSTRML	(IERROR)
C
C LATEST REVISION	 JUNE 1984
C
C PURPOSE		 TO PROVIDE A SIMPLE DEMONSTRATION OF
C			 ROUTINE STRMLN.
C
C USAGE			 CALL TSTRML (IERROR)
C
C ARGUMENTS
C
C ON OUTPUT		 IERROR
C			   AN INTEGER VARIABLE
C			   =0 IF THERE IS A NORMAL EXIT	FROM THE
C			      ROUTINE STRMLN.
C			   =1 OTHERWISE
C
C I/O			 IF THERE IS A NORMAL EXIT FROM	THE ROUTINE
C			 STRMLN	THE MESSAGE
C			   STRMLN TEST SUCCESSFUL . . .	SEE PLOT TO
C			   VERIFY PERFORMANCE
C			 IS PRINTED.
C
C PRECISION		 SINGLE
C
C
C LANGUAGE		 FORTRAN
C
C ALGORITHM		 ROUTINE TSTRML	CALLS ROUTINE STRMLN TO
C			 PRODUCE A PLOT	REPRESENTING THE  FLOW AND
C			 MAGNITUDE OF A	VECTOR FIELD.
C
C PORTABILITY		 FORTRAN77
C
C
C
      REAL	      U(21,25)	 ,V(21,25)   ,WRK(1050)
C
C SPECIFY COORDINATES FOR PLOT TITLES.	ON AN ABSTRACT GRID WHERE
C THE INTEGER COORDINATES RANGE	FROM 0.0 TO 1.0, THE VALUES TX AND TY
C DEFINE THE CENTER OF THE TITLE STRING.
C
      DATA TX/.5/,TY/.9765/
C
C     SET DIMENSIONS
C
      DATA NH,NV/21,25/
C
C INITIALIZE ERROR PARAMETER
C
      IERROR = 1
C
C SPECIFY HORIZONTAL AND VERTICAL VECTOR COMPONENTS U AND V ON
C THE RECTANGULAR GRID
C
      TPIMX = 2.*3.14/FLOAT(NH)
      TPJMX = 2.*3.14/FLOAT(NV)
      DO  20 J=1,NV
	 DO  10	I=1,NH
	 U(I,J)	= SIN(TPIMX*(FLOAT(I)-1.))
	 V(I,J)	= SIN(TPJMX*(FLOAT(J)-1.))
   10	 CONTINUE
   20 CONTINUE
C
C SELECT NORMALIZATION TRANSFORMATION 0
C
      CALL GSELNT (0)
C
C CALL WTSTR FOR STRMLN	PLOT TITLE
C
      CALL WTSTR (TX,TY,'DEMONSTRATION PLOT FOR ROUTINE STRMLN',2,
     1		  0,0)
C
C DEFINE NORMALIZATION TRANSFORMATION 1, AND SET UP LOG	SCALING
C
      CALL GSVP	( 1, 0.1, 0.9, 0.1, 0.9	)
      CALL GSWN	( 1, 1.0, 21., 1.0, 25.	)
      CALL SETUSV ( 'LS' , 1 )
C
C SELECT NORMALIZATION TRANSFORMATION 1
C
      CALL GSELNT (1)
C
C     DRAW PERIMETER
C
c     CALL PERIM(1,0,1,0)
C
C CALL STRMLN FOR VECTOR FIELD STREAMLINES PLOT
C
      CALL STRMLN (U,V,WRK,NH,NH,NV,0,IER)
C
c     CALL NEWFM
C
      IERROR = 0
c     WRITE (6,1001)
      RETURN
C
c1001 FORMAT ('	    STRMLN TEST	SUCCESSFUL',24X,
c    1	      'SEE PLOT	TO VERIFY PERFORMANCE')
C
      END