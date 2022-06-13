 
 /*------------------------------------------------------------------------
    File        : BowlingGameTest.cls
    Purpose     : Test class for BowlingGame.cls
    Syntax      : 
    Description : 
    Author(s)   : zdelcoco
    Created     : Tue Jun 07 15:57:22 CDT 2022
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS BowlingGameTest:
    
  DEFINE PRIVATE VARIABLE oBowlingGame AS CLASS BowlingGame.         

  @Setup.
  METHOD PUBLIC VOID setUp():        
    oBowlingGame = NEW BowlingGame(). 
  END METHOD.

  @TearDown.
  METHOD PUBLIC VOID tearDown():        
    DELETE OBJECT oBowlingGame.
  END METHOD.
  
  METHOD PRIVATE VOID rollMany(INPUT iRolls AS INTEGER, INPUT iPins AS INTEGER):        
    DEFINE VARIABLE itx AS INTEGER NO-UNDO.        
    
    DO itx = 1 TO iRolls:
      oBowlingGame:roll(iPins).
    END.
  END METHOD.
  
  METHOD PRIVATE VOID rollSpare():
    oBowlingGame:roll(5).
    oBowlingGame:roll(5).
  END.
  
  METHOD PRIVATE VOID rollStrike():
    oBowlingGame:roll(10).
  END.
  
  @Test.
  METHOD PUBLIC VOID bowlingGameExists():                   
    RETURN.
  END METHOD.
  
  @Test.
  METHOD PUBLIC VOID canRoll():                          
    oBowlingGame:roll(0).        
  END METHOD.
  
  @Test.
  METHOD PUBLIC VOID gutterGame():                      
    rollMany(20,0).
    OPENEDGE.CORE.ASSERT:EQUALS(0, oBowlingGame:score()).        
  END METHOD.                
  
  @Test.
  METHOD PUBLIC VOID allOnes():
    rollMany(20,1).
    OPENEDGE.CORE.ASSERT:EQUALS(20, oBowlingGame:score()).
  END METHOD.
    
  @Test.
  METHOD PUBLIC VOID oneSpare():
    rollSpare().
    oBowlingGame:roll(3).
    rollMany(17,0).
    OPENEDGE.CORE.ASSERT:EQUALS(16, oBowlingGame:score()).
  END METHOD.   
  
  @Test.
  METHOD PUBLIC VOID oneStrike():
    rollStrike().
    oBowlingGame:roll(3).
    oBowlingGame:roll(4).
    rollMany(16,0).
    OPENEDGE.CORE.ASSERT:EQUALS(24, oBowlingGame:score()).
  END METHOD. 
  
  @Test.
  METHOD PUBLIC VOID perfectGame():
    rollMany(12,10).
    OPENEDGE.CORE.ASSERT:EQUALS(300, oBowlingGame:score()).
  END METHOD.
     
END CLASS.