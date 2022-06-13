 
 /*------------------------------------------------------------------------
    File        : BowlingGame.cls
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : zdelcoco
    Created     : Tue Jun 07 16:00:13 CDT 2022
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS BowlingGame: 
    
  DEFINE PRIVATE VARIABLE iRolls       AS INTEGER EXTENT 21 NO-UNDO.
  DEFINE PRIVATE VARIABLE iCurrentRoll AS INTEGER INITIAL 0 NO-UNDO.

  CONSTRUCTOR PUBLIC BowlingGame():
    SUPER ().      
  END CONSTRUCTOR.  
  
  METHOD PRIVATE LOGICAL isSpare(INPUT ipiFirstInFrame AS INTEGER):
    RETURN iRolls[ipiFirstInFrame] + iRolls[ipiFirstInFrame + 1] = 10.
  END METHOD.
  
  METHOD PRIVATE LOGICAL isStrike(INPUT ipiFirstInFrame AS INTEGER):
    RETURN iRolls[ipiFirstInFrame] = 10.
  END METHOD.
  
  METHOD PRIVATE INTEGER calculateFrameScore(INPUT ipiFirstInFrame AS INTEGER):
    RETURN iRolls[ipiFirstInFrame] + iRolls[ipiFirstInFrame + 1].
  END METHOD.
  
  METHOD PRIVATE INTEGER calculateSpareScore(INPUT ipiFirstInFrame AS INTEGER):
    RETURN 10 + iRolls[ipiFirstInFrame + 2].
  END METHOD.
  
  METHOD PRIVATE INTEGER calculateStrikeScore(INPUT ipiFirstInFrame AS INTEGER):
    RETURN 10 + iRolls[ipiFirstInFrame + 1] + iRolls[ipiFirstInFrame + 2].
  END METHOD.
  
  METHOD PUBLIC VOID roll(INPUT pins AS INTEGER):    
    iCurrentRoll = iCurrentRoll + 1.
    iRolls[iCurrentRoll] = pins.    
  END METHOD.
  
  METHOD PUBLIC INTEGER score():
    DEFINE VARIABLE itx           AS INTEGER INITIAL 1 NO-UNDO.
    DEFINE VARIABLE iFirstInFrame AS INTEGER INITIAL 1 NO-UNDO.
    DEFINE VARIABLE iFrame        AS INTEGER EXTENT 10 NO-UNDO.
    DEFINE VARIABLE iScore        AS INTEGER INITIAL 0 NO-UNDO.          
        
    DO itx = 1 TO EXTENT(iFrame):   
      IF isStrike(iFirstInFrame) THEN
      DO:
        iScore = iScore + calculateStrikeScore(iFirstInFrame).
        iFirstInFrame = iFirstInFrame + 1.
      END.   
      ELSE IF isSpare(iFirstInFrame) THEN
      DO:
        iScore = iScore + calculateSpareScore(iFirstInFrame).
        iFirstInFrame = iFirstInFrame + 2. 
      END.
      ELSE
      DO:
        iScore = iScore + calculateFrameScore(iFirstInFrame).
        iFirstInFrame = iFirstInFrame + 2. 
      END.                          
    END.    
    
    RETURN iScore.
    
  END METHOD.
  
  DESTRUCTOR PUBLIC BowlingGame():
  END DESTRUCTOR.

END CLASS.